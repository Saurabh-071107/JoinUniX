import 'package:flutter/material.dart';
import 'alumni_mentors_view.dart';
import 'unistay_housing_view.dart';
import 'workflow_shared_widgets.dart';

export 'alumni_mentors_view.dart';
export 'unistay_housing_view.dart';
export 'workflow_shared_widgets.dart';

/// Master coordinator managing smooth switching between
/// UniStay Housing accommodations and CampusConnect Alumni Mentors.
class UniStayAndMentorsWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialTab;

  const UniStayAndMentorsWorkflow({
    super.key,
    this.onCompleted,
    this.initialTab = 0,
  });

  @override
  State<UniStayAndMentorsWorkflow> createState() =>
      _UniStayAndMentorsWorkflowState();
}

class _UniStayAndMentorsWorkflowState extends State<UniStayAndMentorsWorkflow> {
  late int _activeTab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Eyebrow Pill Badge: STUDENT ECOSYSTEM
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'STUDENT ECOSYSTEM',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Color(0xFF2563EB),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Title
        const Text(
          'Campus Life & Mentorship Network',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),

        // Subtitle
        const Text(
          'Find vetted student accommodations and connect 1-on-1 with seniors & alumni abroad',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),

        // 2. Segmented Sub-tab Switcher
        WorkflowSubTabBar(
          selectedIndex: _activeTab,
          tabs: const [
            WorkflowSubTabItem(
              title: 'UniStay Housing',
              icon: Icons.apartment_rounded,
            ),
            WorkflowSubTabItem(
              title: 'CampusConnect Mentors',
              icon: Icons.people_outline_rounded,
            ),
          ],
          onTabSelected: (tab) => setState(() => _activeTab = tab),
        ),
        const SizedBox(height: 16),

        // 3. Screen View Transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _activeTab == 0
              ? const UniStayHousingView()
              : const AlumniMentorsView(),
        ),
      ],
    );
  }
}
