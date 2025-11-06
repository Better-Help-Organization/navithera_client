import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/feature/auth/presentation/providers/user_provider.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/group_chat_creation_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/message_screen.dart';
import '../providers/users_provider.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  const UsersListScreen({super.key});

  @override
  ConsumerState<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends ConsumerState<UsersListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).getUsers();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = ref.read(usersProvider);
      if (state is Loaded && state.canLoadMore) {
        ref.read(usersProvider.notifier).getUsers(loadMore: true);
      }
    }
  }

  Future<void> _handleRefresh() async {
    await ref.read(usersProvider.notifier).getUsers();
  }

  Future<void> _createAndNavigateToChat(String clientId) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get current user'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const Center(
              child: CircularProgressIndicator(color: Color(0xFF7EB09B)),
            ),
      );

      final chatRepository = ref.read(chatRepositoryProvider);
      final result = await chatRepository.createChat(
        clientId: clientId,
        therapistId: currentUser.id,
      );

      // Hide loading indicator
      Navigator.of(context).pop();

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create chat: ${failure.message}'),
              backgroundColor: Colors.red,
            ),
          );
        },
        (chatData) {
          print("${chatData['id']?.toString()} the chat id");
          // Navigate to chat screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChatMessageScreen(
                    chat: Chat(
                      id: chatData['id']?.toString() ?? '',
                      name: "Client",
                      lastMessage: 'I sent you the design files 📎',
                      avatarUrl:
                          'https://randomuser.me/api/portraits/women/2.jpg',
                      unreadCount: 0,
                      timestamp: DateTime(2025, 4, 2, 14, 15),
                      isOutgoing: true,
                      isRead: true,
                    ),
                  ),
            ),
          );
        },
      );
    } catch (e) {
      // Hide loading indicator if still showing
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating chat: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);
    final router = ref.read(routerProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Therapists',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.grey[100],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary, // Use your app's primary color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        onPressed: () {
          // Navigate to the screen where users can start a new chat
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UsersListScreen()),
          // );
          // router.push("/clients");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GroupChatCreationScreen(),
            ),
          );
        },
        child: const Icon(Icons.group_add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: const Color(0xFF7EB09B),
        child: switch (usersState) {
          Initial() => const Center(
            child: Text(
              'No therapists available',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Loading() => const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF7EB09B),
              ),
            ),
          ),
          Error(:final failure) => Center(
            child: Text(
              'Error loading therapists',
              style: TextStyle(fontSize: 14, color: Colors.red[400]),
            ),
          ),
          Loaded(:final users, :final canLoadMore) => ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: users.length + (canLoadMore ? 1 : 0),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              if (index == users.length) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF7EB09B),
                      ),
                    ),
                  ),
                );
              }
              final user = users[index];
              return _buildUserCard(user);
            },
          ),
          UsersState() => throw UnimplementedError(),
        },
      ),
    );
  }

  Widget _buildUserCard(user) {
    final initials =
        '${user.firstName?.substring(0, 1) ?? ''}${user.lastName?.substring(0, 1) ?? ''}'
            .toUpperCase();
    final userName = '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    final userEmail = user.email ?? 'No email';

    // Generate a subtle color based on user name
    final colors = [
      const Color(0xFF7EB09B),
      const Color(0xFF4A90E2),
      const Color(0xFF9B59B6),
      const Color(0xFFE67E22),
    ];
    final colorIndex = userName.hashCode % colors.length;
    final avatarColor = colors[colorIndex.abs()];

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 0.5),
      ),
      child: Row(
        children: [
          // Compact avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: avatarColor.withOpacity(0.3), width: 1),
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  color: avatarColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'Unknown User',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  userEmail,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Compact chat button
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => _createAndNavigateToChat(user.id),
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 14,
                color: avatarColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
