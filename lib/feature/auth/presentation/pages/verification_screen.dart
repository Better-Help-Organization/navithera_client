import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_typography.dart';
import '../providers/auth_provider.dart';

class VerificationSentScreen extends ConsumerWidget {
  const VerificationSentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref
        .watch(authProvider)
        .maybeWhen(
          unverified: (msg) => msg,
          orElse: () => 'An OTP has been sent to your email for verification.',
        );
    final router = ref.read(routerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF2B2D5A), // Dark blue background
      body: SafeArea(
        child: Column(
          children: [
            // Header with empty row to maintain consistent spacing
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: const Row(children: []),
            ),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration/Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF66B5A3).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mark_email_read,
                        size: 60,
                        color: Color(0xFF66B5A3), // Teal accent color
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Title
                    Text(
                      'Verify Your Email',
                      style: AppTypography.heading1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Message
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge.copyWith(
                        color: const Color(0xFFB8B8D2), // Light grayish-blue
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () => router.go('/login'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF66B5A3,
                          ), // Teal button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Continue to Login',
                          style: AppTypography.buttonText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer with sign in prompt
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Didn\'t receive the email? ',
            //         style: AppTypography.bodySmall.copyWith(
            //           color: const Color(0xFF7B7B7B),
            //         ),
            //       ),
            //       TextButton(
            //         onPressed: () {
            //           // Add resend logic here
            //         },
            //         child: Text(
            //           'Resend',
            //           style: AppTypography.bodySmall.copyWith(
            //             color: const Color(0xFF66B5A3),
            //             decoration: TextDecoration.underline,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
