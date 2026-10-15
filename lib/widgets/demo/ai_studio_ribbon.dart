import 'package:flutter/material.dart';

/// Reusable responsive tab ribbon for the 3 AI Studio modules:
/// - Tab 0: ConsulAI™ Mock
/// - Tab 1: UniQuest™ Audit
/// - Tab 2: UniFinance™ Loan
class AiStudioRibbon extends StatelessWidget {
  final int activeTab;
  final ValueChanged<int> onTabSelected;
  final EdgeInsetsGeometry padding;

  const AiStudioRibbon({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  static const List<({String label, IconData icon, int index})> _tabs = [
    (label: 'ConsulAI™ Mock', icon: Icons.mic_rounded, index: 0),
    (label: 'UniQuest™ Audit', icon: Icons.school_outlined, index: 1),
    (label: 'UniFinance™ Loan', icon: Icons.credit_card_rounded, index: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: padding,
      child: Row(
        children: [
          for (int i = 0; i < _tabs.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            _buildTabItem(_tabs[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildTabItem(({String label, IconData icon, int index}) item) {
    final isActive = activeTab == item.index;

    return InkWell(
      onTap: () => onTabSelected(item.index),
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFF1B64F8), Color(0xFF6F2CFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isActive ? null : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isActive ? null : Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? const Color(0xFF1B64F8).withValues(alpha: 0.35)
                  : const Color(0xFF0F172A).withValues(alpha: 0.03),
              blurRadius: isActive ? 10 : 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 16,
              color: isActive ? Colors.white : const Color(0xFF334155),
            ),
            const SizedBox(width: 6),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
