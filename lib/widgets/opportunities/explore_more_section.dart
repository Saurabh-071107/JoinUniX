import 'package:flutter/material.dart';
import '../../data/opportunities_data.dart';

class ExploreMoreSection extends StatelessWidget {
  final ValueChanged<ExploreMoreItem>? onItemTap;

  const ExploreMoreSection({
    super.key,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Text(
            'Explore More',
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
        ),

        // Responsive Grid/Row of 4 Feature Cards (Intrinsic layout, zero shrinkwrap issues)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 580;

              if (isWide) {
                // Wide: 1 row of 4 cards
                return Row(
                  children: [
                    for (var i = 0; i < exploreMoreList.length; i++) ...[
                      if (i > 0) const SizedBox(width: 12),
                      Expanded(
                        child: _buildCard(exploreMoreList[i]),
                      ),
                    ],
                  ],
                );
              }

              // Mobile: 2 rows of 2 cards
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildCard(exploreMoreList[0])),
                      const SizedBox(width: 12),
                      Expanded(child: _buildCard(exploreMoreList[1])),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildCard(exploreMoreList[2])),
                      const SizedBox(width: 12),
                      Expanded(child: _buildCard(exploreMoreList[3])),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(ExploreMoreItem item) {
    return GestureDetector(
      onTap: () => onItemTap?.call(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: item.borderColor,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: item.accentColor.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left 3D Icon (Enlarged)
            Image.asset(
              item.iconPath,
              width: 38,
              height: 38,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Icon(
                Icons.star_rounded,
                size: 32,
                color: item.accentColor,
              ),
            ),
            const SizedBox(width: 9),

            // Middle Titles
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
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
                    item.subtitle.replaceAll('\n', ' '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 6),

            // Right Chevron Button
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 17,
                color: item.accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
