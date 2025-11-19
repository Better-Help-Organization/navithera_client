//lib/core/routes/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/widgets/auth_gate.dart';
import 'package:navithera_client/core/widgets/first_time_wrapper.dart';
//import 'package:navithera_client/core/widgets/first_time_wrapper.dart';
import 'package:navithera_client/feature/audioplayer/presentation/pages/meditation_list_screen.dart';
import 'package:navithera_client/feature/auth/data/models/auth_models.dart';
import 'package:navithera_client/feature/auth/presentation/pages/blocked_user_screen.dart';
import 'package:navithera_client/feature/auth/presentation/pages/forgot_password_screen.dart';
import 'package:navithera_client/feature/auth/presentation/pages/login_screen.dart';
import 'package:navithera_client/feature/auth/presentation/pages/reset_password_screen.dart';
import 'package:navithera_client/feature/auth/presentation/pages/signup_screen.dart';
import 'package:navithera_client/feature/breathing-miniapp/presentation/pages/breathing_intro.dart';
import 'package:navithera_client/feature/breathing-miniapp/presentation/pages/breathing_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/chat_list_screen.dart';
import 'package:navithera_client/feature/chat/presentation/pages/message_screen.dart';
import 'package:navithera_client/feature/journal/presentation/pages/my_journal.dart';
import 'package:navithera_client/feature/navigation/presentation/pages/main_navigation.dart';
import 'package:navithera_client/feature/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:navithera_client/feature/payment/presentations/pages/payment_upload_page.dart';
import 'package:navithera_client/feature/payment/presentations/pages/subscription_page.dart';
import 'package:navithera_client/feature/questionnaire/presentation/pages/extra_question_screen.dart';
import 'package:navithera_client/feature/questionnaire/presentation/pages/questionnaire_screen.dart';
import 'package:navithera_client/feature/questionnaire/presentation/pages/category_selection_screen.dart';
import 'package:navithera_client/feature/profile/presentation/pages/update_profile_screen.dart';
import 'package:navithera_client/feature/questionnaire/presentation/widgets/number_picker.dart';
import 'package:navithera_client/feature/therapy/presentation/pages/therapy_profile_screen.dart';
//import 'package:navithera_client/feature/therapy/presentation/pages/user_list_screen.dart';
import 'package:navithera_client/main.dart'; // Add this import to access navigatorKey

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey, // Now this will work
    initialLocation: '/language-selection',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        // Add this route as the initial route
        path: '/',
        builder: (context, state) => const FirstTimeWrapper(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnBoardingScreen(),
      ),
      GoRoute(
        path: '/auth-gate',
        builder: (context, state) => const AuthGate(),
      ),
      // GoRoute(
      //   path: '/payment',
      //   builder: (context, state) {
      //     final sessionId = state.extra as String? ?? '';
      //     return PaymentUploadPage(sessionId: sessionId);
      //   },
      // ),
      GoRoute(
        path: '/payment',
        builder: (context, state) {
          final sessionId = state.extra as String? ?? '';
          final preferenceId = state.uri.queryParameters['preferenceId'];

          // Add validation to ensure preferenceId is provided
          if (preferenceId == null || preferenceId.isEmpty) {
            // Handle error case - perhaps navigate back or show an error
            return ErrorWidget(Exception('preferenceId is required'));
          }

          return PaymentUploadPage(
            sessionId: sessionId,
            preferenceId: preferenceId, // Now required
          );
        },
      ),
      GoRoute(
        path: '/subscription',
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(path: '/main', builder: (context, state) => MainNavigation()),
      GoRoute(path: '/login', builder: (context, state) => LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => SignupPage()),
      GoRoute(
        path: '/updateProfile',
        builder: (context, state) {
          final index = state.extra as int? ?? 0; // default to 0 if not passed
          return UpdateProfileWrapperPage(initialIndex: index);
        },
      ),
      GoRoute(path: '/journal', builder: (context, state) => MyJournalScreen()),
      GoRoute(
        path: '/blocked-user',
        builder: (context, state) => BlockedUserScreen(),
      ),
      GoRoute(
        path: '/meditationList',
        builder: (context, state) => MeditationListScreen(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => CategorySelectionScreen(),
      ),
      GoRoute(
        path: '/questionnaire',
        builder: (context, state) => QuestionnaireScreen(),
      ),
      GoRoute(
        path: '/breathing-intro',
        builder: (context, state) => BreathingWelcomeCombined(),
      ),
      GoRoute(
        path: '/therapist-profile',
        builder:
            (context, state) =>
                TherapistProfileScreen(therapist: state.extra as UserModel),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          // Get the email from query parameters or extra
          final email = state.extra as String?;
          if (email == null) {
            // Handle error case - redirect back or show error
            return Scaffold(
              body: Center(child: Text('Email is required for password reset')),
            );
          }
          return ResetPasswordScreen(email: email);
        },
      ),
      GoRoute(
        path: '/breathing',
        builder: (context, state) => BreathingScreen(),
      ),
      GoRoute(
        path: '/language-selection',
        builder: (context, state) {
          final prefId =
              state.uri.queryParameters['prefId']; // Use uri.queryParameters
          return ExtraQuestionsScreen(
            preferenceId: prefId, // Pass it to the screen
          );
        },
      ),
      GoRoute(
        path: '/chat/:chatId',
        builder: (context, state) {
          // You'll need to get the chat object from somewhere
          // This could be from a provider or passed as extra
          final chat = state.extra as Chat?;
          if (chat == null) {
            // Handle error case where chat is not provided
            return const Scaffold(body: Center(child: Text('Chat not found')));
          }
          return ChatMessageScreen(chat: chat);
        },
      ),
      //GoRoute(path: '/clients', builder: (context, state) => UsersListScreen()),
    ],
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
