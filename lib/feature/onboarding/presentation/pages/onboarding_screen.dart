// lib/feature/onboarding/presentation/pages/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:navithera_client/core/providers/first_time_provider.dart'; // Add this
import 'package:navithera_client/feature/onboarding/presentation/widgets/step2.dart';
import 'package:navithera_client/feature/onboarding/presentation/widgets/step3.dart';
import 'package:navithera_client/feature/onboarding/presentation/widgets/step_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import "package:navithera_client/l10n/app_localizations.dart";

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  final controller = LiquidController();
  int currentPage = 0;

  final List<Widget> pages = [const Step1(), const Step2(), const Step3()];

  void _completeOnboarding() {
    // Mark first time as complete
    ref.read(setFirstTimeCompleteProvider.future);
    // Navigate to login
    ref.read(routerProvider).go("/login");
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            enableLoop: false,
            fullTransitionValue: 600,
            enableSideReveal: true,
            liquidController: controller,
            onPageChangeCallback: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
          Positioned(
            bottom: 190,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: currentPage,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                    spacing: 10,
                    dotColor: Colors.white54,
                    activeDotColor: Colors.white,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 2,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(page: pages.length - 1);
                    }, // Use the new method
                    child: Text(
                      AppLocalizations.of(context)!.skip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final page = currentPage + 1;
                      if (page < pages.length) {
                        controller.animateToPage(page: page);
                      } else {
                        _completeOnboarding(); // Use the new method
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        currentPage == pages.length - 1
                            ? AppLocalizations.of(context)!.getStarted2
                            : AppLocalizations.of(context)!.next,
                        style: const TextStyle(
                          color: Color(0xFF7EB09B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
