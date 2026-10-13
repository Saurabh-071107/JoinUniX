import 'package:flutter/material.dart';
import '../../data/prepare_data.dart';

class PracticeTestsSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final ValueChanged<PracticeTestCardItem>? onCardTap;

  const PracticeTestsSection({
    super.key,
    this.onViewAll,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Practice & Tests',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View All',
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
          const SizedBox(height: 12),

          // 2x2 Grid Layout (Without horizontal scroll)
          Row(
            children: [
              Expanded(child: _buildGridCard(practiceTestCards[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildGridCard(practiceTestCards[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildGridCard(practiceTestCards[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildGridCard(practiceTestCards[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridCard(PracticeTestCardItem card) {
    return GestureDetector(
      onTap: () => onCardTap?.call(card),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: card.bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: card.borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: card.accentColor.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Icon and Circular Chevron
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  card.iconPath,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.assignment_outlined,
                    size: 30,
                    color: card.accentColor,
                  ),
                ),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                    color: card.accentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title & Subtitle
            Text(
              card.title.replaceAll('\n', ' '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              card.subtitle.replaceAll('\n', ' '),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
