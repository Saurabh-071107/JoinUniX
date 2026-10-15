import 'package:flutter/material.dart';
import '../../data/dashboard_data.dart';

class QuickActionsBar extends StatelessWidget {
  final ValueChanged<QuickActionItem>? onItemTap;
  final List<QuickActionItem> items;

  const QuickActionsBar({
    super.key,
    this.onItemTap,
    this.items = quickActions,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth - 32; // 16px padding on each side
        const spacing = 10.0;
        final totalSpacing = spacing * (items.length - 1);
        final itemWidth = (availableWidth - totalSpacing) / items.length;

        // If items can fit in a single row (>= 75px each),
        // expand them to cover the entire horizontal space!
        if (itemWidth >= 75) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 118,
              child: Row(
                children: [
                  for (int i = 0; i < items.length; i++) ...[
                    if (i > 0) const SizedBox(width: spacing),
                    Expanded(
                      child: _buildCard(context, items[i]),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        // Fallback for very narrow screens: scrollable row
        return SizedBox(
          height: 118,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: spacing),
            itemBuilder: (context, index) => SizedBox(
              width: 96,
              child: _buildCard(context, items[index]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, QuickActionItem item) {
    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
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
              height: 38,
              width: 38,
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
                  width: 20,
                  height: 20,
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
