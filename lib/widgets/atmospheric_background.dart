import 'package:flutter/material.dart';

/// Reusable atmospheric background with gradient, ambient orbs, and decorative sparkles.
class AtmosphericBackground extends StatelessWidget {
  const AtmosphericBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Multi-stop sky gradient
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEAF3FD),
                    Color(0xFFF3F8FE),
                    Color(0xFFFFFFFF),
                    Color(0xFFF0F5FD),
                  ],
                  stops: [0.0, 0.28, 0.65, 1.0],
                ),
              ),
            ),

            // 2. Ambient glowing orbs
            Positioned(
              top: -50,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFBAE6FD).withValues(alpha: 0.55),
                      const Color(0xFFBAE6FD).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFE9D5FF).withValues(alpha: 0.45),
                      const Color(0xFFE9D5FF).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 240,
              right: -50,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFEDE9FE).withValues(alpha: 0.50),
                      const Color(0xFFEDE9FE).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Floating sparkling stars & rings
            const Positioned(
              top: 40,
              right: 32,
              child: Icon(
                Icons.auto_awesome,
                size: 22,
                color: Color(0xFFFFB020),
              ),
            ),
            const Positioned(
              top: 170,
              left: 20,
              child: Icon(
                Icons.auto_awesome,
                size: 18,
                color: Color(0xFF4C8DFF),
              ),
            ),
            Positioned(
              bottom: 120,
              right: 24,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF8E51FF).withValues(alpha: 0.22),
                    width: 2,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 28,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00BA88).withValues(alpha: 0.25),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
