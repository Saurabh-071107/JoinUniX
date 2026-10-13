import 'package:flutter/material.dart';
import '../../data/opportunities_data.dart';

class OpportunitiesCategoryTabs extends StatelessWidget {
  final String selectedTabId;
  final ValueChanged<String>? onTabSelected;

  const OpportunitiesCategoryTabs({
    super.key,
    this.selectedTabId = 'internships',
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: opportunityCategoryTabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final tab = opportunityCategoryTabs[index];
          final isSelected = tab.id == selectedTabId;

          return GestureDetector(
            onTap: () => onTabSelected?.call(tab.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 98,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEEF2FF) : tab.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : tab.borderColor,
                  width: isSelected ? 1.8 : 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? const Color(0xFF6366F1).withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 3D Category Icon (enlarged)
                  Image.asset(
                    tab.iconPath,
                    width: 38,
                    height: 38,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.work_outline_rounded,
                      size: 32,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                  const SizedBox(height: 7),
                  // Label
                  Text(
                    tab.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF1E293B),
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
