import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

@freezed
class UpdatePersonalDetailsRequest with _$UpdatePersonalDetailsRequest {
  const factory UpdatePersonalDetailsRequest({
    required String firstName,
    required String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  }) = _UpdatePersonalDetailsRequest;

  factory UpdatePersonalDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalDetailsRequestFromJson(json);
}

@freezed
class UpdatePersonalDetailsResponse with _$UpdatePersonalDetailsResponse {
  const factory UpdatePersonalDetailsResponse({
    required UpdatePersonalDetailsData data,
    String? message,
    int? statusCode,
    String? method,
    String? path,
    String? timestamp,
  }) = _UpdatePersonalDetailsResponse;

  factory UpdatePersonalDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalDetailsResponseFromJson(json);
}

@freezed
class UpdatePersonalDetailsData with _$UpdatePersonalDetailsData {
  const factory UpdatePersonalDetailsData({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    String? gender,
    DateTime? dob,
    String? username,
    String? emergencyContact,
    int? avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UpdatePersonalDetailsData;

  factory UpdatePersonalDetailsData.fromJson(Map<String, dynamic> json) =>
      _$UpdatePersonalDetailsDataFromJson(json);
}

// @freezed
// class ProfileModel with _$ProfileModel {
//   const factory ProfileModel({
//     required String id,
//     required String firstName,
//     required String lastName,
//     required String email,
//     String? phoneNumber,
//     String? gender,
//     String? dateOfBirth,
//     String? username,
//     String? avatar,
//     DateTime? updatedAt,
//     DateTime? createdAt,
//   }) = _ProfileModel;

//   factory ProfileModel.fromJson(Map<String, dynamic> json) =>
//       _$ProfileModelFromJson(json);
// }
@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required DateTime createdAt,
    required String firstName,
    required String lastName,
    required String email,
    String? phoneNumber,
    String? status,
    String? gender,
    DateTime? dob,
    bool? isLinked,
    String? username,
    String? emergencyContact,
    bool? isVisible,
    int? avatar,
    DateTime? updatedAt,
    List<PreferenceData>? preference,
    List<UserAnswer>? answer,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}
