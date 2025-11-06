// upcoming_session_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/home/data/models/upcoming_session_models.dart';
import 'package:navithera_client/feature/home/domain/repositories/upcoming_session_repository.dart';

part 'upcoming_session_provider.freezed.dart';

@freezed
class UpcomingSessionState with _$UpcomingSessionState {
  const factory UpcomingSessionState.initial() = UpcomingSessionInitial;
  const factory UpcomingSessionState.loading() = UpcomingSessionLoading;
  const factory UpcomingSessionState.loaded(SessionItem? nextSession) =
      UpcomingSessionLoaded;
  const factory UpcomingSessionState.error(Failure failure) =
      UpcomingSessionError;
}

class UpcomingSessionNotifier extends StateNotifier<UpcomingSessionState> {
  final UpcomingSessionRepository _repo;
  UpcomingSessionNotifier(this._repo)
    : super(const UpcomingSessionState.initial());

  Future<void> loadNext() async {
    try {
      state = const UpcomingSessionState.loading();
      final res = await _repo.getNextUpcomingSession();
      res.fold(
        (l) => state = UpcomingSessionState.error(l),
        (r) => state = UpcomingSessionState.loaded(r),
      );
    } catch (e) {
      state = UpcomingSessionState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void reset() {
    state = const UpcomingSessionState.initial();
  }
}

final upcomingSessionProvider =
    StateNotifierProvider<UpcomingSessionNotifier, UpcomingSessionState>((ref) {
      final repo = ref.read(upcomingSessionRepositoryProvider);
      return UpcomingSessionNotifier(repo);
    });
