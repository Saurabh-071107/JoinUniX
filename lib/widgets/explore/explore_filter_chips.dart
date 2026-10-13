import 'package:flutter/material.dart';

class ExploreFilterChips extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  const ExploreFilterChips({
    super.key,
    this.selectedIndex = 0,
    this.onSelected,
  });

  static const _filters = [
    _FilterItem('Colleges', Icons.account_balance_rounded, Color(0xFF6366F1)),
    _FilterItem('Courses', Icons.school_rounded, Color(0xFFA855F7)),
    _FilterItem('Careers', Icons.work_rounded, Color(0xFF0284C7)),
    _FilterItem('Exams', Icons.description_rounded, Color(0xFF6366F1)),
    _FilterItem('Countries', Icons.public_rounded, Color(0xFF8B5CF6)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onSelected?.call(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF6366F1) : const Color(0xFFE2E8F0),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.28),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    filter.icon,
                    size: 16,
                    color: isSelected ? Colors.white : filter.color,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter.label,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF334155),
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

class _FilterItem {
  final String label;
  final IconData icon;
  final Color color;

  const _FilterItem(this.label, this.icon, this.color);
}
