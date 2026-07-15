import 'dart:math';

import 'package:dio/dio.dart';
import 'package:navithera_client/core/util/avatar_util.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/auth_models.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio) = _AuthRemoteDataSource;

  @POST('/auth/login/client')
  Future<ApiResponse> login(@Body() LoginRequest request);

  @POST('/auth/signup/client')
  Future<ApiResponse> signup(@Body() SignupRequest request);

  // Change the return type for updateProfile
  @PATCH('/client/me')
  Future<ProfileApiResponse> updateProfile(
    @Body() UpdateProfileRequest request,
  );

  @PATCH('/client/me')
  Future<ProfileApiResponse> updateProfilePicture(
    @Body() UpdateProfilePicRequest request,
  );

  // Also update the getUserFromBackend method
  @GET('/client/me')
  Future<ProfileApiResponse> getCurrentUserProfile({
    @Query('fields')
    String fields =
        'preference.id,preference.gender,preference.goal,'
            'answer.id,answer.text,'
            'activeSubscription.id,activeSubscription.createdAt,activeSubscription.updatedAt,'
            'activeSubscription.status,activeSubscription.end_date,activeSubscription.price,'
            // 'hasNotification.id,hasNotification.updatedAt,hasNotification.createdAt,'
            // 'hasNotification.title,hasNotification.body,hasNotification.message,hasNotification.code,'
            'createdAt,firstName,lastName,email,phoneNumber,status,gender,dob,isLinked,'
            'username,emergencyContact,isVisible,isEmailAuthenticated,isPhoneNumberAuthenticated,'
            'updatedAt,deletedAt,profile,avatar',
  });

  @POST('/auth/logout')
  Future<void> logout();

  @POST('/auth/refresh')
  Future<ApiResponse> refreshToken(@Field() String refreshToken);

  @POST('/auth/forgotPwd/client')
  Future<ForgotPasswordResponse> forgotPassword(
    @Body() ForgotPasswordRequest request,
  );

  @POST('/auth/resetPwd/client')
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRemoteDataSource(dio);
});
