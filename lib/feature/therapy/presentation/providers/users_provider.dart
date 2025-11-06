// users_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/therapy/data/models/users_list_model.dart';
import 'package:navithera_client/feature/therapy/domain/repositories/users_repository.dart';
import '../../../../core/error/failures.dart';

part 'users_provider.freezed.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState.initial() = Initial;
  const factory UsersState.loading() = Loading;
  const factory UsersState.loaded(
    List<UserModel> users,
    Pagination pagination,
    bool canLoadMore,
  ) = Loaded;
  const factory UsersState.error(Failure failure) = Error;
}

class UsersNotifier extends StateNotifier<UsersState> {
  final UsersRepository _repository;

  UsersNotifier(this._repository) : super(const UsersState.initial());

  Future<void> getUsers({bool loadMore = false}) async {
    try {
      final currentState = state;
      int nextPage = 1;

      if (loadMore && currentState is Loaded) {
        if (!currentState.canLoadMore) return;
        nextPage = currentState.pagination.currentPage + 1;
      } else {
        state = const UsersState.loading();
      }

      final result = await _repository.getUsers(page: nextPage);

      result.fold((failure) => state = UsersState.error(failure), (response) {
        final users = response.data;
        final pagination = response.pagination;

        if (loadMore && currentState is Loaded) {
          final allUsers = [...currentState.users, ...users];
          state = UsersState.loaded(
            allUsers,
            pagination,
            pagination.currentPage < pagination.totalPages,
          );
        } else {
          state = UsersState.loaded(
            users,
            pagination,
            pagination.currentPage < pagination.totalPages,
          );
        }
      });
    } catch (e) {
      state = UsersState.error(Failure.unknownFailure(e.toString()));
    }
  }
}

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final repository = ref.read(usersRepositoryProvider);
  return UsersNotifier(repository);
});
