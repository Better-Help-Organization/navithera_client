import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStatusProvider =
    StateNotifierProvider<UserStatusNotifier, Map<String, bool>>((ref) {
      return UserStatusNotifier();
    });

class UserStatusNotifier extends StateNotifier<Map<String, bool>> {
  UserStatusNotifier() : super({});

  void updateStatus(String userId, bool isOnline) {
    state = {...state, userId: isOnline};
  }

  bool isUserOnline(String userId) {
    return state[userId] ?? false;
  }
}
