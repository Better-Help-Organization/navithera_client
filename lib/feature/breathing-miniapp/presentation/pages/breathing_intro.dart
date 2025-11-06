import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Replace this with your own AppColors if needed
class AppColors {
  static const primary = Color(0xFF00AEB8);
}

class BreathingWelcomeCombined extends StatefulWidget {
  const BreathingWelcomeCombined({super.key});

  @override
  State<BreathingWelcomeCombined> createState() =>
      _BreathingWelcomeCombinedState();
}

class _BreathingWelcomeCombinedState extends State<BreathingWelcomeCombined>
    with SingleTickerProviderStateMixin {
  // Intro sequence state
  bool _showFirst = false;
  bool _showSecond = false;
  bool _showThird = false;
  bool _introComplete = false;

  // Breathing animation
  late final AnimationController _ctrl;
  final Duration inhale = const Duration(seconds: 4);
  final Duration exhale = const Duration(seconds: 4);
  final Color mainColor = const Color(0xFF00AEB8);
  final double minScale = 0.72;
  final double maxScale = 1.22;
  final int ghostCount = 10;
  final double ghostDelay = 0.055;
  late final double inhalePct;
  bool _paused = false;

  @override
  void initState() {
    super.initState();

    // Init breathing controller but keep it paused until intro finishes
    final total = inhale + exhale;
    inhalePct = inhale.inMilliseconds / total.inMilliseconds;
    _ctrl = AnimationController(vsync: this, duration: total);

    _startAnimationSequence();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _startAnimationSequence() {
    // First text
    Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _showFirst = true);

      // Second text
      Timer(const Duration(milliseconds: 1500), () {
        if (!mounted) return;
        setState(() => _showSecond = true);

        // Third text
        Timer(const Duration(milliseconds: 1500), () {
          if (!mounted) return;
          setState(() => _showThird = true);

          // Completion - transition to breathing UI
          Timer(const Duration(milliseconds: 2000), () {
            if (!mounted) return;

            // Brief fade-out of the intro section
            setState(() => _introComplete = true);

            // Start breathing animation after the crossfade starts
            // Small delay to let the crossfade kick in (optional)
            Timer(const Duration(milliseconds: 150), () {
              if (!mounted) return;
              _paused = false;
              _ctrl.repeat();
              setState(() {});
            });
          });
        });
      });
    });
  }

  // Map normalized progress (0..1) across inhale/exhale to a scale value.
  double _scaleFor(double progress) {
    progress = progress % 1.0;
    if (progress < 0) progress += 1.0;

    final ease = Curves.easeInOut;
    if (progress < inhalePct) {
      final t = progress / inhalePct;
      return lerpDouble(minScale, maxScale, ease.transform(t))!;
    } else {
      final t = (progress - inhalePct) / (1 - inhalePct);
      return lerpDouble(maxScale, minScale, ease.transform(t))!;
    }
  }

  bool _isInhaling(double progress) => (progress % 1.0) < inhalePct;

  Widget _buildIntro() {
    return AnimatedOpacity(
      opacity: _introComplete ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _showFirst ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: const Text(
                  "Hi,",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _showSecond ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: const Text(
                  "Get settled.",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 250),
              AnimatedOpacity(
                opacity: _showThird ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                child: const Text(
                  "and we will begin.",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreathing() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: () {
      //   setState(() {
      //     _paused = !_paused;
      //     if (_paused) {
      //       _ctrl.stop();
      //     } else {
      //       _ctrl.repeat();
      //     }
      //   });
      // },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          final progress = _ctrl.value;
          final inhaling = _isInhaling(progress);

          return LayoutBuilder(
            builder: (context, constraints) {
              final shortest = constraints.biggest.shortestSide;
              final baseDiameter = shortest * 0.45;

              final widgets = <Widget>[];

              // Ghost circles
              for (int i = ghostCount - 1; i >= 0; i--) {
                final p = progress - (i + 1) * ghostDelay;
                final s = _scaleFor(p);
                final opacity = 0.08 + (i / ghostCount) * 0.12;

                widgets.add(
                  Transform.scale(
                    scale: s,
                    child: Container(
                      width: baseDiameter,
                      height: baseDiameter,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor.withOpacity(opacity),
                        boxShadow: [
                          BoxShadow(
                            color: mainColor.withOpacity(opacity * 0.6),
                            blurRadius: 28,
                            spreadRadius: -8,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // Main circle
              final mainScale = _scaleFor(progress);
              widgets.add(
                Transform.scale(
                  scale: mainScale,
                  child: Container(
                    width: baseDiameter,
                    height: baseDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor,
                      boxShadow: [
                        BoxShadow(
                          color: mainColor.withOpacity(0.45),
                          blurRadius: 36,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder:
                          (child, animation) => FadeTransition(
                            opacity: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ),
                            child: child,
                          ),
                      child: Text(
                        inhaling ? 'Inhale' : 'Exhale',
                        key: ValueKey<bool>(inhaling),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: baseDiameter * 0.18,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              );

              return Center(
                child: Stack(alignment: Alignment.center, children: widgets),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_introComplete) return true;
        GoRouter.of(context).go('/main');
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          // Important: the Stack order determines hit testing: later children are on top.
          child: Stack(
            children: [
              // Content layer (intro or breathing)
              Positioned.fill(
                child: AnimatedCrossFade(
                  crossFadeState:
                      _introComplete
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 400),
                  firstCurve: Curves.easeOut,
                  secondCurve: Curves.easeIn,
                  sizeCurve: Curves.decelerate,
                  firstChild: _buildIntro(),
                  // Put the GestureDetector inside this child ONLY, not wrapping the whole Stack.
                  secondChild: Stack(
                    children: [
                      // The breathing area that captures taps
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            // toggle pause/resume or leave empty if disabled
                            setState(() {
                              _paused = !_paused;
                              if (_paused) {
                                _ctrl.stop();
                              } else {
                                _ctrl.repeat();
                              }
                            });
                          },
                          child: _buildBreathingContent(), // see below
                        ),
                      ),
                      if (_paused)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              color: Colors.black.withOpacity(0.25),
                              alignment: Alignment.center,
                              child: const Text(
                                'Paused -- tap to resume',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Close button ON TOP of everything else (last in the Stack)
              Positioned(
                top: 8,
                left: 8,
                child: IgnorePointer(
                  ignoring: false, // ensure it can receive taps
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () {
                      // If you removed pause, this will still work
                      GoRouter.of(context).go('/main');
                      // Or: Navigator.of(context).maybePop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Extracted breathing content without the full-screen GestureDetector
  Widget _buildBreathingContent() {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final progress = _ctrl.value;
        final inhaling = _isInhaling(progress);

        return LayoutBuilder(
          builder: (context, constraints) {
            final shortest = constraints.biggest.shortestSide;
            final baseDiameter = shortest * 0.45;

            final widgets = <Widget>[];

            for (int i = ghostCount - 1; i >= 0; i--) {
              final p = progress - (i + 1) * ghostDelay;
              final s = _scaleFor(p);
              final opacity = 0.08 + (i / ghostCount) * 0.12;

              widgets.add(
                Transform.scale(
                  scale: s,
                  child: Container(
                    width: baseDiameter,
                    height: baseDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mainColor.withOpacity(opacity),
                      boxShadow: [
                        BoxShadow(
                          color: mainColor.withOpacity(opacity * 0.6),
                          blurRadius: 28,
                          spreadRadius: -8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            final mainScale = _scaleFor(progress);
            widgets.add(
              Transform.scale(
                scale: mainScale,
                child: Container(
                  width: baseDiameter,
                  height: baseDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainColor,
                    boxShadow: [
                      BoxShadow(
                        color: mainColor.withOpacity(0.45),
                        blurRadius: 36,
                        spreadRadius: -10,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder:
                        (child, animation) => FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ),
                          child: child,
                        ),
                    child: Text(
                      inhaling ? 'Inhale' : 'Exhale',
                      key: ValueKey<bool>(inhaling),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: baseDiameter * 0.18,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            );

            return Center(
              child: Stack(alignment: Alignment.center, children: widgets),
            );
          },
        );
      },
    );
  }
}
