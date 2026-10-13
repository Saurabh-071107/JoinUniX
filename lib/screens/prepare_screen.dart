import 'package:flutter/material.dart';
import '../widgets/prepare/prepare_header.dart';
import '../widgets/prepare/prepare_overview_section.dart';
import '../widgets/prepare/continue_learning_card.dart';
import '../widgets/prepare/study_plan_section.dart';
import '../widgets/prepare/chapters_topics_section.dart';
import '../widgets/prepare/practice_tests_section.dart';
import '../widgets/prepare/streak_banner.dart';

class PrepareScreen extends StatelessWidget {
  final Function(String message)? onAction;

  const PrepareScreen({
    super.key,
    this.onAction,
  });

  void _notify(BuildContext context, String message) {
    if (onAction != null) {
      onAction!(message);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top Header with 3D Illustration & Title
                const SliverToBoxAdapter(
                  child: PrepareHeader(),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // Overall Progress Ring & Today's Goal Section
                const SliverToBoxAdapter(
                  child: PrepareOverviewSection(),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // Continue Learning Banner
                SliverToBoxAdapter(
                  child: ContinueLearningCard(
                    onContinue: () => _notify(context, 'Continuing Rotational Motion'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 7-Day Study Plan
                SliverToBoxAdapter(
                  child: StudyPlanSection(
                    onViewPlan: () => _notify(context, 'Opening Full Study Plan'),
                    onDayTap: (day) => _notify(context, 'Study Day: ${day.day} (${day.progressText})'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // Chapters & Topics Section
                SliverToBoxAdapter(
                  child: ChaptersTopicsSection(
                    onViewAll: () => _notify(context, 'Viewing All Chapters & Topics'),
                    onSubjectTap: (group) => _notify(context, 'Opened ${group.subject} syllabus'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // Practice & Tests Section
                SliverToBoxAdapter(
                  child: PracticeTestsSection(
                    onViewAll: () => _notify(context, 'Viewing All Practice Sets & Tests'),
                    onCardTap: (card) => _notify(context, 'Selected: ${card.title.replaceAll('\n', ' ')}'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 6)),

                // Streak Banner
                SliverToBoxAdapter(
                  child: StreakBanner(
                    streakDays: 7,
                    onTap: () => _notify(context, 'Streak: 7 Days active learning!'),
                  ),
                ),

                // Bottom Padding for floating navigation bar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 108),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
