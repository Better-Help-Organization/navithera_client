// feature/home/data/models/live_session_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';

part 'live_session_models.freezed.dart';
part 'live_session_models.g.dart';

@freezed
class ChatListResponse with _$ChatListResponse {
  const factory ChatListResponse({
    required List<ChatItem> data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  }) = _ChatListResponse;

  factory ChatListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatListResponseFromJson(json);
}

@freezed
class ChatItem with _$ChatItem {
  const factory ChatItem({
    required String id,
    String? activeCallRoom,
    String? groupName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<UserModel>? group,
    LastMessage? lastMessage,
    @Default(0) int unreadCount,
  }) = _ChatItem;

  factory ChatItem.fromJson(Map<String, dynamic> json) =>
      _$ChatItemFromJson(json);
}

@freezed
class LastMessage with _$LastMessage {
  const factory LastMessage({
    String? id,
    String? content,
    bool? isRead,
    UserModel? client,
    UserModel? therapist,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    int? totalItems,
    int? totalPages,
    int? currentPage,
    int? pageSize,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

@freezed
class JoinCallResponse with _$JoinCallResponse {
  const factory JoinCallResponse({
    JoinCallData? data,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  }) = _JoinCallResponse;

  factory JoinCallResponse.fromJson(Map<String, dynamic> json) =>
      _$JoinCallResponseFromJson(json);
}

@freezed
class JoinCallData with _$JoinCallData {
  const factory JoinCallData({required String token, required String room}) =
      _JoinCallData;

  factory JoinCallData.fromJson(Map<String, dynamic> json) =>
      _$JoinCallDataFromJson(json);
}
