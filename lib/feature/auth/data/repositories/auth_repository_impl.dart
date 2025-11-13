import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/auth_models.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../profile/data/data_sources/profile_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final SharedPreferences sharedPreferences;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.profileRemoteDataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> login(
    String phoneNumber,
    String password,
    String fcm,
  ) async {
    print("phoneNumber: $phoneNumber, password: $password, fcm: $fcm");
    try {
      final loginRequest = LoginRequest(
        phoneNumber: phoneNumber,
        password: password,
        firebaseToken: fcm,
      );

      final apiResponse = await remoteDataSource.login(loginRequest);
      final authData = apiResponse.data;

      // Store tokens
      await sharedPreferences.setString('access_token', authData.accessToken);
      await sharedPreferences.setString('refresh_token', authData.refreshToken);

      // Now fetch the complete user profile with all fields
      final completeUserResult = await getUserFromBackend();
      log("completeUser: ${completeUserResult}");

      print("AuthData User: ${authData.user.avatar}");
      print("AuthData User: ${authData.user.profile}");

      return completeUserResult.fold((failure) async {
        print("HalfUser: ${completeUserResult}");
        // If fetching complete profile fails, still return the basic user from login
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

        // Store basic user data
        await sharedPreferences.setString(
          'current_user',
          jsonEncode(basicUser.toJson()),
        );

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
    } catch (e, stackTrace) {
      print('Login error: $e');
      print(stackTrace.toString());
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // Get the refresh token before removing it
      final refreshToken = sharedPreferences.getString('refresh_token');

      if (refreshToken != null) {
        await remoteDataSource.logout();
      }

      // Clear local storage
      await sharedPreferences.remove('access_token');
      await sharedPreferences.remove('refresh_token');

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

      // This now returns ApiResponse
      final apiResponse = await remoteDataSource.signup(request);
      final authData = apiResponse.data;

      // Store tokens if they exist
      await sharedPreferences.setString('access_token', authData.accessToken);
      await sharedPreferences.setString('refresh_token', authData.refreshToken);

      // Convert response to User entity
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

      // Store complete user object as JSON
      await sharedPreferences.setString(
        'current_user',
        jsonEncode(user.toJson()),
      );

      return Right(user);
    } on DioException catch (e) {
      String errorMessage = 'Signup failed. Please try again.';

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;

        if (responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        } else if (responseData.containsKey('error')) {
          errorMessage = responseData['error'].toString();
        }
      } else if (e.response?.statusCode == 400) {
        errorMessage = 'Invalid request. Please check your information.';
      } else if (e.response?.statusCode == 401) {
        errorMessage = 'Authentication failed.';
      } else if (e.response?.statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      }

      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  // @override
  // Future<Either<Failure, void>> logout() async {
  //   try {
  //     await remoteDataSource.logout();
  //     await sharedPreferences.remove('access_token');
  //     await sharedPreferences.remove('refresh_token');
  //     return const Right(null);
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final token = sharedPreferences.getString('access_token');
      if (token == null) {
        return const Left(Failure.authFailure('No token found'));
      }

      // Get stored user JSON
      final userJsonString = sharedPreferences.getString('current_user');
      if (userJsonString == null) {
        return const Left(Failure.authFailure('No user data found'));
      }

      // Parse JSON string to Map using proper JSON decoding
      final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;

      // Convert to User entity using freezed fromJson
      final user = User.fromJson(userJson);

      return Right(user);
    } catch (e) {
      return Left(
        Failure.unknownFailure('Failed to parse user data: ${e.toString()}'),
      );
    }
  }

  // Add this method to your AuthRepositoryImpl class
  // Update the updateProfile method
  @override
  Future<Either<Failure, User>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      // Call the remote data source
      final profileResponse = await remoteDataSource.updateProfile(request);
      final userData = profileResponse.data;

      // Convert response to User entity
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

      // Update stored user data
      await sharedPreferences.setString(
        'current_user',
        jsonEncode(updatedUser.toJson()),
      );

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

  // Update the getUserFromBackend method
  @override
  Future<Either<Failure, User>> getUserFromBackend() async {
    try {
      // Call the remote data source to get complete user profile
      final profileResponse = await remoteDataSource.getCurrentUserProfile();
      final userData = profileResponse.data;

      log("User Data from backend: ${userData.toJson()}");

      print('Raw user data: ${profileResponse.toJson()}');
      print('Preferences from backend: ${userData.preferences}');
      print('Answers from backend: ${userData.answers}');
      print('Answers from backend: ${userData.profile}');
      print('Answers from backend: ${userData.avatar}');
      print('Answers from backend3: ${userData.hasNotification}');
      //print('Answers from backend3: ${userData.subscription}');

      // Convert the response to User entity
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
        // subscriptions: userData.subscription,
      );

      // Update stored user data with complete information
      await sharedPreferences.setString(
        'current_user',
        jsonEncode(user.toJson()),
      );

      return Right(user);
    } on DioException catch (e) {
      print("error: ${e}");
      String errorMessage =
          "We're having trouble loading your profile. Please check your connection and try again.";

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
  Future<Either<Failure, User>> updateProfilePic(
    UpdateProfilePicRequest request,
  ) async {
    try {
      // Call the remote data source
      final profileResponse = await remoteDataSource.updateProfilePicture(
        request,
      );
      final userData = profileResponse.data; // This is UserModel, not AuthData

      // Convert response to User entity
      final updatedUser = User(
        id: userData.id, // Direct access to userData fields
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
        avatar: userData.avatar, // This should be updated
        updatedAt: userData.updatedAt,
        deletedAt: userData.deletedAt,
        profile: userData.profile ?? "",
      );

      // Update stored user data
      await sharedPreferences.setString(
        'current_user',
        jsonEncode(updatedUser.toJson()),
      );

      return Right(updatedUser);
    } on DioException catch (e) {
      String errorMessage = 'Profile picture update failed. Please try again.';

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;
      }

      return Left(Failure.serverFailure(errorMessage));
    } catch (e) {
      return Left(Failure.unknownFailure('An unexpected error occurred'));
    }
  }

  // Method to fetch fresh user data from backend using existing retrofit profile data source
  // Future<Either<Failure, User>> getCurrentUserFromBackend() async {
  //   try {
  //     final token = sharedPreferences.getString('access_token');
  //     if (token == null) {
  //       return const Left(Failure.authFailure('No token found'));
  //     }

  //     // Use existing retrofit profile data source to fetch fresh data
  //     //final profileModel = await profileRemoteDataSource.getCurrentProfile();

  //     // Convert ProfileModel to User entity
  //     // final user = User(
  //     //   id: profileModel.id,
  //     //   email: profileModel.email,
  //     //   firstName: profileModel.firstName,
  //     //   lastName: profileModel.lastName,
  //     //   phoneNumber: profileModel.phoneNumber,
  //     //   username: profileModel.username ?? '',
  //     // );

  //     // // Update cached user data with fresh data
  //     // await sharedPreferences.setString(
  //     //   'current_user',
  //     //   jsonEncode(user.toJson()),
  //     // );

  //     return Right(user);
  //   } on DioException catch (e) {
  //     String errorMessage = 'Failed to get current user';
  //     if (e.response?.statusCode == 401) {
  //       errorMessage = 'Authentication failed';
  //     }
  //     return Left(Failure.authFailure(errorMessage));
  //   } catch (e) {
  //     return Left(Failure.unknownFailure(e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      final request = ForgotPasswordRequest(email: email);
      final response = await remoteDataSource.forgotPassword(request);

      return Right(response.data); // Returns the success message
    } on DioException catch (e) {
      String errorMessage =
          'Failed to send password reset email. Please try again.';

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

      return Right(response.data.message); // Returns the success message
    } on DioException catch (e) {
      String errorMessage = 'Failed to reset password. Please try again.';

      if (e.response?.data is Map<String, dynamic>) {
        final responseData = e.response!.data as Map<String, dynamic>;
        errorMessage = responseData['message']?.toString() ?? errorMessage;

        // Handle specific error cases
        if (e.response?.statusCode == 400) {
          errorMessage = 'Invalid OTP or email. Please check and try again.';
        } else if (e.response?.statusCode == 404) {
          errorMessage = 'User not found with this email.';
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
      final token = sharedPreferences.getString('access_token');
      return Right(token != null);
    } catch (e) {
      return Left(Failure.unknownFailure(e.toString()));
    }
  }
}
