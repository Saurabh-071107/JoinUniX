import 'package:flutter/material.dart';
import '../data/features.dart';
import '../widgets/opportunities/opportunities_header.dart';
import '../widgets/opportunities/opportunities_category_tabs.dart';
import '../widgets/opportunities/recommended_opportunities_section.dart';
import '../widgets/opportunities/upcoming_deadlines_section.dart';
import '../widgets/opportunities/explore_more_section.dart';
import 'feature_screen.dart';

class OpportunitiesScreen extends StatefulWidget {
  final Persona persona;
  final Function(String message)? onAction;

  const OpportunitiesScreen({
    super.key,
    this.persona = Persona.senior,
    this.onAction,
  });

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  String _selectedTabId = 'internships';

  void _notify(String message) {
    if (widget.onAction != null) {
      widget.onAction!(message);
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
                // 1. Top Header Banner
                SliverToBoxAdapter(
                  child: OpportunitiesHeader(
                    onTap: () => _notify('Discover opportunities beyond classrooms'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),

                // 2. Category Filter Tabs
                SliverToBoxAdapter(
                  child: OpportunitiesCategoryTabs(
                    selectedTabId: _selectedTabId,
                    onTabSelected: (tabId) {
                      setState(() => _selectedTabId = tabId);
                      _notify('Filtered by: ${tabId[0].toUpperCase()}${tabId.substring(1)}');
                    },
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 3. Recommended for You (Google, ISRO, Microsoft)
                SliverToBoxAdapter(
                  child: RecommendedOpportunitiesSection(
                    onViewAll: () => _notify('Viewing all recommended opportunities'),
                    onItemTap: (item) => _notify('Selected: ${item.title} at ${item.organization}'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 4. Upcoming Deadlines
                SliverToBoxAdapter(
                  child: UpcomingDeadlinesSection(
                    onViewAll: () => _notify('Viewing all deadlines'),
                    onItemTap: (item) => _notify('Deadline: ${item.title} (${item.day} ${item.month})'),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 14)),

                // 5. Explore More
                SliverToBoxAdapter(
                  child: ExploreMoreSection(
                    onItemTap: (item) {
                      final f = Feature.firstFor(widget.persona, switch (item.id) {
                        'top-companies' => const [Feature.hackathons],
                        'hackathons' => const [Feature.hackathons, Feature.sharkTank],
                        'scholarships' => const [Feature.scholarships],
                        'research' => const [Feature.coursesCampus],
                        _ => const [],
                      });
                      f != null ? openFeature(context, f) : _notify('${item.title} coming soon for your stage');
                    },
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
