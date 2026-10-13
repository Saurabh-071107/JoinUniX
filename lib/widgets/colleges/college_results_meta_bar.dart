import 'package:flutter/material.dart';

class CollegeResultsMetaBar extends StatelessWidget {
  final int count;
  final String activeSort;
  final ValueChanged<String> onSortChanged;
  final bool isOnlyShortlisted;
  final VoidCallback onToggleShortlisted;

  const CollegeResultsMetaBar({
    super.key,
    required this.count,
    required this.activeSort,
    required this.onSortChanged,
    this.isOnlyShortlisted = false,
    required this.onToggleShortlisted,
  });

  void _showSortSheet(BuildContext context) {
    const sortOptions = [
      'NIRF Ranking',
      'Highest Rating',
      'Placement Rate',
      'Average Package',
      'Lowest Fees',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text(
              'Sort Colleges By',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            ...sortOptions.map((opt) {
              final isSelected = opt == activeSort;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () {
                  onSortChanged(opt);
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                  color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF94A3B8),
                  size: 20,
                ),
                title: Text(
                  opt,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF1E293B),
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_rounded, color: Color(0xFF4F46E5), size: 18)
                    : null,
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Result Count
          Row(
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Institutions Found',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475569),
                ),
              ),
            ],
          ),

          // Right: Action buttons (Sort + Shortlist toggle)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Saved toggle pill
              GestureDetector(
                onTap: onToggleShortlisted,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: isOnlyShortlisted ? const Color(0xFFEEF2FF) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isOnlyShortlisted ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isOnlyShortlisted ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        size: 14,
                        color: isOnlyShortlisted ? const Color(0xFF4F46E5) : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Saved',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: isOnlyShortlisted ? FontWeight.w800 : FontWeight.w600,
                          color: isOnlyShortlisted ? const Color(0xFF4F46E5) : const Color(0xFF334155),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Sort dropdown button
              GestureDetector(
                onTap: () => _showSortSheet(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.swap_vert_rounded,
                        size: 15,
                        color: Color(0xFF4F46E5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activeSort,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 15,
                        color: Color(0xFF64748B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
