import 'package:flutter/material.dart';

/// Animated gradient loading progress bar.
class SplashLoadingBar extends StatelessWidget {
  final double progress;
  final double width;
  final double height;

  const SplashLoadingBar({
    super.key,
    required this.progress,
    this.width = 200,
    this.height = 6,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E7F3),
        borderRadius: BorderRadius.circular(height / 2),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: clampedProgress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF7A00),
                Color(0xFFFFA927),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7A00).withValues(alpha: 0.35),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
