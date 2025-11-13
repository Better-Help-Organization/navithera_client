import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/notification/notification_service.dart';
import 'package:navithera_client/core/providers/socket_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/feature/auth/presentation/providers/auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  void _navigate(BuildContext context, WidgetRef ref, AuthState state) {
    final router = ref.read(routerProvider);
    final pendingRoute = ref.read(pendingRouteProvider);

    print("pendingRoute: $pendingRoute");

    state.when(
      initial: () {}, // Wait for the notifier's _checkAuthStatus
      loading: () {}, // Still resolving auth
      authenticated: (user) async {
        log("userjo: ${user.toString()}");
        try {
          final socketService = ref.read(socketServiceProvider);
          await socketService.connect();
          print("Socket connected after login");
        } catch (e) {
          print("Socket connection error: $e");
          // Don't block navigation if socket fails
        }
        final userStatus = user.status!.toLowerCase();
        // Decide where to go based on user data
        final hasAnswers =
            user.answers != null &&
            user.answers!.any((a) => a.text?.isNotEmpty == true);
        final hasPreferences =
            user.preferences != null && user.preferences!.isNotEmpty;

        print("usersos: ${user.activeSubscription}");
        // final subscritions = user.subscriptions.length;
        final hasSubsription = user.activeSubscription != null;

        final firstStatus =
            user.activeSubscription != null
                ? user.activeSubscription!.status
                : null;

        final firstSubscriptionID =
            user.activeSubscription != null
                ? user.activeSubscription!.id
                : null;

        final firstPreferenceId =
            user.preferences!.isNotEmpty ? user.preferences!.first.id : null;

        final isSubscriptionExpired =
            hasSubsription &&
            user.activeSubscription!.end_date != null &&
            DateTime.now().isAfter(
              DateTime.parse(user.activeSubscription!.end_date!),
            );
        print("user Scription: ${firstPreferenceId}");
        print("user Scription: ${firstStatus}");
        print("hasSubscrition user.answers: ${hasSubsription}");
        print("hasAnsers: ${hasAnswers}");
        print("hasprefs: ${hasPreferences}");

        if (!hasAnswers && !hasPreferences) {
          router.go('/categories');
        }
        // else if (hasPreferences && ) {
        //   router.go('/categories');
        // }
        else if (!hasSubsription && hasPreferences) {
          router.go('/categories');
        } else if (!hasSubsription) {
          router.go('/subscription');
        } else if (firstStatus == "inactive") {
          // router.go('/payment', extra: firstSubscriptionID);
          router.go(
            '/payment?preferenceId=$firstPreferenceId',
            extra: firstSubscriptionID,
          );
        } else if (isSubscriptionExpired) {
          router.go('/categories');
        } else if (userStatus != "active") {
          router.go("/blocked-user");
        } else if (firstStatus != "active") {
          router.go("/blocked-user");
        } else if (pendingRoute != null) {
          // Navigate to the pending route
          router.go("/main");
          router.push(pendingRoute.path, extra: pendingRoute.extra);
          ref.read(pendingRouteProvider.notifier).state = null; // clear it
          // s
        } else {
          router.go('/main');
        }
      },
      unauthenticated: () {
        ref.read(routerProvider).go('/login');
      },
      error: (_) {
        // On error, you can choose to show an error UI here or send to login
        ref.read(routerProvider).go('/login');
      },
      unverified: (_) {
        // If you have a verification flow, navigate there
        // router.go('/verify');
        ref.read(routerProvider).go('/login');
      },
      profileError: (user, message) {
        // Show a snackbar with the error message
        // NotificationService.showSnackBar(
        //   context,
        //   'Profile update failed: $message',
        // );
        // // Navigate to main or stay on the same page
        // ref.read(routerProvider).go('/main');
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    // Trigger navigation in an effect to avoid calling router during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate(context, ref, state);
    });

    // Neutral splash/loading UI
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
