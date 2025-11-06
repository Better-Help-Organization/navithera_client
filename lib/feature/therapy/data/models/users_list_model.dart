import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';

part 'users_list_model.freezed.dart';
part 'users_list_model.g.dart';

@freezed
class UsersListResponse with _$UsersListResponse {
  const factory UsersListResponse({
    required List<UserModel> data,
    required Pagination pagination,
    required String message,
    required int statusCode,
  }) = _UsersListResponse;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    required int totalItems,
    required int totalPages,
    required int currentPage,
    required int pageSize,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}
