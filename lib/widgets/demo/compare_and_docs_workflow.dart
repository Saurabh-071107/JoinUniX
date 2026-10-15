import 'package:flutter/material.dart';
import 'ai_document_studio_view.dart';
import 'university_compare_view.dart';
import 'workflow_shared_widgets.dart';

export 'ai_document_studio_view.dart';
export 'university_compare_view.dart';
export 'workflow_shared_widgets.dart';

/// Master coordinator managing smooth switching between
/// 4-Way University Comparison Matrix and AI Document Studio.
class CompareAndDocsWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialTab;

  const CompareAndDocsWorkflow({
    super.key,
    this.onCompleted,
    this.initialTab = 0,
  });

  @override
  State<CompareAndDocsWorkflow> createState() => _CompareAndDocsWorkflowState();
}

class _CompareAndDocsWorkflowState extends State<CompareAndDocsWorkflow> {
  late int _activeTab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Eyebrow Pill Badge: ADMISSIONS TOOLS
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'ADMISSIONS TOOLS',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: Color(0xFF0F62FE),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Title
        const Text(
          'Admissions Intelligence & Document Studio',
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
          'Compare global universities side-by-side or draft Ivy-standard SOPs & LORs with AI',
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
              title: '4-Way Uni Compare',
              icon: Icons.compare_arrows_rounded,
            ),
            WorkflowSubTabItem(
              title: 'AI Document Studio™',
              icon: Icons.edit_document,
            ),
          ],
          onTabSelected: (tab) => setState(() => _activeTab = tab),
        ),
        const SizedBox(height: 16),

        // 3. Screen View Transition
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _activeTab == 0
              ? const UniversityCompareView()
              : const AiDocumentStudioView(),
        ),
      ],
    );
  }
}
