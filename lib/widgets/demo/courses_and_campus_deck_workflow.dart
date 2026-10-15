import 'package:flutter/material.dart';
import 'campus_deck_view.dart';
import 'courses_intakes_view.dart';
import 'workflow_shared_widgets.dart';

export 'campus_deck_view.dart';
export 'courses_intakes_view.dart';
export 'workflow_shared_widgets.dart';

/// Master coordinator managing smooth switching between
/// Courses & Intakes and Campus Decks & 360° Tours.
class CoursesAndCampusDeckWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialTab;

  const CoursesAndCampusDeckWorkflow({
    super.key,
    this.onCompleted,
    this.initialTab = 1,
  });

  @override
  State<CoursesAndCampusDeckWorkflow> createState() =>
      _CoursesAndCampusDeckWorkflowState();
}

class _CoursesAndCampusDeckWorkflowState
    extends State<CoursesAndCampusDeckWorkflow> {
  late int _activeTab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Eyebrow Pill Badge: ACADEMIC CATALOG
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'ACADEMIC CATALOG',
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
          'Courses, Intakes & Interactive Campus Decks',
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
          'Search degree intakes across global universities and explore interactive campus research labs',
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
              title: 'Courses & Intakes',
              icon: Icons.menu_book_rounded,
            ),
            WorkflowSubTabItem(
              title: 'Campus Decks & 360°',
              icon: Icons.apartment_rounded,
            ),
          ],
          onTabSelected: (tab) => setState(() => _activeTab = tab),
        ),
        const SizedBox(height: 16),

        // 3. Screen View Transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _activeTab == 0
              ? CoursesIntakesView(
                  key: const ValueKey('courses_intakes_view'),
                  onCompleted: widget.onCompleted,
                )
              : CampusDeckView(
                  key: const ValueKey('campus_deck_view'),
                  onCompleted: widget.onCompleted,
                ),
        ),
      ],
    );
  }
}
