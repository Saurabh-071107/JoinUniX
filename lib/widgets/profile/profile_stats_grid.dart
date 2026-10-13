import 'package:flutter/material.dart';
import '../../data/profile_data.dart';

class ProfileStatsGrid extends StatelessWidget {
  final ValueChanged<ProfileStatItem>? onStatTap;

  const ProfileStatsGrid({
    super.key,
    this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(profileStatsList.length, (index) {
          final stat = profileStatsList[index];
          final isLast = index == profileStatsList.length - 1;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: isLast ? 0 : 8),
              child: GestureDetector(
                onTap: () => onStatTap?.call(stat),
                child: Container(
                  height: 94,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: stat.bgColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: stat.borderColor,
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: stat.iconColor.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        stat.icon,
                        size: 22,
                        color: stat.iconColor,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        stat.value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          height: 1.1,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        stat.label,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
