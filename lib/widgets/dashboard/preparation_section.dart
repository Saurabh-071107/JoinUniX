import 'package:flutter/material.dart';
import '../../data/dashboard_data.dart';
import 'section_header.dart';

class PreparationSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final ValueChanged<PreparationItem>? onItemTap;

  const PreparationSection({
    super.key,
    this.onViewAll,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Your Preparation',
          actionText: 'View All',
          onActionTap: onViewAll,
        ),
        SizedBox(
          height: 136,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: preparationItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = preparationItems[index];
              return _buildPrepCard(context, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrepCard(BuildContext context, PreparationItem item) {
    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        width: 138,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: 3D Icon
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => Icon(
                  Icons.track_changes_rounded,
                  size: 26,
                  color: item.accentColor,
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Title
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            // Progress Bar + Percentage
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: item.progress,
                      minHeight: 4,
                      backgroundColor: const Color(0xFFF1F5F9),
                      valueColor: AlwaysStoppedAnimation<Color>(item.accentColor),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  item.progressText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: item.accentColor,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Subject & Metric
            Text(
              item.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
                height: 1.1,
              ),
            ),
            Text(
              item.metric,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
