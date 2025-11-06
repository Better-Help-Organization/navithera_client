import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/journal/data/models/diary_models.dart';
import 'package:navithera_client/feature/journal/domain/repositories/diary_repository.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'diary_provider.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState.initial() = Initial;
  const factory DiaryState.loading() = Loading;
  const factory DiaryState.loaded(
    List<DiaryEntry> entries,
    Pagination pagination,
    bool canLoadMore,
  ) = Loaded;
  const factory DiaryState.operationLoading(String operationType) =
      OperationLoading; // Add this
  const factory DiaryState.operationSuccess(String message) =
      OperationSuccess; // Add this
  const factory DiaryState.error(Failure failure) = Error;
}

class DiaryNotifier extends StateNotifier<DiaryState> {
  final DiaryRepository _repository;

  DiaryNotifier(this._repository) : super(const DiaryState.initial());

  Future<void> getDiaryEntries({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is Loaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        if (!silent) {
          state = const DiaryState.loading();
        }
      }

      final result = await _repository.getDiaryEntries(page: nextPage);

      result.fold((failure) => state = DiaryState.error(failure), (response) {
        final entries = response.data;
        final pagination = response.pagination;
        final canLoadMore = pagination.currentPage < pagination.totalPages;

        if (loadMore && currentState is Loaded) {
          final allEntries = [...currentState.entries, ...entries];
          state = DiaryState.loaded(allEntries, pagination, canLoadMore);
        } else {
          state = DiaryState.loaded(entries, pagination, canLoadMore);
        }
      });
    } catch (e) {
      state = DiaryState.error(Failure.unknownFailure(e.toString()));
    }
  }

  Future<void> createDiaryEntry({
    required String title,
    required String content,
  }) async {
    try {
      state = DiaryState.operationLoading('create');
      final result = await _repository.createDiaryEntry(
        title: title,
        content: content,
      );

      result.fold((failure) => state = DiaryState.error(failure), (response) {
        state = DiaryState.operationSuccess(
          'Journal entry created successfully',
        );
        // Refresh the list after creating a new entry
        getDiaryEntries(silent: true);
      });
    } catch (e) {
      state = DiaryState.error(Failure.unknownFailure(e.toString()));
    }
  }

  Future<void> updateDiaryEntry({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      state = DiaryState.operationLoading('update');
      final result = await _repository.updateDiaryEntry(
        id: id,
        title: title,
        content: content,
      );

      result.fold((failure) => state = DiaryState.error(failure), (response) {
        state = DiaryState.operationSuccess(
          'Journal entry updated successfully',
        );
        // Refresh the list after updating
        getDiaryEntries(silent: true);
      });
    } catch (e) {
      state = DiaryState.error(Failure.unknownFailure(e.toString()));
    }
  }

  Future<void> deleteDiaryEntry(String id) async {
    try {
      state = DiaryState.operationLoading('delete');
      final result = await _repository.deleteDiaryEntry(id);

      result.fold((failure) => state = DiaryState.error(failure), (response) {
        state = DiaryState.operationSuccess(
          'Journal entry deleted successfully',
        );
        // Refresh the list after deletion
        getDiaryEntries(silent: true);
      });
    } catch (e) {
      state = DiaryState.error(Failure.unknownFailure(e.toString()));
    }
  }
}

final diaryProvider = StateNotifierProvider<DiaryNotifier, DiaryState>((ref) {
  final repository = ref.read(diaryRepositoryProvider);
  return DiaryNotifier(repository);
});
