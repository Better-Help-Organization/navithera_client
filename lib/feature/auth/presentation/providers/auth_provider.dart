import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import '../../../../core/error/failures.dart';
//import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../profile/data/data_sources/profile_remote_data_source.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
  const factory AuthState.unverified(String message) = _Unverified;
  const factory AuthState.profileError(User user, String message) =
      _ProfileError;
}

// Shared Preferences Provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
});

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  final profileRemoteDataSource = ref.read(profileRemoteDataSourceProvider);
  final secureStorage = ref.read(secureStorageProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    profileRemoteDataSource: profileRemoteDataSource,
    secureStorage: secureStorage,
  );
});

// Auth State Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState.initial()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final result = await _authRepository.isLoggedIn();
    result.fold((failure) => state = AuthState.error(failure.toString()), (
      isLoggedIn,
    ) {
      if (isLoggedIn) {
        getCurrentUser();
      } else {
        state = const AuthState.unauthenticated();
      }
    });
  }

  Future<void> getCurrentUser() async {
    final result = await _authRepository.getUserFromBackend();
    result.fold(
      (failure) => state = const AuthState.unauthenticated(),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> refreshUserProfile() async {
    final result = await _authRepository.getUserFromBackend();

    result.fold(
      (failure) => state = AuthState.error(_getErrorMessage(failure)),
      (user) {
        // Only update state if we're currently authenticated
        if (state is _Authenticated) {
          state = AuthState.authenticated(user);
        }
      },
    );
  }

  // Future<void> login(String phoneNumber, String password, String fcm) async {
  //   state = const AuthState.loading();

  //   final result = await _authRepository.login(phoneNumber, password, fcm);
  //   result.fold(
  //     (failure) => state = AuthState.error(_getErrorMessage(failure)),
  //     (user) => state = AuthState.authenticated(user),
  //   );
  // }
  // Update the login method in AuthNotifier
  Future<void> login(
    String phoneNumber,
    String password,
    String fcm, {
    String? voIpToken,
  }) async {
    state = const AuthState.loading();

    final result = await _authRepository.login(
      phoneNumber,
      password,
      fcm,
      voIpToken: voIpToken,
    );

    result.fold((failure) => state = AuthState.error(_getErrorMessage(failure)), (
      user,
    ) async {
      // After successful login, fetch the complete user profile
      final completeUserResult = await _authRepository.getUserFromBackend();

      completeUserResult.fold(
        (failure) {
          // If fetching complete profile fails, still use the basic user from login
          state = AuthState.authenticated(user);
        },
        (completeUser) {
          // Use the complete user profile with all fields
          state = AuthState.authenticated(completeUser);
        },
      );
    });
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String gender,
    required String firebaseToken,
    required String dob,
    required String username,
    required String phoneNumber,
  }) async {
    state = const AuthState.loading();

    final result = await _authRepository.signup(
      firstName,
      lastName,
      email,
      password,
      gender,
      firebaseToken,
      dob,
      username,
      phoneNumber,
    );

    result.fold(
      (failure) => state = AuthState.error(_getErrorMessage(failure)),
      (user) => state = AuthState.authenticated(user),
    );
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    // Only proceed if we're authenticated
    if (state is! _Authenticated) {
      state = AuthState.error('You must be logged in to update your profile');
      return;
    }

    final currentUser = (state as _Authenticated).user;

    final result = await _authRepository.updateProfile(request);

    result.fold(
      (failure) {
        state = AuthState.profileError(currentUser, _getErrorMessage(failure));
        state = AuthState.authenticated(currentUser);
        // On error, revert to authenticated state with original user
        // state = AuthState.authenticated(currentUser);
        // state = AuthState.error('You must be logged in to update your profile');
        // return (_getErrorMessage(failure)); // Show error but maintain auth
      },
      (updatedUser) {
        // Update the state with the new user data
        state = AuthState.authenticated(updatedUser);
      },
    );
  }

  Future<void> updateProfilePic(UpdateProfilePicRequest request) async {
    // Only proceed if we're authenticated
    if (state is! _Authenticated) {
      state = AuthState.error('You must be logged in to update your profile');
      return;
    }

    final currentUser = (state as _Authenticated).user;

    final result = await _authRepository.updateProfilePic(request);

    result.fold(
      (failure) {
        state = AuthState.profileError(currentUser, _getErrorMessage(failure));
        state = AuthState.authenticated(currentUser);
        // On error, revert to authenticated state with original user
        // state = AuthState.authenticated(currentUser);
        // state = AuthState.error('You must be logged in to update your profile');
        // return (_getErrorMessage(failure)); // Show error but maintain auth
      },
      (updatedUser) {
        // Update the state with the new user data
        state = AuthState.authenticated(updatedUser);
      },
    );
  }

  Future<void> logout() async {
    state = const AuthState.loading();

    final result = await _authRepository.logout();

    result.fold(
      (failure) => state = AuthState.error(_getErrorMessage(failure)),
      (_) => state = const AuthState.unauthenticated(),
    );
  }

  // Public method to refresh current user data
  Future<void> refreshCurrentUser() async {
    // Only update if we're currently authenticated
    if (state is _Authenticated) {
      //final result = await _authRepository.getCurrentUserFromBackend();
      // result.fold(
      //   // On failure, keep the current state instead of logging out
      //   (failure) => {}, // Do nothing, keep current user data
      //   (user) => state = AuthState.authenticated(user),
      // );
    }
  }

  Future<void> forgotPassword(String email) async {
    state = const AuthState.loading();
    final result = await _authRepository.forgotPassword(email);

    result.fold(
      (failure) {
        state = AuthState.error(failure.message);
        throw failure.message;
      },
      (message) {
        state = const AuthState.unauthenticated();
        // You can show success message here or handle it in the UI
      },
    );
  }

  Future<void> resetPassword(
    String email,
    String password,
    String passwordConfirm,
    String otp,
  ) async {
    state = const AuthState.loading();
    final result = await _authRepository.resetPassword(
      email,
      password,
      passwordConfirm,
      otp,
    );

    result.fold(
      (failure) {
        state = AuthState.error(failure.message);
        throw failure.message;
      },
      (message) {
        state = const AuthState.unauthenticated();
        // You can show success message here or handle it in the UI
      },
    );
  }

  String _getErrorMessage(Failure failure) {
    // print("failurexyz, ${failure}");
    return failure.when(
      serverFailure: (message) => message,
      networkFailure: (message) => 'Network error: $message',
      authFailure: (message) => message,
      unknownFailure: (message) => 'Unknown error: $message',
    );
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

// Add this provider to your auth_provider.dart file
