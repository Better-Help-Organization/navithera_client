import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedGradientBackground extends StatefulWidget {
  @override
  _AnimatedGradientBackgroundState createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Color> colorsList;

  @override
  void initState() {
    super.initState();
    // Increased number of colors for smoother transitions,
    // with emphasis on blue tones for the primary color.
    colorsList = [
      Color(0xFF42A5F5), // Light blue - primary and always visible
      Color(0xFF4A8AF4), // Slightly darker blue
      Color(0xFF5C6EE8), // Medium blue
      Color(0xFF64B5F6), // Another light blue shade
      Color(0xFF7986CB), // Bluish-purple
      Color(0xFF7E57C2), // Purple
      Color(0xFF9575CD), // Lighter purple
      Color(0xFFAD8FEA), // Even lighter purple/pink
      Color(0xFFC7A3EB), // Very light purple
      Color(0xFFB39DDB), // Muted purple
      Color(0xFF9FA8DA), // Muted blue
      Color(0xFF81D4FA), // Sky blue
      Color(0xFF42A5F5), // Repeat primary color to ensure continuous presence
    ];

    _controller = AnimationController(
      duration: const Duration(
        seconds: 30,
      ), // Increased duration for a slower, smoother animation
      vsync: this,
    )..repeat(reverse: true); // Added reverse to make the loop even smoother
  }

  Color _getColorAtProgress(double progress) {
    // Ensure progress is within [0, 1]
    progress = progress.clamp(0.0, 1.0);

    // Scale progress to the full length of the colors list
    double scaledProgress = progress * (colorsList.length - 1);

    // Determine the two colors to interpolate between
    int fromIndex = scaledProgress.floor();
    int toIndex = (fromIndex + 1);

    // Handle wrapping around for the last color
    if (toIndex >= colorsList.length) {
      toIndex = 0; // Wrap back to the beginning
    }

    // Calculate the local progress between the two colors
    double localProgress = scaledProgress - fromIndex;

    return Color.lerp(
      colorsList[fromIndex],
      colorsList[toIndex],
      localProgress,
    )!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double progress = _controller.value;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getColorAtProgress(progress),
                _getColorAtProgress((progress + 0.33) % 1),
                _getColorAtProgress((progress + 0.66) % 1),
              ],
              stops: const [0.0, 0.5, 1.0],
              // You can adjust the rotation speed here
              transform: GradientRotation(progress * 2 * math.pi),
            ),
          ),
        );
      },
    );
  }
}
