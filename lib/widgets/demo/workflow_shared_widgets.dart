import 'package:flutter/material.dart';

/// Clean, lazy background architectural vertical accent lines for cards across workflows.
class CardVerticalAccents extends StatelessWidget {
  final double borderRadius;
  final Color tintColor;

  const CardVerticalAccents({
    super.key,
    this.borderRadius = 20,
    this.tintColor = const Color(0xFF1D61E7),
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 2.2,
              margin: const EdgeInsets.only(right: 8),
              color: tintColor.withValues(alpha: 0.04),
            ),
            Container(
              width: 1.4,
              margin: const EdgeInsets.only(right: 14),
              color: tintColor.withValues(alpha: 0.028),
            ),
            Container(
              width: 1.0,
              margin: const EdgeInsets.only(right: 20),
              color: tintColor.withValues(alpha: 0.016),
            ),
          ],
        ),
      ),
    );
  }
}

/// A sub-tab item definition.
class WorkflowSubTabItem {
  final String title;
  final IconData icon;

  const WorkflowSubTabItem({required this.title, required this.icon});
}

/// Clean, responsive 2-tab segmented switcher.
class WorkflowSubTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<WorkflowSubTabItem> tabs;
  final ValueChanged<int> onTabSelected;
  final Color activeColor;

  const WorkflowSubTabBar({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
    this.activeColor = const Color(0xFF1D61E7),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTabSelected(i),
                  borderRadius: BorderRadius.circular(10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: selectedIndex == i ? activeColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: selectedIndex == i
                          ? [
                              BoxShadow(
                                color: activeColor.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          tabs[i].icon,
                          size: 18,
                          color: selectedIndex == i ? Colors.white : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tabs[i].title,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: selectedIndex == i ? FontWeight.w700 : FontWeight.w600,
                            color: selectedIndex == i ? Colors.white : const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Clean, reusable horizontal filter pills list.
class WorkflowFilterPills extends StatelessWidget {
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onSelected;
  final VoidCallback? onSettingsTap;
  final Color activeColor;

  const WorkflowFilterPills({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
    this.onSettingsTap,
    this.activeColor = const Color(0xFF1D61E7),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < options.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _buildPill(options[i]),
          ],
          if (onSettingsTap != null) ...[
            const SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSettingsTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF334155)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPill(String title) {
    final isSelected = selectedOption == title;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(title),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: isSelected ? 22 : 18, vertical: 9.5),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? activeColor : const Color(0xFFE2E8F0)),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.22),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }
}
