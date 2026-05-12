import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; 
import '../../../../core/error/failures.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/auth_models.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../profile/data/data_sources/profile_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final FlutterSecureStorage secureStorage; 

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.profileRemoteDataSource,
    required this.secureStorage, 
  });

  Future<void> _saveTokens(String access, String refresh) async {
    await secureStorage.write(key: 'access_token', value: access);
    await secureStorage.write(key: 'refresh_token', value: refresh);
  }

  Future<void> _saveUser(User user) async {
    await secureStorage.write(
      key: 'current_user',
      value: jsonEncode(user.toJson()),
    );
  }

  Future<String?> _getToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> _clearAll() async {
    await secureStorage.deleteAll(); 
  }

  @override
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
    String fcm, {
    String? voIpToken,
  }) async {
    try {
      final loginRequest = LoginRequest(
        phoneNumber: phoneNumber,
        password: password,
        firebaseToken: fcm,
        voIpToken: voIpToken,
      );

      final apiResponse = await remoteDataSource.login(loginRequest);
      final authData = apiResponse.data;

      await _saveTokens(authData.accessToken, authData.refreshToken);

      final completeUserResult = await getUserFromBackend();

      return completeUserResult.fold((failure) async {
        final basicUser = User(
          id: authData.user.id,
          email: authData.user.email,
          firstName: authData.user.firstName,
          lastName: authData.user.lastName,
          phoneNumber: authData.user.phoneNumber,
          username: authData.user.username ?? '',
          gender: authData.user.gender ?? "",
          profile: authData.user.profile ?? "",
          activeSubscription: authData.user.activeSubscription,
          createdAt: authData.user.createdAt,
          avatar: authData.user.avatar,
          status: authData.user.status,
          hasNotification: authData.user.hasNotification,
        );

        // SECURE user storage
        await _saveUser(basicUser);
        return Right(basicUser);
      }, (completeUser) => Right(completeUser));

    } on DioException catch (e) {
      String errorMessage = 'Login failed. Please try again.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        if (responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        }
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'Invalid phone number or password';
      }
      return Left(Failure.authFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final refreshToken = await secureStorage.read(key: 'refresh_token'); // ✅
      if (refreshToken != null) {
        await remoteDataSource.logout();
      }
      await _clearAll(); 
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure.serverFailure(e.message ?? 'Logout failed'));
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup(
    String firstName,
    String lastName,
    String email,
    String password,
    String gender,
    String firebaseToken,
    String dob,
    String username,
    String phoneNumber,
  ) async {
    try {
      final request = SignupRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        gender: gender,
        firebaseToken: firebaseToken,
        dob: dob,
        username: username,
        phoneNumber: phoneNumber,
      );

      final apiResponse = await remoteDataSource.signup(request);
      final authData = apiResponse.data;

      await _saveTokens(authData.accessToken, authData.refreshToken);

      final user = User(
        id: authData.user.id,
        email: authData.user.email,
        firstName: authData.user.firstName,
        lastName: authData.user.lastName,
        phoneNumber: authData.user.phoneNumber,
        username: authData.user.username ?? '',
        gender: authData.user.gender ?? "",
        createdAt: authData.user.createdAt,
        profile: authData.user.profile ?? "",
        avatar: authData.user.avatar,
        status: "active",
      );

      await _saveUser(user);
      return Right(user);

    } on DioException catch (e) {
      String errorMessage = 'Signup failed. Please try again.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        if (responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        }
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final token = await _getToken(); 
      return Right(token != null);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return const Left(Failure.authFailure('No token found'));
      }

      final userJsonString = await secureStorage.read(key: 'current_user'); 
      if (userJsonString == null) {
        return const Left(Failure.authFailure('No user data found'));
      }

      final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return Right(user);
    } catch (e) {
      return Left(
        Failure.unknownFailure('Failed to parse user data: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, User>> getUserFromBackend() async {
    try {
      final profileResponse = await remoteDataSource.getCurrentUserProfile();
      final userData = profileResponse.data;


      final user = User(
        id: userData.id,
        email: userData.email,
        firstName: userData.firstName,
        lastName: userData.lastName,
        phoneNumber: userData.phoneNumber,
        username: userData.username ?? '',
        gender: userData.gender,
        dob: userData.dob,
        createdAt: userData.createdAt,
        status: userData.status,
        isLinked: userData.isLinked,
        emergencyContact: userData.emergencyContact,
        isVisible: userData.isVisible,
        isEmailAuthenticated: userData.isEmailAuthenticated,
        isPhoneNumberAuthenticated: userData.isPhoneNumberAuthenticated,
        preferences: userData.preferences,
        answers: userData.answers,
        avatar: userData.avatar,
        updatedAt: userData.updatedAt,
        deletedAt: userData.deletedAt,
        profile: userData.profile,
        activeSubscription: userData.activeSubscription,
        hasNotification: userData.hasNotification,
      );

      await _saveUser(user);
      return Right(user);

    } on DioException catch (e) {
      String errorMessage = "We're having trouble loading your profile.";
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile(UpdateProfileRequest request) async {
    try {
      final profileResponse = await remoteDataSource.updateProfile(request);
      final userData = profileResponse.data;

      final updatedUser = User(
        id: userData.id,
        email: userData.email,
        firstName: userData.firstName,
        lastName: userData.lastName,
        phoneNumber: userData.phoneNumber,
        username: userData.username ?? '',
        gender: userData.gender,
        dob: userData.dob,
        createdAt: userData.createdAt,
        status: userData.status,
        isLinked: userData.isLinked,
        emergencyContact: userData.emergencyContact,
        isVisible: userData.isVisible,
        isEmailAuthenticated: userData.isEmailAuthenticated,
        isPhoneNumberAuthenticated: userData.isPhoneNumberAuthenticated,
        avatar: userData.avatar,
        updatedAt: userData.updatedAt,
        deletedAt: userData.deletedAt,
        profile: userData.profile ?? "",
      );

      await _saveUser(updatedUser);
      return Right(updatedUser);

    } on DioException catch (e) {
      String errorMessage = 'Profile update failed. Please try again.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfilePic(UpdateProfilePicRequest request) async {
    try {
      final profileResponse = await remoteDataSource.updateProfilePicture(request);
      final userData = profileResponse.data;

      final updatedUser = User(
        id: userData.id,
        email: userData.email,
        firstName: userData.firstName,
        lastName: userData.lastName,
        phoneNumber: userData.phoneNumber,
        username: userData.username ?? '',
        gender: userData.gender,
        dob: userData.dob,
        createdAt: userData.createdAt,
        status: userData.status,
        isLinked: userData.isLinked,
        emergencyContact: userData.emergencyContact,
        isVisible: userData.isVisible,
        isEmailAuthenticated: userData.isEmailAuthenticated,
        isPhoneNumberAuthenticated: userData.isPhoneNumberAuthenticated,
        preferences: userData.preferences,
        answers: userData.answers,
        avatar: userData.avatar,
        updatedAt: userData.updatedAt,
        deletedAt: userData.deletedAt,
        profile: userData.profile ?? "",
      );

      await _saveUser(updatedUser);
      return Right(updatedUser);

    } on DioException catch (e) {
      String errorMessage = 'Profile picture update failed.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      final request = ForgotPasswordRequest(email: email);
      final response = await remoteDataSource.forgotPassword(request);
      return Right(response.data);
    } on DioException catch (e) {
      String errorMessage = 'Failed to send reset email.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
    String email,
    String password,
    String passwordConfirm,
    String otp,
  ) async {
    try {
      final request = ResetPasswordRequest(
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        otp: otp,
      );
      final response = await remoteDataSource.resetPassword(request);
      return Right(response.data.message);
    } on DioException catch (e) {
      String errorMessage = 'Failed to reset password.';
      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }
      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }
}