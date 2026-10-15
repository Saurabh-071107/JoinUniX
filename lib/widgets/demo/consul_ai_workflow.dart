import 'package:flutter/material.dart';
import 'consul_ai_view.dart';
import 'unifinance_workflow.dart';
import 'uniquest_workflow.dart';

export 'ai_studio_ribbon.dart';
export 'consul_ai_view.dart';
export 'unifinance_workflow.dart';
export 'uniquest_workflow.dart';

/// Unified AI Studio host container managing smooth in-place tab transitions
/// between ConsulAI™ Mock, UniQuest™ Audit, and UniFinance™ Loans.
class ConsulAiWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final int initialRibbonTab;

  const ConsulAiWorkflow({
    super.key,
    this.onCompleted,
    this.initialRibbonTab = 0,
  });

  @override
  State<ConsulAiWorkflow> createState() => _ConsulAiWorkflowState();
}

class _ConsulAiWorkflowState extends State<ConsulAiWorkflow> {
  late int _activeRibbonTab = widget.initialRibbonTab;

  @override
  void didUpdateWidget(covariant ConsulAiWorkflow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRibbonTab != widget.initialRibbonTab) {
      _activeRibbonTab = widget.initialRibbonTab;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: switch (_activeRibbonTab) {
            1 => UniQuestWorkflow(
                key: const ValueKey('tab_uniquest'),
                onCompleted: widget.onCompleted,
                onSwitchToConsulAi: () => setState(() => _activeRibbonTab = 0),
                onSwitchToUniFinance: () => setState(() => _activeRibbonTab = 2),
                onRibbonTabChanged: (tab) => setState(() => _activeRibbonTab = tab),
              ),
            2 => UniFinanceWorkflow(
                key: const ValueKey('tab_unifinance'),
                onCompleted: widget.onCompleted,
                onSwitchToConsulAi: () => setState(() => _activeRibbonTab = 0),
                onSwitchToUniQuest: () => setState(() => _activeRibbonTab = 1),
                onRibbonTabChanged: (tab) => setState(() => _activeRibbonTab = tab),
              ),
            _ => ConsulAiView(
                key: const ValueKey('tab_consulai'),
                onCompleted: widget.onCompleted,
                onRibbonTabChanged: (tab) => setState(() => _activeRibbonTab = tab),
              ),
          },
        ),
      ),
    );
  }
}
