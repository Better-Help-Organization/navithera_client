import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/constants/base_url.dart';
import '../../../../core/util/avatar_util.dart';
import '../../../auth/presentation/providers/user_provider.dart';
import '../providers/ai_chat_provider.dart';
import '../../data/models/ai_chat_models.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      ref.read(aiChatProvider.notifier).sendMessage(message);
      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatProvider);

    // Auto-scroll to bottom when new messages are added
    ref.listen<AiChatState>(aiChatProvider, (previous, next) {
      if (previous != null && next.messages.length > previous.messages.length) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Chat with Navi',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showClearChatDialog();
            },
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Column(
        children: [
          // Usage Info Banner
          if (chatState.usageInfo != null)
            _buildUsageInfoBanner(chatState.usageInfo!),

          // Messages List
          Expanded(
            child:
                chatState.messages.isEmpty
                    ? const _EmptyState()
                    : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: chatState.messages.length,
                      itemBuilder: (context, index) {
                        final message = chatState.messages[index];
                        return _MessageBubble(
                          message: message,
                          user: ref.watch(currentUserProvider),
                          onRetry:
                              message.error != null
                                  ? () =>
                                      ref
                                          .read(aiChatProvider.notifier)
                                          .retryLastMessage()
                                  : null,
                        );
                      },
                    ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: chatState.isLoading ? null : _sendMessage,
                      icon:
                          chatState.isLoading
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Chat'),
          content: const Text(
            'Are you sure you want to clear all messages? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(aiChatProvider.notifier).clearChat();
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUsageInfoBanner(UsageInfo usageInfo) {
    // Only show banner if approaching limit or at limit
    if (!usageInfo.isApproachingLimit && usageInfo.remaining > 0) {
      return const SizedBox.shrink();
    }

    final isAtLimit = usageInfo.remaining == 0;
    final color = isAtLimit ? Colors.red : Colors.orange;
    final icon = isAtLimit ? Icons.block : Icons.warning;

    String message;
    if (isAtLimit) {
      final hours = usageInfo.timeUntilReset.inHours;
      final minutes = usageInfo.timeUntilReset.inMinutes % 60;
      message =
          'Daily limit reached (${usageInfo.used}/${usageInfo.total}). Resets in ${hours}h ${minutes}m';
    } else {
      message =
          '${usageInfo.remaining} queries left today (${usageInfo.used}/${usageInfo.total} used)';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color.withOpacity(0.1),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            height: 240,
            child: Lottie.asset(
              'assets/animations/Navi.json',
              width: 240,
              height: 240,
              fit: BoxFit.contain,
              repeat: true,
              animate: true,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Meet Navi',
            style: AppTypography.heading2.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 4),
          Text(
            'Your AI Therapy Assistant',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Start a conversation with Navi, your personal AI therapy assistant. Share your thoughts, feelings, and get supportive guidance on your therapy journey.',
              style: AppTypography.bodySmall.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onRetry;
  final dynamic user;

  const _MessageBubble({required this.message, this.onRetry, this.user});

  @override
  Widget build(BuildContext context) {
    if (message.isLoading) {
      return _buildLoadingBubble();
    }

    if (message.error != null) {
      return _buildErrorBubble();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[_buildAvatar(false, user)],
          Flexible(
            child: Transform.translate(
              offset:
                  message.isUser
                      ? const Offset(0, 0)
                      : const Offset(-10, 0), // Move AI bubbles left
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: message.isUser ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(16).copyWith(
                    bottomLeft:
                        message.isUser
                            ? const Radius.circular(16)
                            : const Radius.circular(4),
                    bottomRight:
                        message.isUser
                            ? const Radius.circular(4)
                            : const Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Linkify(
                  onOpen: (link) async {
                    final uri = Uri.parse(link.url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  text: message.content,
                  style: AppTypography.bodyMedium.copyWith(
                    color: message.isUser ? Colors.white : Colors.black87,
                  ),
                  linkStyle: AppTypography.bodyMedium.copyWith(
                    color: message.isUser ? Colors.white : AppColors.primary,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            _buildAvatar(true, user),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(false, user),
          const SizedBox(width: 8),
          Transform.translate(
            offset: const Offset(-10, 0), // Move loading bubble left
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  16,
                ).copyWith(bottomLeft: const Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 68,
                    height: 68,
                    child: Lottie.asset(
                      'assets/animations/Navi.json',
                      width: 68,
                      height: 68,
                      fit: BoxFit.contain,
                      repeat: true,
                      animate: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Navi is thinking...',
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBubble() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatar(false, user),
          const SizedBox(width: 8),
          Flexible(
            child: Transform.translate(
              offset: const Offset(-10, 0), // Move error bubble left
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(
                    16,
                  ).copyWith(bottomLeft: const Radius.circular(4)),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red[600],
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Failed to send message',
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.red[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message.error!,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.red[700],
                      ),
                    ),
                    if (onRetry != null) ...[
                      const SizedBox(height: 12),
                      TextButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Retry'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red[600],
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser, dynamic user) {
    if (isUser) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child:
            (user?.avatar == 7) &&
                    (user?.profile != null && user!.profile!.isNotEmpty)
                ? Image(
                  image: NetworkImage(
                    '${base_url_for_image}${user.profile}?v=${DateTime.now().millisecondsSinceEpoch}',
                  ),
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image(
                      image: AssetImage(getAvatarImage(user.avatar ?? 0)),
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    );
                  },
                )
                : Image(
                  image: AssetImage(getAvatarImage(user?.avatar ?? 0)),
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
      );
    } else {
      // Just show Navi without any circular container
      return Transform.translate(
        offset: const Offset(
          -10,
          2,
        ), // Adjust these values to fine-tune position
        child: Container(
          // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          width: 54,
          height: 54,
          child: Lottie.asset(
            'assets/animations/Navi.json',
            width: 44,
            height: 44,
            fit: BoxFit.contain,
            repeat: true,
            animate: true,
          ),
        ),
      );
    }
  }

  Widget _buildUsageInfoBanner(UsageInfo usageInfo) {
    // Only show banner if approaching limit or at limit
    if (!usageInfo.isApproachingLimit && usageInfo.remaining > 0) {
      return const SizedBox.shrink();
    }

    final isAtLimit = usageInfo.remaining == 0;
    final color = isAtLimit ? Colors.red : Colors.orange;
    final icon = isAtLimit ? Icons.block : Icons.warning;

    String message;
    if (isAtLimit) {
      final hours = usageInfo.timeUntilReset.inHours;
      final minutes = usageInfo.timeUntilReset.inMinutes % 60;
      message =
          'Daily limit reached (${usageInfo.used}/${usageInfo.total}). Resets in ${hours}h ${minutes}m';
    } else {
      message =
          '${usageInfo.remaining} queries left today (${usageInfo.used}/${usageInfo.total} used)';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color.withOpacity(0.1),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySmall.copyWith(
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
