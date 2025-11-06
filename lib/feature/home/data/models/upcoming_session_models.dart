// upcoming_session_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'upcoming_session_models.freezed.dart';
part 'upcoming_session_models.g.dart';

@freezed
class SessionListResponse with _$SessionListResponse {
  const factory SessionListResponse({
    required List<SessionItem> data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  }) = _SessionListResponse;

  factory SessionListResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionListResponseFromJson(json);
}

@freezed
class SessionItem with _$SessionItem {
  const factory SessionItem({
    required String id,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime schedule,
    String? approvalStatus,
    @JsonKey(name: 'hasTherapistAttended', fromJson: _boolFromJson)
    bool? hasTherapistAttended,
    @JsonKey(name: 'hasclientAttended', fromJson: _boolFromJson)
    bool? hasClientAttended,
    int? duration,
    String? type,
    String? note,
    @JsonKey(fromJson: _userFromJson, toJson: _userToJson)
    UserModel? client, // This is the client info, not therapist
    // Add therapist field if it exists in other responses
    @JsonKey(fromJson: _userFromJson, toJson: _userToJson) UserModel? therapist,
  }) = _SessionItem;

  factory SessionItem.fromJson(Map<String, dynamic> json) =>
      _$SessionItemFromJson(json);
}

DateTime _dateTimeFromJson(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is String) return DateTime.parse(value);
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  return DateTime.now();
}

String _dateTimeToJson(DateTime value) => value.toIso8601String();

bool? _boolFromJson(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value.toLowerCase() == 'true';
  return null;
}

UserModel? _userFromJson(dynamic value) {
  if (value is Map<String, dynamic>) {
    try {
      return UserModel.fromJson(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}

Map<String, dynamic>? _userToJson(UserModel? user) => user?.toJson();
