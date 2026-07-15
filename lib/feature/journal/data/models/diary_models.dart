import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'diary_models.freezed.dart';
part 'diary_models.g.dart';

@freezed
class DiaryListResponse with _$DiaryListResponse {
  const factory DiaryListResponse({
    required List<DiaryEntry> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _DiaryListResponse;

  factory DiaryListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryListResponseFromJson(json);
}

@freezed
class DiaryEntry with _$DiaryEntry {
  const factory DiaryEntry({
    required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    required String title,
    required String content,
    DateTime? deletedAt,
    // UserModel? client,
  }) = _DiaryEntry;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);
}

@freezed
class DiaryCreateResponse with _$DiaryCreateResponse {
  const factory DiaryCreateResponse({
    required DiaryEntry data,
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _DiaryCreateResponse;

  factory DiaryCreateResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryCreateResponseFromJson(json);
}

// For PATCH responses that return a string instead of DiaryEntry
@freezed
class DiaryUpdateResponse with _$DiaryUpdateResponse {
  const factory DiaryUpdateResponse({
    required DiaryEntry data, // Changed from String to DiaryEntry
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _DiaryUpdateResponse;

  factory DiaryUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryUpdateResponseFromJson(json);
}

@freezed
class DiaryEditResponse with _$DiaryEditResponse {
  const factory DiaryEditResponse({
    required DiaryEntry data, // Changed from String to DiaryEntry
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _DiaryEditResponse;

  factory DiaryEditResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryEditResponseFromJson(json);
}

// Helper function to handle both string and object responses
String _parseUpdateData(dynamic data) {
  if (data is String) {
    return data;
  } else if (data is Map<String, dynamic>) {
    // If it's a DiaryEntry object, we'll just return the ID as string
    return data['id']?.toString() ?? 'Unknown ID';
  }
  return data.toString();
}

// For DELETE responses
@freezed
class DiaryDeleteResponse with _$DiaryDeleteResponse {
  const factory DiaryDeleteResponse({
    required String message,
    required int statusCode,
    required String method,
    required String path,
    required DateTime timestamp,
  }) = _DiaryDeleteResponse;

  factory DiaryDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$DiaryDeleteResponseFromJson(json);
}
