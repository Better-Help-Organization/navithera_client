import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/chat/data/models/chat_models.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import '../../../../core/error/failures.dart';

part 'search_chat_provider.freezed.dart';

@freezed
class SearchChatState with _$SearchChatState {
  const factory SearchChatState.initial() = SearchInitial;
  const factory SearchChatState.loading() = SearchLoading;
  const factory SearchChatState.loaded(
    List<ChatThread> threads,
    Pagination pagination,
    bool canLoadMore,
  ) = SearchLoaded;
  const factory SearchChatState.error(Failure failure) = SearchError;
  const factory SearchChatState.empty() = SearchEmpty;
}

class SearchChatNotifier extends StateNotifier<SearchChatState> {
  final ChatRepository _repository;
  Timer? _debounceTimer;

  SearchChatNotifier(this._repository) : super(const SearchChatState.initial());

  void searchChats(String query, {bool loadMore = false}) {
    // Cancel previous debounce timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      state = const SearchChatState.initial();
      return;
    }

    // Set debounce timer (300ms)
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query, loadMore: loadMore);
    });
  }

  Future<void> _performSearch(String query, {bool loadMore = false}) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is SearchLoaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        state = const SearchChatState.loading();
      }

      final result = await _repository.searchChatThreads(
        query: query,
        page: nextPage,
      );

      result.fold((failure) => state = SearchChatState.error(failure), (
        response,
      ) {
        final threads = response.data;
        final pagination = response.pagination;
        final canLoadMore = pagination.currentPage < pagination.totalPages;

        if (threads.isEmpty) {
          state = const SearchChatState.empty();
          return;
        }

        if (loadMore && currentState is SearchLoaded) {
          final allThreads = [...currentState.threads, ...threads];
          state = SearchChatState.loaded(allThreads, pagination, canLoadMore);
        } else {
          state = SearchChatState.loaded(threads, pagination, canLoadMore);
        }
      });
    } catch (e) {
      state = SearchChatState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void clearSearch() {
    _debounceTimer?.cancel();
    state = const SearchChatState.initial();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

final searchChatProvider =
    StateNotifierProvider<SearchChatNotifier, SearchChatState>((ref) {
      final repository = ref.read(chatRepositoryProvider);
      return SearchChatNotifier(repository);
    });
