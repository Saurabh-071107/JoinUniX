import 'dart:math' as math;
import 'package:flutter/material.dart';

class JourneyHeroSection extends StatelessWidget {
  final String stream;
  final VoidCallback? onContinueJourney;
  final VoidCallback? onAmbitionTap;

  const JourneyHeroSection({
    super.key,
    this.stream = 'Engineering',
    this.onContinueJourney,
    this.onAmbitionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 360;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Left Card: "Your Engineering Journey" (~60-62% flex)
                Expanded(
                  flex: isNarrow ? 58 : 62,
                  child: _buildJourneyCard(context),
                ),
                const SizedBox(width: 10),
                // 2. Right Card: "Turn Your Ambition into Opportunity" (~38-40% flex)
                Expanded(
                  flex: isNarrow ? 42 : 38,
                  child: _buildAmbitionCard(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildJourneyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: "Your Engineering Journey" + arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                    children: [
                      const TextSpan(text: 'Your '),
                      TextSpan(
                        text: stream.isNotEmpty ? stream : 'Engineering',
                        style: const TextStyle(color: Color(0xFF6366F1)),
                      ),
                      const TextSpan(text: ' Journey'),
                    ],
                  ),
                ),
              ),
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 13,
                  color: Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress indicator + Checklist
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular progress
              const SizedBox(
                width: 72,
                height: 72,
                child: CustomPaint(
                  painter: _ProgressRingPainter(
                    progress: 0.68,
                    strokeWidth: 7,
                    startColor: Color(0xFF38BDF8),
                    endColor: Color(0xFF6366F1),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '68%',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Checklist
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _checkItem('Profile Setup', true),
                    const SizedBox(height: 4),
                    _checkItem('Career Exploration', true),
                    const SizedBox(height: 4),
                    _checkItem('College Shortlist', false),
                    const SizedBox(height: 4),
                    _checkItem('Prepare & Practice', false),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // "Continue Journey →" Button
          GestureDetector(
            onTap: onContinueJourney,
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue Journey',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkItem(String title, bool isCompleted) {
    return Row(
      children: [
        isCompleted
            ? Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 10,
                  color: Colors.white,
                ),
              )
            : Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
                ),
              ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
              color: isCompleted ? const Color(0xFF334155) : const Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmbitionCard(BuildContext context) {
    return GestureDetector(
      onTap: onAmbitionTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image illustration
            Expanded(
              child: Container(
                color: const Color(0xFFF0F7FF),
                child: Image.asset(
                  'assets/images/dashboard/ambition_student.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, _, _) => Center(
                    child: Icon(
                      Icons.school_rounded,
                      size: 44,
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Text & Action
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Turn',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF64748B),
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Your Ambition',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.15,
                          ),
                        ),
                        Text(
                          'into Opportunity',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF6366F1),
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 13,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color startColor;
  final Color endColor;

  const _ProgressRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = const Color(0xFFEEF2F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc
    final sweepAngle = 2 * math.pi * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final progressPaint = Paint()
      ..shader = SweepGradient(
        colors: [startColor, endColor, startColor],
        stops: const [0.0, 0.7, 1.0],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, -math.pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
