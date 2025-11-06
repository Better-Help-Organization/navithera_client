import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/chat/data/models/chat_models.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import '../../../../core/error/failures.dart';

part 'chat_provider.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = Initial;
  const factory ChatState.loading() = Loading;
  const factory ChatState.loaded(
    List<ChatThread> threads,
    Pagination pagination,
    bool canLoadMore,
  ) = Loaded;
  const factory ChatState.error(Failure failure) = Error;
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository _repository;

  ChatNotifier(this._repository) : super(const ChatState.initial());

  Future<void> getChatThreads({
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
        // Only show the Loading state if not a silent refresh
        if (!silent) {
          state = const ChatState.loading();
        }
      }

      final result = await _repository.getChatThreads(page: nextPage);

      result.fold((failure) => state = ChatState.error(failure), (response) {
        final threads = response.data;
        final pagination = response.pagination;
        final canLoadMore = pagination.currentPage < pagination.totalPages;

        if (loadMore && currentState is Loaded) {
          final allThreads = [...currentState.threads, ...threads];
          state = ChatState.loaded(allThreads, pagination, canLoadMore);
        } else {
          state = ChatState.loaded(threads, pagination, canLoadMore);
        }
      });
    } catch (e) {
      state = ChatState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void markChatAsRead(String chatId) {
    final currentState = state;
    if (currentState is Loaded) {
      // Find the thread and update its unread count
      final updatedThreads =
          currentState.threads.map((thread) {
            if (thread.id == chatId) {
              return thread.copyWith(unreadCount: 0);
            }
            return thread;
          }).toList();

      // Update the state with the modified threads
      state = ChatState.loaded(
        updatedThreads,
        currentState.pagination,
        currentState.canLoadMore,
      );
    }
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final repository = ref.read(chatRepositoryProvider);
  return ChatNotifier(repository);
});
