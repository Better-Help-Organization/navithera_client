import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/failures.dart';
import '../../data/data_sources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

part 'profile_provider.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(Profile profile) = _Loaded;
  const factory ProfileState.updating() = _Updating;
  const factory ProfileState.updated(Profile profile) = _Updated;
  const factory ProfileState.error(String message) = _Error;
}

// Profile Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.read(profileRemoteDataSourceProvider);

  return ProfileRepositoryImpl(
    remoteDataSource: remoteDataSource,
    secureStorage: const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock)
    ),
  );
});

// Profile State Notifier
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;
  final Ref _ref;

  ProfileNotifier(this._profileRepository, this._ref)
    : super(const ProfileState.initial());

  Future<void> getCurrentProfile() async {
    state = const ProfileState.loading();

    final result = await _profileRepository.getCurrentProfile();
    result.fold(
      (failure) => state = ProfileState.error(_getErrorMessage(failure)),
      (profile) => state = ProfileState.loaded(profile),
    );
  }

  Future<void> updatePersonalDetails({
    required String firstName,
    required String lastName,
    String? username,
    String? emergencyContact,
    String? gender,
  }) async {
    state = const ProfileState.updating();

    final result = await _profileRepository.updatePersonalDetails(
      firstName: firstName,
      lastName: lastName,
      username: username,
      emergencyContact: emergencyContact,
      gender: gender,
    );

    result.fold(
      (failure) => state = ProfileState.error(_getErrorMessage(failure)),
      (profile) async {
        state = ProfileState.updated(profile);
        // Refresh the auth state to update user data across the app
        try {
          print('Starting user data refresh after profile update...');
          await _ref.read(authProvider.notifier).refreshCurrentUser();
          print('User data refresh completed successfully');
        } catch (e) {
          // If refresh fails, don't break the profile update flow
          print('Failed to refresh user data after profile update: $e');
        }
      },
    );
  }

  String _getErrorMessage(Failure failure) {
    return failure.when(
      serverFailure: (message) => message,
      networkFailure: (message) => 'Network error: $message',
      authFailure: (message) => message,
      unknownFailure: (message) => 'Unknown error: $message',
    );
  }
}

// Profile Provider
final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  final profileRepository = ref.read(profileRepositoryProvider);
  return ProfileNotifier(profileRepository, ref);
});
