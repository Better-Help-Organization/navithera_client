import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_models.freezed.dart';
part 'ai_chat_models.g.dart';

@freezed
class AiChatRequest with _$AiChatRequest {
  const factory AiChatRequest({required String query}) = _AiChatRequest;

  factory AiChatRequest.fromJson(Map<String, dynamic> json) =>
      _$AiChatRequestFromJson(json);
}

@freezed
class AiChatResponse with _$AiChatResponse {
  const factory AiChatResponse({
    required bool success,
    @Default([]) List<String> errors,
    @Default([]) List<String> messages,
    required AiChatResult result,
  }) = _AiChatResponse;

  factory AiChatResponse.fromJson(Map<String, dynamic> json) =>
      _$AiChatResponseFromJson(json);
}

@freezed
class AiChatResult with _$AiChatResult {
  const factory AiChatResult({required String response}) = _AiChatResult;

  factory AiChatResult.fromJson(Map<String, dynamic> json) =>
      _$AiChatResultFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required bool isUser,
    required DateTime timestamp,
    @Default(false) bool isLoading,
    String? error,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

@freezed
class UsageInfo with _$UsageInfo {
  const factory UsageInfo({
    required int remaining,
    required int used,
    required int total,
    required bool isApproachingLimit,
    required Duration timeUntilReset,
  }) = _UsageInfo;

  factory UsageInfo.fromJson(Map<String, dynamic> json) =>
      _$UsageInfoFromJson(json);
}

// Helper methods for creating messages
class ChatMessageFactory {
  static ChatMessage user(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  static ChatMessage ai(String content) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  static ChatMessage loading() {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '',
      isUser: false,
      timestamp: DateTime.now(),
      isLoading: true,
    );
  }

  static ChatMessage error(String errorMessage) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '',
      isUser: false,
      timestamp: DateTime.now(),
      error: errorMessage,
    );
  }
}
