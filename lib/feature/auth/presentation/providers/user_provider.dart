import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import 'auth_provider.dart';

final currentUserProvider = Provider<User?>((ref) {
  return ref
      .watch(authProvider)
      .maybeWhen(authenticated: (user) => user, orElse: () => null);
});
