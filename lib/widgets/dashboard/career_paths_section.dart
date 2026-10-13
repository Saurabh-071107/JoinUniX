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
          height: 92,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: careerPathItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
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
    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        width: 148,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: item.borderColor),
          boxShadow: [
            BoxShadow(
              color: item.borderColor.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Left Title
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    height: 1.2,
                  ),
                ),
              ),
            ),
            // Right 3D Asset
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 50,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.work_outline_rounded,
                  size: 26,
                  color: Color(0xFF6366F1),
                ),
              ),
            ),
            // Bottom Right Action Arrow
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  size: 13,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
