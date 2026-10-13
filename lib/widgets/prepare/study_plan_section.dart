import 'package:flutter/material.dart';
import '../../data/prepare_data.dart';

class StudyPlanSection extends StatelessWidget {
  final VoidCallback? onViewPlan;
  final ValueChanged<StudyDayItem>? onDayTap;

  const StudyPlanSection({
    super.key,
    this.onViewPlan,
    this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Study Plan',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: onViewPlan,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View Plan',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFF4F46E5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Square Date Cards with Horizontal Scroll (No overflow)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: studyPlanDays.map((dayItem) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _buildSquareDayCard(dayItem),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSquareDayCard(StudyDayItem dayItem) {
    return GestureDetector(
      onTap: () => onDayTap?.call(dayItem),
      child: Container(
        width: 78,
        height: 78,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: dayItem.isActive ? const Color(0xFF4F46E5) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: dayItem.isActive
                ? const Color(0xFF4F46E5)
                : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: dayItem.isActive
                  ? const Color(0xFF4F46E5).withValues(alpha: 0.32)
                  : Colors.black.withValues(alpha: 0.03),
              blurRadius: dayItem.isActive ? 10 : 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Day Label
            Text(
              dayItem.day,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                color: dayItem.isActive ? Colors.white : const Color(0xFF0F172A),
                letterSpacing: -0.2,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 2),

            // Icon
            _buildDayIcon(dayItem),
            const SizedBox(height: 2),

            // Progress Text
            Text(
              dayItem.progressText,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: dayItem.isActive ? FontWeight.w800 : FontWeight.w700,
                color: dayItem.isActive
                    ? Colors.white.withValues(alpha: 0.95)
                    : const Color(0xFF64748B),
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayIcon(StudyDayItem item) {
    if (item.isActive) {
      return Container(
        width: 19,
        height: 19,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: const Center(
          child: Icon(Icons.circle, size: 6.5, color: Colors.white),
        ),
      );
    }
    if (item.isCompleted) {
      return const Icon(
        Icons.check_circle_rounded,
        size: 19,
        color: Color(0xFF10B981),
      );
    }
    return const Icon(
      Icons.school_rounded,
      size: 18,
      color: Color(0xFF94A3B8),
    );
  }
}
