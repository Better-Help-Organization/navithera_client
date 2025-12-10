// feature/home/presentation/providers/live_session_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/home/data/models/live_session_models.dart';
import 'package:navithera_client/feature/home/domain/repositories/live_session_repository.dart';

part 'live_session_provider.freezed.dart';

@freezed
class LiveSessionState with _$LiveSessionState {
  const factory LiveSessionState.initial() = LiveSessionInitial;
  const factory LiveSessionState.loading() = LiveSessionLoading;
  const factory LiveSessionState.loaded(List<ChatItem> activeCalls) =
      LiveSessionLoaded;
  const factory LiveSessionState.error(Failure failure) = LiveSessionError;
  const factory LiveSessionState.joining() = LiveSessionJoining;
  const factory LiveSessionState.joinSuccess(JoinCallData joinData) =
      LiveSessionJoinSuccess;
  const factory LiveSessionState.joinError(Failure failure) =
      LiveSessionJoinError;
}

class LiveSessionNotifier extends StateNotifier<LiveSessionState> {
  final LiveSessionRepository _repo;

  LiveSessionNotifier(this._repo) : super(const LiveSessionState.initial());

  Future<void> loadActiveCalls() async {
    try {
      state = const LiveSessionState.loading();
      final res = await _repo.getActiveCalls();
      res.fold(
        (l) => state = LiveSessionState.error(l),
        (r) => state = LiveSessionState.loaded(r),
      );
    } catch (e) {
      state = LiveSessionState.error(Failure.unknownFailure(e.toString()));
    }
  }

  Future<void> joinCall(String chatId) async {
    try {
      state = const LiveSessionState.joining();
      final res = await _repo.joinCall(chatId);
      res.fold(
        (l) => state = LiveSessionState.joinError(l),
        (r) => state = LiveSessionState.joinSuccess(r),
      );
    } catch (e) {
      state = LiveSessionState.joinError(Failure.unknownFailure(e.toString()));
    }
  }

  void reset() {
    state = const LiveSessionState.initial();
  }
}

final liveSessionProvider =
    StateNotifierProvider<LiveSessionNotifier, LiveSessionState>((ref) {
      final repo = ref.read(liveSessionRepositoryProvider);
      return LiveSessionNotifier(repo);
    });
