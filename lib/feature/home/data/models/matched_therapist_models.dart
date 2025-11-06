// matched_therapist_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'matched_therapist_models.freezed.dart';
part 'matched_therapist_models.g.dart';

@freezed
class MatchListResponse with _$MatchListResponse {
  const factory MatchListResponse({
    required List<MatchItem> data,
    Pagination? pagination,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    DateTime? timestamp,
  }) = _MatchListResponse;

  factory MatchListResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchListResponseFromJson(json);
}

@freezed
class MatchItem with _$MatchItem {
  const factory MatchItem({
    required String id,
    UserModel? accepted,
    @Default(null) dynamic client, // keep flexible
    DateTime? createdAt,
  }) = _MatchItem;

  factory MatchItem.fromJson(Map<String, dynamic> json) =>
      _$MatchItemFromJson(json);
}
