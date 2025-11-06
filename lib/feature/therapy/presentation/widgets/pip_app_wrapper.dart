import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/pip_manager.dart';

/// Wrapper widget that should be placed at the root of your app
/// to enable PiP functionality across all screens
class PiPAppWrapper extends ConsumerWidget {
  final Widget child;

  const PiPAppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipState = ref.watch(pipManagerProvider);

    return Stack(
      children: [
        // Main app content
        child,

        // PiP overlay (only shown when active)
        if (pipState.isActive)
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child:
                  Container(), // PiP widget will be inserted here by PiPManager
            ),
          ),
      ],
    );
  }
}

/// Extension to easily check if PiP is active from anywhere in the app
extension PiPContext on BuildContext {
  bool get isPiPActive {
    return PiPManager.isActive;
  }
}
