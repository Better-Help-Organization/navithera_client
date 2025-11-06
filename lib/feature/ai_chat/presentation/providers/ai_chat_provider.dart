import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/data_sources/ai_chat_remote_data_source.dart';
import '../../data/models/ai_chat_models.dart';

part 'ai_chat_provider.freezed.dart';

@freezed
class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default([]) List<ChatMessage> messages,
    @Default(false) bool isLoading,
    String? error,
    UsageInfo? usageInfo,
  }) = _AiChatState;
}

final aiChatServiceProvider = Provider<AiChatService>((ref) {
  return AiChatService();
});

final aiChatProvider = StateNotifierProvider<AiChatNotifier, AiChatState>((
  ref,
) {
  final service = ref.watch(aiChatServiceProvider);
  return AiChatNotifier(service);
});

class AiChatNotifier extends StateNotifier<AiChatState> {
  final AiChatService _service;

  AiChatNotifier(this._service) : super(const AiChatState()) {
    _initializeChat();
    _loadUsageInfo();
  }

  void _initializeChat() {
    // Add welcome message
    final welcomeMessage = ChatMessageFactory.ai(
      "Hello! I'm Navi, your AI therapy assistant. How are you feeling today? I'm here to listen and support you on your therapy journey.",
    );
    state = state.copyWith(messages: [welcomeMessage]);
  }

  Future<void> _loadUsageInfo() async {
    try {
      final usageInfo = await _service.getUsageInfo();
      state = state.copyWith(usageInfo: usageInfo);
    } catch (e) {
      // Handle error silently, usage info is not critical
      print('Failed to load usage info: $e');
    }
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessageFactory.user(content);
    final loadingMessage = ChatMessageFactory.loading();

    state = state.copyWith(
      messages: [...state.messages, userMessage, loadingMessage],
      isLoading: true,
      error: null,
    );

    try {
      // Send message to AI service
      final response = await _service.sendMessage(content);

      // Remove loading message and add AI response
      final messagesWithoutLoading =
          state.messages.where((msg) => !msg.isLoading).toList();

      final aiMessage = ChatMessageFactory.ai(response.result.response);

      state = state.copyWith(
        messages: [...messagesWithoutLoading, aiMessage],
        isLoading: false,
      );

      // Update usage info after successful message
      await _loadUsageInfo();
    } catch (e) {
      // Remove loading message and add error message
      final messagesWithoutLoading =
          state.messages.where((msg) => !msg.isLoading).toList();

      final errorMessage = ChatMessageFactory.error(e.toString());

      state = state.copyWith(
        messages: [...messagesWithoutLoading, errorMessage],
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearChat() {
    state = const AiChatState();
    _initializeChat();
  }

  void retryLastMessage() {
    final messages = state.messages;
    if (messages.isEmpty) return;

    // Find the last user message
    for (int i = messages.length - 1; i >= 0; i--) {
      if (messages[i].isUser) {
        final userMessage = messages[i];
        // Remove all messages after the last user message
        final filteredMessages = messages.take(i + 1).toList();
        state = state.copyWith(messages: filteredMessages);
        // Resend the message
        sendMessage(userMessage.content);
        break;
      }
    }
  }
}
