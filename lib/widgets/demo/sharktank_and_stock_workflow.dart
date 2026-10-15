import 'package:flutter/material.dart';
import 'sharktank_pitch_view.dart';
import 'stock_market_game_view.dart';
import 'workflow_shared_widgets.dart';

export 'sharktank_pitch_view.dart';
export 'stock_market_game_view.dart';
export 'workflow_shared_widgets.dart';

/// Master coordinator managing smooth switching between
/// College SharkTank pitches and the ₹10L Stock Market Simulation.
class SharkTankAndStockWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialTab;

  const SharkTankAndStockWorkflow({
    super.key,
    this.onCompleted,
    this.initialTab = 0,
  });

  @override
  State<SharkTankAndStockWorkflow> createState() =>
      _SharkTankAndStockWorkflowState();
}

class _SharkTankAndStockWorkflowState extends State<SharkTankAndStockWorkflow> {
  late int _activeTab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Eyebrow Pill Badge: STUDENT ARENA
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'STUDENT ARENA',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xFFD97706),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Title
        const Text(
          'Student Arena & Financial Games',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1B2A56),
            letterSpacing: -0.5,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),

        // Subtitle
        const Text(
          'Pitch campus startups to angel investors or trade live equities with ₹10L simulated capital',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF5D7196),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),

        // 2. Segmented Sub-tab Switcher
        WorkflowSubTabBar(
          selectedIndex: _activeTab,
          tabs: const [
            WorkflowSubTabItem(
              title: 'College SharkTank',
              icon: Icons.rocket_launch_rounded,
            ),
            WorkflowSubTabItem(
              title: 'Stock Game (₹10L Sim)',
              icon: Icons.trending_up_rounded,
            ),
          ],
          onTabSelected: (tab) => setState(() => _activeTab = tab),
        ),
        const SizedBox(height: 16),

        // 3. Screen View Transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _activeTab == 0
              ? const SharkTankPitchView()
              : const StockMarketGameView(),
        ),
      ],
    );
  }
}
