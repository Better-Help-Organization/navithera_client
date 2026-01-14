import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/notification/data/models/notification_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/user_answer.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
class ApiResponse with _$ApiResponse {
  const factory ApiResponse({
    required AuthData data,
    required String message,
    required int statusCode,
  }) = _ApiResponse;

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}

@freezed
class AuthData with _$AuthData {
  const factory AuthData({
    required UserModel user,
    required String accessToken,
    required String refreshToken,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}

@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String phoneNumber,
    required String password,
    required String firebaseToken,
    String? voIpToken,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

@freezed
class ProfileApiResponse with _$ProfileApiResponse {
  const factory ProfileApiResponse({
    required UserModel data, // Direct user data, not wrapped in AuthData
    required String message,
    required int statusCode,
  }) = _ProfileApiResponse;

  factory ProfileApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiResponseFromJson(json);
}

@freezed
class SignupRequest with _$SignupRequest {
  const factory SignupRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String firebaseToken,
    required String dob,
    required String username,
    required String phoneNumber,
  }) = _SignupRequest;

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);
}

@freezed
class ExpertiseData with _$ExpertiseData {
  const factory ExpertiseData({
    required String id,
    DateTime? updatedAt,
    DateTime? createdAt,
    String? expertise,
  }) = _ExpertiseData;

  factory ExpertiseData.fromJson(Map<String, dynamic> json) =>
      _$ExpertiseDataFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required DateTime createdAt,
    String? status,
    String? gender,
    DateTime? dob,
    String? username,
    String? phoneNumber,
    bool? isVisible,
    DateTime? updatedAt,
    dynamic emergencyContact,
    DateTime? deletedAt,
    bool? isLinked,
    bool? isEmailAuthenticated,
    bool? isPhoneNumberAuthenticated,
    @JsonKey(name: 'preference')
    List<PrefData>? preferences, // Map 'preference' to 'preferences'
    @JsonKey(name: 'answer')
    List<AnsData>? answers, // Map 'answer' to 'answers'
    @JsonKey(
      name: 'activeSubscription',
    ) // This should match the JSON field name
    SubscriptionData? activeSubscription,
    @JsonKey(name: 'expertise') // Add this line
    List<ExpertiseData>? expertise,
    int? avatar,
    String? profile,
    bool? isOnline,
    String? bio,
    NotificationItem? hasNotification,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class PrefData with _$PrefData {
  const factory PrefData({String? id, String? gender, String? goal}) =
      _PrefData;

  factory PrefData.fromJson(Map<String, dynamic> json) =>
      _$PrefDataFromJson(json);
}

@freezed
class AnsData with _$AnsData {
  const factory AnsData({String? id, String? text}) = _AnsData;

  factory AnsData.fromJson(Map<String, dynamic> json) =>
      _$AnsDataFromJson(json);
}

// Add this to your auth_models.dart file
@freezed
class UpdateProfileRequest with _$UpdateProfileRequest {
  const factory UpdateProfileRequest({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    // String? dob,
    String? username,
    String? phoneNumber,
    // String? avatar,
  }) = _UpdateProfileRequest;

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestFromJson(json);
}

@freezed
class UpdateProfilePicRequest with _$UpdateProfilePicRequest {
  const factory UpdateProfilePicRequest({int? avatar}) =
      _UpdateProfilePicRequest;

  factory UpdateProfilePicRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfilePicRequestFromJson(json);
}

@freezed
class ForgotPasswordRequest with _$ForgotPasswordRequest {
  const factory ForgotPasswordRequest({required String email}) =
      _ForgotPasswordRequest;

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);
}

@freezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  const factory ResetPasswordRequest({
    required String email,
    required String password,
    required String passwordConfirm,
    required String otp,
  }) = _ResetPasswordRequest;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
}

@freezed
class ForgotPasswordResponse with _$ForgotPasswordResponse {
  const factory ForgotPasswordResponse({
    required String data,
    required String message,
    required int statusCode,
  }) = _ForgotPasswordResponse;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}

@freezed
class ResetPasswordResponse with _$ResetPasswordResponse {
  const factory ResetPasswordResponse({
    required ResetPasswordData data,
    required String message,
    required int statusCode,
  }) = _ResetPasswordResponse;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
}

@freezed
class ResetPasswordData with _$ResetPasswordData {
  const factory ResetPasswordData({required String message}) =
      _ResetPasswordData;

  factory ResetPasswordData.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordDataFromJson(json);
}

@freezed
class SubscriptionData with _$SubscriptionData {
  const factory SubscriptionData({
    required String id,
    required DateTime updatedAt,
    required DateTime createdAt,
    int? type,
    String? status,
    String? start_date,
    String? end_date,
    int? old_price,
    int? price,
  }) = _SubscriptionData;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);
}
