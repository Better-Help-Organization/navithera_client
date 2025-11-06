// matched_therapist_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import 'package:navithera_client/feature/home/domain/repositories/matched_therapist_repository.dart';

part 'matched_therapist_provider.freezed.dart';

@freezed
class MatchedTherapistState with _$MatchedTherapistState {
  const factory MatchedTherapistState.initial() = MatchedTherapistInitial;
  const factory MatchedTherapistState.loading() = MatchedTherapistLoading;
  const factory MatchedTherapistState.loaded(UserModel? therapist) =
      MatchedTherapistLoaded;
  const factory MatchedTherapistState.error(Failure failure) =
      MatchedTherapistError;
}

class MatchedTherapistNotifier extends StateNotifier<MatchedTherapistState> {
  final MatchedTherapistRepository _repo;

  MatchedTherapistNotifier(this._repo)
    : super(const MatchedTherapistState.initial());

  Future<void> load() async {
    try {
      state = const MatchedTherapistState.loading();
      final res = await _repo.getLatestAcceptedTherapist();
      res.fold(
        (l) => state = MatchedTherapistState.error(l),
        (r) => state = MatchedTherapistState.loaded(r),
      );
    } catch (e) {
      state = MatchedTherapistState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void reset() {
    state = const MatchedTherapistState.initial();
  }
}

final matchedTherapistProvider =
    StateNotifierProvider<MatchedTherapistNotifier, MatchedTherapistState>((
      ref,
    ) {
      final repo = ref.read(matchedTherapistRepositoryProvider);
      return MatchedTherapistNotifier(repo);
    });
