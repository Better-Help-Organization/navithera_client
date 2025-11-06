// lib/core/widgets/first_time_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/providers/first_time_provider.dart';
import 'package:navithera_client/core/routes/app_router.dart';
//import 'package:navithera_client/feature/onboarding/presentation/pages/onboarding_screen.dart';

class FirstTimeWrapper extends ConsumerWidget {
  const FirstTimeWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstTimeAsync = ref.watch(firstTimeProvider);
    final router = ref.read(routerProvider);

    return firstTimeAsync.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error:
          (error, stack) =>
              Scaffold(body: Center(child: Text('Error: $error'))),
      data: (isFirstTime) {
        // Use a post-frame callback to navigate after build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isFirstTime) {
            // First time - go to onboarding
            router.go('/onboarding');
          } else {
            // Not first time - go to auth gate
            router.go('/auth-gate');
          }
        });

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
