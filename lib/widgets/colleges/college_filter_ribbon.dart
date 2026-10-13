import 'package:flutter/material.dart';
import '../../data/college_search_data.dart';

class CollegeFilterRibbon extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final VoidCallback onFilterDrawerTap;
  final int activeFilterCount;

  const CollegeFilterRibbon({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onFilterDrawerTap,
    this.activeFilterCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: collegeCategoryFilters.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // Index 0 is the Advanced Filters Button
          if (index == 0) {
            final hasFilters = activeFilterCount > 0;
            return GestureDetector(
              onTap: onFilterDrawerTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: hasFilters ? const Color(0xFFEEF2FF) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: hasFilters ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
                    width: hasFilters ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      size: 15,
                      color: hasFilters ? const Color(0xFF4F46E5) : const Color(0xFF475569),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: hasFilters ? const Color(0xFF4F46E5) : const Color(0xFF334155),
                      ),
                    ),
                    if (hasFilters) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4F46E5),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$activeFilterCount',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }

          final category = collegeCategoryFilters[index - 1];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? const Color(0xFF0F172A).withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
