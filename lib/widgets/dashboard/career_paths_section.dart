import 'package:flutter/material.dart';
import '../../data/dashboard_data.dart';
import 'section_header.dart';

class CareerPathsSection extends StatelessWidget {
  final VoidCallback? onSeeAll;
  final ValueChanged<CareerPathItem>? onItemTap;

  const CareerPathsSection({
    super.key,
    this.onSeeAll,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Explore Career Paths',
          actionText: 'See All',
          onActionTap: onSeeAll,
        ),
        SizedBox(
          height: 142,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: careerPathItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = careerPathItems[index];
              return _buildCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, CareerPathItem item) {
    final arrowColor = switch (item.title) {
      String t when t.contains('Software') => const Color(0xFF7C3AED),
      String t when t.contains('AI') => const Color(0xFFF97316),
      String t when t.contains('Robotics') => const Color(0xFF2563EB),
      _ => const Color(0xFF059669),
    };

    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        width: 126,
        padding: const EdgeInsets.fromLTRB(12, 14, 10, 12),
        decoration: BoxDecoration(
          color: item.bgColor,
          gradient: LinearGradient(
            colors: [
              Colors.white,
              item.bgColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: item.borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: item.borderColor.withValues(alpha: 0.35),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered Large 3D Asset
            Center(
              child: SizedBox(
                width: 66,
                height: 64,
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.work_outline_rounded,
                    size: 36,
                    color: arrowColor,
                  ),
                ),
              ),
            ),
            const Spacer(),
            // Bottom Row: 2-line Title & Arrow Button
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                      height: 1.15,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: arrowColor.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: arrowColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
