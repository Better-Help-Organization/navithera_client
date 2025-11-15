// message_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/chat/data/models/chat_models.dart';
import 'package:navithera_client/feature/chat/domain/repositories/chat_repository.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import '../../../../core/error/failures.dart';

part 'message_provider.freezed.dart';

@freezed
class MessageState with _$MessageState {
  const factory MessageState.initial() = Initial;
  const factory MessageState.loading() = Loading;
  const factory MessageState.loaded(
    List<ChatMessageDetail> messages,
    Pagination pagination,
    bool canLoadMore,
  ) = Loaded;
  const factory MessageState.error(Failure failure) = Error;
}

class MessageNotifier extends StateNotifier<MessageState> {
  final ChatRepository _repository;
  final String _chatId;

  MessageNotifier(this._repository, this._chatId)
    : super(const MessageState.initial());

  Future<void> getMessages({bool loadMore = false, bool silent = false}) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is Loaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        if (!silent) {
          state = const MessageState.loading();
        }
      }

      final result = await _repository.getChatMessages(
        chatId: _chatId,
        page: nextPage,
        take: 30,
        sort: 'createdAt=Desc',
      );

      result.fold((failure) => state = MessageState.error(failure), (response) {
        final messages = response.data;
        final pagination = response.pagination;

        if (loadMore && currentState is Loaded) {
          // Prepend older messages (server returns Desc)
          final allMessages = [...messages, ...currentState.messages];
          state = MessageState.loaded(
            allMessages,
            pagination,
            pagination.currentPage < pagination.totalPages,
          );
        } else {
          state = MessageState.loaded(
            messages,
            pagination,
            pagination.currentPage < pagination.totalPages,
          );
        }
      });
    } catch (e) {
      state = MessageState.error(Failure.unknownFailure(e.toString()));
    }
  }

  Future<void> sendMessage(String content, String userId) async {
    // Optimistic UI only when we already have a loaded list
    if (state case Loaded(
      :final messages,
      :final pagination,
      :final canLoadMore,
    )) {
      final localId = 'local-${DateTime.now().microsecondsSinceEpoch}';

      // Create a local pending message; client == null => isMe == true in your UI
      final temp = ChatMessageDetail(
        id: localId,
        content: content,
        createdAt: DateTime.now(),
        therapist: null,
        client: UserModel(
          createdAt: DateTime.now(),
          id: userId,
          firstName: 'You',
          lastName: '',
          email: '',
          phoneNumber: '',
        ),
        isPending: true,
        localId: localId,
      );

      // Insert newest first (server uses Desc order)
      state = MessageState.loaded([temp, ...messages], pagination, canLoadMore);

      // Fire the network request
      final result = await _repository.sendMessage(
        chatId: _chatId,
        content: content,
      );

      result.fold(
        // Failure: mark as failed (show error icon)
        (failure) {
          final updated =
              (state as Loaded).messages.map((m) {
                if (m.localId == localId) {
                  return m.copyWith(isPending: false, isFailed: true);
                }
                return m;
              }).toList();
          state = MessageState.loaded(updated, pagination, canLoadMore);
        },
        // Success: mark as sent (remove clock), then silent refresh to replace with server copy
        (_) async {
          // Clear pending flag immediately (icon disappears)
          final updated =
              (state as Loaded).messages.map((m) {
                if (m.localId == localId) {
                  return m.copyWith(isPending: false);
                }
                return m;
              }).toList();
          state = MessageState.loaded(updated, pagination, canLoadMore);

          // Reconcile with the server messages (no Loading flicker)
          // Replace entire list so we don’t keep the local-id message around.
          await getMessages(silent: true);
        },
      );
    } else {
      // Fallback: if not loaded yet, just send and load messages
      final result = await _repository.sendMessage(
        chatId: _chatId,
        content: content,
      );
      result.fold(
        (failure) => state = MessageState.error(failure),
        (_) async => await getMessages(silent: true),
      );
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final currentState = state;
    if (currentState is Loaded) {
      // Optimistically remove the message from UI
      final updatedMessages =
          currentState.messages
              .where((message) => message.id != messageId)
              .toList();

      state = MessageState.loaded(
        updatedMessages,
        currentState.pagination,
        currentState.canLoadMore,
      );

      // Call the API to delete the message
      final result = await _repository.deleteMessage(messageId);

      result.fold(
        (failure) {
          // If deletion failed, restore the message by refreshing
          getMessages(silent: true);
        },
        (_) {
          getMessages(silent: true);
          // Success - message already removed from UI
          print('Message deleted successfully');
        },
      );
    }
  }

  Future<void> markAsRead() async {
    try {
      final result = await _repository.markAsRead(_chatId);
      result.fold(
        (failure) => print('Failed to mark as read: $failure'),
        (_) => print('Chat marked as read successfully'),
      );
    } catch (e) {
      print('Error marking as read: $e');
    }
  }
}

final messageProvider =
    StateNotifierProvider.family<MessageNotifier, MessageState, String>((
      ref,
      chatId,
    ) {
      final repository = ref.read(chatRepositoryProvider);
      return MessageNotifier(repository, chatId);
    });
