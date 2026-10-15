import 'package:flutter/material.dart';
import 'hackathons_screen_view.dart';
import 'internships_screen_view.dart';
import 'workflow_shared_widgets.dart';

export 'hackathons_screen_view.dart';
export 'internships_screen_view.dart';
export 'workflow_shared_widgets.dart';

/// Master coordinator managing smooth segmented switching between
/// the dedicated Hackathons Screen and Internships Screen.
class HackathonsAndJobsWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialTab;

  const HackathonsAndJobsWorkflow({
    super.key,
    this.onCompleted,
    this.initialTab = 0,
  });

  @override
  State<HackathonsAndJobsWorkflow> createState() =>
      _HackathonsAndJobsWorkflowState();
}

class _HackathonsAndJobsWorkflowState extends State<HackathonsAndJobsWorkflow> {
  late int _activeTab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sub-Tab Segmented Switcher matching design
        WorkflowSubTabBar(
          selectedIndex: _activeTab,
          tabs: const [
            WorkflowSubTabItem(
              title: 'Hackathons',
              icon: Icons.laptop_chromebook_rounded,
            ),
            WorkflowSubTabItem(
              title: 'Internships',
              icon: Icons.work_rounded,
            ),
          ],
          onTabSelected: (tab) => setState(() => _activeTab = tab),
        ),
        const SizedBox(height: 16),

        // Animated Screen View transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _activeTab == 0
              ? HackathonsScreenView(
                  key: const ValueKey('hackathons_screen_view'),
                  onCompleted: widget.onCompleted,
                )
              : InternshipsScreenView(
                  key: const ValueKey('internships_screen_view'),
                  onCompleted: widget.onCompleted,
                ),
        ),
      ],
    );
  }
}
