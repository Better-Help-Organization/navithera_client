// notification_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
class NotificationListResponse with _$NotificationListResponse {
  const factory NotificationListResponse({
    required List<NotificationItem> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _NotificationListResponse;

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseFromJson(json);
}

@freezed
class NotificationItem with _$NotificationItem {
  const factory NotificationItem({
    required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    required String title,
    required String body,
    required String? message,
    required String code,
    UserModel? client,
    String? profile,
    @JsonKey(ignore: true) @Default(false) bool isRead,
    @JsonKey(ignore: true) @Default(false) bool isExpanded,
  }) = _NotificationItem;

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
