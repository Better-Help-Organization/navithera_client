// chat_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
//import 'user_model.dart'; // Reusing your existing UserModel

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
class ChatListResponse with _$ChatListResponse {
  const factory ChatListResponse({
    required List<ChatThread> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
  }) = _ChatListResponse;

  factory ChatListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatListResponseFromJson(json);
}

@freezed
class ChatThread with _$ChatThread {
  const factory ChatThread({
    required String id,
    // required DateTime createdAt,
    DateTime? updatedAt,
    required UserModel? client, // Make client nullable
    required List<UserModel> group, // Add group list
    required UserModel therapist,
    // required List<ChatMessage> message,
    List<ChatMessage>? message,
    ChatMessage? lastMessage,
    int? unreadCount,
    String? groupName,
  }) = _ChatThread;

  factory ChatThread.fromJson(Map<String, dynamic> json) =>
      _$ChatThreadFromJson(json);
}

@freezed
class ChatMessageResponse with _$ChatMessageResponse {
  const factory ChatMessageResponse({
    required List<ChatMessageDetail> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
  }) = _ChatMessageResponse;

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);
}

@freezed
class ChatMessageDetail with _$ChatMessageDetail {
  const factory ChatMessageDetail({
    required String id,
    required String content,
    required DateTime createdAt,
    required UserModel? therapist,
    required UserModel? client,
    DateTime? updatedAt,
    ChatMessage? lastMessage,
    bool? isRead,

    // UI-only fields (ignored by JSON)
    @JsonKey(ignore: true) @Default(false) bool isPending,
    @JsonKey(ignore: true) @Default(false) bool isFailed,
    @JsonKey(ignore: true) String? localId,
  }) = _ChatMessageDetail;

  factory ChatMessageDetail.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDetailFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String content,
    required DateTime createdAt,
    // required String senderId,
    bool? isRead,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

@freezed
class MessageSendResponse with _$MessageSendResponse {
  const factory MessageSendResponse({
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _MessageSendResponse;

  factory MessageSendResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageSendResponseFromJson(json);
}

@freezed
class GroupChatCreateResponse with _$GroupChatCreateResponse {
  const factory GroupChatCreateResponse({
    required GroupChatData data,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _GroupChatCreateResponse;

  factory GroupChatCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupChatCreateResponseFromJson(json);
}

@freezed
class GroupChatData with _$GroupChatData {
  const factory GroupChatData({
    required List<UserModel>? group,
    required UserModel? client,
    required UserModel? therapist,
    required DateTime? updatedAt,
    required String id,
    required DateTime createdAt,
    required DateTime? deletedAt,

    ChatMessage? lastMessage,
  }) = _GroupChatData;

  factory GroupChatData.fromJson(Map<String, dynamic> json) =>
      _$GroupChatDataFromJson(json);
}

@freezed
class TherapistInfoResponse with _$TherapistInfoResponse {
  const factory TherapistInfoResponse({
    required UserModel data,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _TherapistInfoResponse;

  factory TherapistInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TherapistInfoResponseFromJson(json);
}

@freezed
class MarkAsReadResponse with _$MarkAsReadResponse {
  const factory MarkAsReadResponse({
    required MarkAsReadData data,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _MarkAsReadResponse;

  factory MarkAsReadResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkAsReadResponseFromJson(json);
}

@freezed
class MarkAsReadData with _$MarkAsReadData {
  const factory MarkAsReadData({
    required bool success,
    required String message,
  }) = _MarkAsReadData;

  factory MarkAsReadData.fromJson(Map<String, dynamic> json) =>
      _$MarkAsReadDataFromJson(json);
}
