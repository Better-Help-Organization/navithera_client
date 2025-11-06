import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Timing you can tweak
  final Duration inhale = const Duration(seconds: 4);
  final Duration exhale = const Duration(seconds: 4);

  // Look-and-feel you can tweak
  final Color mainColor = AppColors.primary; // teal/cyan
  final double minScale = 0.72;
  final double maxScale = 1.22;
  final int ghostCount = 10; // number of trailing ghost circles
  final double ghostDelay = 0.055; // phase delay per ghost [0..1]

  late final double inhalePct;

  bool _paused = false;

  @override
  void initState() {
    super.initState();
    final total = inhale + exhale;
    inhalePct = inhale.inMilliseconds / total.inMilliseconds;
    _ctrl = AnimationController(vsync: this, duration: total)..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // Map normalized progress (0..1) across inhale/exhale to a scale value.
  double _scaleFor(double progress) {
    // Wrap into [0,1)
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GoRouter.of(context).go('/main');
        // Prevent back button from closing the app
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _paused = !_paused;
                if (_paused) {
                  _ctrl.stop();
                } else {
                  _ctrl.repeat();
                }
              });
            },
            child: Stack(
              children: [
                // Close button
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () => GoRouter.of(context).go('/main'),
                  ),
                ),

                // Center content
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, _) {
                      final progress = _ctrl.value;
                      final inhaling = _isInhaling(progress);

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          final shortest =
                              constraints.biggest.shortestSide; // responsive
                          final baseDiameter = shortest * 0.45;

                          final widgets = <Widget>[];

                          // Ghost/trailing circles (from farthest to nearest)
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
                                        color: mainColor.withOpacity(
                                          opacity * 0.6,
                                        ),
                                        blurRadius: 28,
                                        spreadRadius: -8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                          // Main breathing circle
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: widgets,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Pause hint (optional)
                if (_paused)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        color: Colors.black.withOpacity(0.25),
                        alignment: Alignment.center,
                        child: const Text(
                          'Paused — tap to resume',
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
      ),
    );
  }
}
