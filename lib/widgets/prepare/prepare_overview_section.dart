import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/prepare_data.dart';

class PrepareOverviewSection extends StatefulWidget {
  const PrepareOverviewSection({super.key});

  @override
  State<PrepareOverviewSection> createState() => _PrepareOverviewSectionState();
}

class _PrepareOverviewSectionState extends State<PrepareOverviewSection> {
  late List<GoalItem> _goals;

  @override
  void initState() {
    super.initState();
    _goals = List.from(todayGoalsList);
  }

  void _toggleGoal(int index) {
    setState(() {
      final current = _goals[index];
      _goals[index] = GoalItem(
        title: current.title,
        isCompleted: !current.isCompleted,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _goals.where((g) => g.isCompleted).length;
    final goalProgress = _goals.isEmpty ? 0.0 : completedCount / _goals.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 420;
          final isWide = constraints.maxWidth >= 560;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 10 : 14,
              vertical: isCompact ? 9 : 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Overall Progress Ring (Left)
                Expanded(
                  flex: isWide ? 28 : 31,
                  child: _buildOverallRing(isCompact, isWide),
                ),

                // Divider 1
                _buildDivider(isCompact ? 80 : 95, isCompact ? 3.5 : 6),

                // 2. Subject Progress Bars (Middle)
                Expanded(
                  flex: isWide ? 36 : 35,
                  child: _buildSubjectsColumn(isCompact, isWide),
                ),

                // Divider 2
                _buildDivider(isCompact ? 95 : 110, isCompact ? 3.5 : 6),

                // 3. Today's Goal Checklist (Right)
                Expanded(
                  flex: isWide ? 36 : 34,
                  child: _buildTodayGoalColumn(completedCount, goalProgress, isCompact, isWide),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider(double height, double horizontalMargin) {
    return Container(
      width: 1,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      color: const Color(0xFFF1F5F9),
    );
  }

  Widget _buildOverallRing(bool isCompact, bool isWide) {
    final ringSize = isCompact ? 82.0 : (isWide ? 96.0 : 88.0);
    final strokeWidth = isCompact ? 7.5 : 8.5;

    return Center(
      child: SizedBox(
        width: ringSize,
        height: ringSize,
        child: CustomPaint(
          painter: _ProgressRingPainter(
            progress: overallProgressValue,
            trackColor: const Color(0xFFEFF2F6),
            strokeWidth: strokeWidth,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '68',
                      style: TextStyle(
                        fontSize: isCompact ? 20 : (isWide ? 24 : 22),
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      '%',
                      style: TextStyle(
                        fontSize: isCompact ? 12.5 : (isWide ? 15 : 13.5),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Overall Progress',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: isCompact ? 9.5 : (isWide ? 10.5 : 10.0),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                        letterSpacing: -0.1,
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

  Widget _buildSubjectsColumn(bool isCompact, bool isWide) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: subjectProgressList.map((subject) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: isCompact ? 2.5 : 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Badge Icon with light pastel circle
              Container(
                width: isCompact ? 21 : 25,
                height: isCompact ? 21 : 25,
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: subject.color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  subject.iconPath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.circle,
                    size: 13,
                    color: subject.color,
                  ),
                ),
              ),
              SizedBox(width: isCompact ? 5 : 7),

              // Title on line 1, progress bar & % on line 2
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isCompact ? 10.5 : (isWide ? 12.0 : 11.5),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2.5),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: subject.progress,
                              minHeight: isCompact ? 4.0 : 5.0,
                              backgroundColor: const Color(0xFFF1F5F9),
                              valueColor: AlwaysStoppedAnimation<Color>(subject.color),
                            ),
                          ),
                        ),
                        SizedBox(width: isCompact ? 5 : 7),
                        Text(
                          '${(subject.progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: isCompact ? 10.0 : (isWide ? 11.5 : 11.0),
                            fontWeight: FontWeight.w800,
                            color: subject.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTodayGoalColumn(int completedCount, double goalProgress, bool isCompact, bool isWide) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              width: isCompact ? 21 : 25,
              height: isCompact ? 21 : 25,
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.gps_fixed_rounded,
                size: isCompact ? 12.5 : 14,
                color: const Color(0xFF4F46E5),
              ),
            ),
            SizedBox(width: isCompact ? 5 : 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Goal",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isCompact ? 11.0 : (isWide ? 12.5 : 12.0),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  Text(
                    '$completedCount/${_goals.length} completed',
                    style: TextStyle(
                      fontSize: isCompact ? 8.5 : (isWide ? 9.5 : 9.0),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: isCompact ? 3.5 : 4.5),

        // Mini progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(2.5),
          child: LinearProgressIndicator(
            value: goalProgress,
            minHeight: isCompact ? 3.0 : 4.0,
            backgroundColor: const Color(0xFFF1F5F9),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
        ),
        SizedBox(height: isCompact ? 4.0 : 5.0),

        // 5-item Checklist
        ...List.generate(_goals.length, (index) {
          final goal = _goals[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: isCompact ? 1.0 : 1.4),
            child: GestureDetector(
              onTap: () => _toggleGoal(index),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Icon(
                    goal.isCompleted
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: isCompact ? 12.0 : 13.5,
                    color: goal.isCompleted
                        ? const Color(0xFF10B981)
                        : const Color(0xFFCBD5E1),
                  ),
                  SizedBox(width: isCompact ? 4.0 : 5.5),
                  Expanded(
                    child: Text(
                      goal.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isCompact ? 9.2 : (isWide ? 10.5 : 10.0),
                        fontWeight: goal.isCompleted ? FontWeight.w600 : FontWeight.w500,
                        color: goal.isCompleted
                            ? const Color(0xFF334155)
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final double strokeWidth;

  const _ProgressRingPainter({
    required this.progress,
    required this.trackColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress Arc with smooth gradient
    final progressPaint = Paint()
      ..shader = const SweepGradient(
        colors: [Color(0xFF6366F1), Color(0xFF3B82F6), Color(0xFF8B5CF6)],
        transform: GradientRotation(-math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = math.pi * 2 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.strokeWidth != strokeWidth;
}
