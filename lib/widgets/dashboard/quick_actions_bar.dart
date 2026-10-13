import 'package:flutter/material.dart';
import '../../data/dashboard_data.dart';

class QuickActionsBar extends StatelessWidget {
  final ValueChanged<QuickActionItem>? onItemTap;

  const QuickActionsBar({
    super.key,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 118,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: quickActions.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = quickActions[index];
          return _buildCard(context, item);
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, QuickActionItem item) {
    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3D Icon
            SizedBox(
              height: 36,
              width: 36,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.auto_stories_rounded,
                  size: 28,
                  color: Color(0xFF6366F1),
                ),
              ),
            ),
            const Spacer(),
            // Title + Action Arrow Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                      height: 1.15,
                    ),
                  ),
                ),
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: 14,
                    color: Color(0xFF64748B),
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
