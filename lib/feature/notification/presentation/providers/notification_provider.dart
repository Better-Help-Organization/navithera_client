// notification_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/core/error/failures.dart';
import 'package:navithera_client/feature/notification/data/models/notification_models.dart';
import 'package:navithera_client/feature/notification/domain/repositories/notification_repository.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';

part 'notification_provider.freezed.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;
  const factory NotificationState.loading() = NotificationLoading;
  const factory NotificationState.loaded(
    List<NotificationItem> notifications,
    Pagination pagination,
    bool canLoadMore,
  ) = NotificationLoaded;
  const factory NotificationState.error(Failure failure) = NotificationError;
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationNotifier(this._repository)
    : super(const NotificationState.initial());

  Future<void> getNotifications({
    bool loadMore = false,
    bool silent = false,
  }) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is NotificationLoaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        if (!silent) {
          state = const NotificationState.loading();
        }
      }

      final result = await _repository.getNotifications(page: nextPage);

      result.fold((failure) => state = NotificationState.error(failure), (
        response,
      ) {
        final notifications = response.data;
        final pagination = response.pagination;
        final canLoadMore = pagination.currentPage < pagination.totalPages;

        if (loadMore && currentState is NotificationLoaded) {
          final allNotifications = [
            ...currentState.notifications,
            ...notifications,
          ];
          print("All Notifications: $allNotifications");
          state = NotificationState.loaded(
            allNotifications,
            pagination,
            canLoadMore,
          );
        } else {
          state = NotificationState.loaded(
            notifications,
            pagination,
            canLoadMore,
          );
        }
      });
    } catch (e) {
      state = NotificationState.error(Failure.unknownFailure(e.toString()));
    }
  }

  void markNotificationAsRead(String notificationId) {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final updatedNotifications =
          currentState.notifications.map((notification) {
            if (notification.id == notificationId) {
              return notification.copyWith(isRead: true);
            }
            return notification;
          }).toList();

      state = NotificationState.loaded(
        updatedNotifications,
        currentState.pagination,
        currentState.canLoadMore,
      );
    }
  }

  void markAllNotificationsAsRead() {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final updatedNotifications =
          currentState.notifications
              .map((notification) => notification.copyWith(isRead: true))
              .toList();

      state = NotificationState.loaded(
        updatedNotifications,
        currentState.pagination,
        currentState.canLoadMore,
      );
    }
  }

  void toggleNotificationExpansion(String notificationId) {
    final currentState = state;
    if (currentState is NotificationLoaded) {
      final updatedNotifications =
          currentState.notifications.map((notification) {
            if (notification.id == notificationId) {
              return notification.copyWith(
                isExpanded: !notification.isExpanded,
              );
            }
            return notification.copyWith(isExpanded: false);
          }).toList();

      state = NotificationState.loaded(
        updatedNotifications,
        currentState.pagination,
        currentState.canLoadMore,
      );
    }
  }
}

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
      final repository = ref.read(notificationRepositoryProvider);
      return NotificationNotifier(repository);
    });
