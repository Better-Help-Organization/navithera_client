import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_provider.dart';

part 'delete_account_provider.freezed.dart';

@freezed
class DeleteAccountState with _$DeleteAccountState {
  const factory DeleteAccountState.initial() = _Initial;
  const factory DeleteAccountState.loading() = _Loading;
  const factory DeleteAccountState.success() = _Success;
  const factory DeleteAccountState.error(String message) = _Error;
}

// Delete Account State Notifier
class DeleteAccountNotifier extends StateNotifier<DeleteAccountState> {
  final ProfileRepository _profileRepository;

  DeleteAccountNotifier(this._profileRepository)
      : super(const DeleteAccountState.initial());

  Future<void> deleteAccount() async {
    state = const DeleteAccountState.loading();

    final result = await _profileRepository.deleteAccount();
    
    result.fold(
      (failure) => state = DeleteAccountState.error(_getErrorMessage(failure)),
      (_) => state = const DeleteAccountState.success(),
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

// Delete Account Provider
final deleteAccountProvider =
    StateNotifierProvider<DeleteAccountNotifier, DeleteAccountState>((ref) {
  final profileRepository = ref.read(profileRepositoryProvider);
  return DeleteAccountNotifier(profileRepository);
});
