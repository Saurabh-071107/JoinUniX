import 'package:flutter/material.dart';
import '../widgets/explore/continue_exploration_section.dart';
import '../widgets/explore/explore_feature_grid.dart';
import '../widgets/explore/explore_filter_chips.dart';
import '../widgets/explore/explore_hero_banner.dart';
import '../widgets/explore/explore_search_bar.dart';
import '../widgets/explore/explore_top_bar.dart';
import '../widgets/explore/top_colleges_section.dart';
import 'college_search_screen.dart';

class ExploreScreen extends StatefulWidget {
  final String location;
  final ValueChanged<String>? onNotificationTap;

  const ExploreScreen({
    super.key,
    this.location = 'India',
    this.onNotificationTap,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedFilterChip = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToCollegeSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CollegeSearchScreen(
          location: widget.location.isNotEmpty ? widget.location : 'India',
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Top App Bar
            SliverToBoxAdapter(
              child: ExploreTopBar(
                selectedLocation: widget.location.isNotEmpty ? widget.location : 'India',
                onLocationTap: () => _showSnackBar('Location: ${widget.location}'),
                onNotificationTap: () => _showSnackBar('No new notifications'),
              ),
            ),

            // 2. Hero Banner: Explore Your Possibilities
            SliverToBoxAdapter(
              child: ExploreHeroBanner(
                onTap: _navigateToCollegeSearch,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 6)),

            // 3. Search & Filter Bar
            SliverToBoxAdapter(
              child: ExploreSearchBar(
                controller: _searchController,
                onTap: _navigateToCollegeSearch,
                onSubmitted: (_) => _navigateToCollegeSearch(),
                onFilterTap: _navigateToCollegeSearch,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 6)),

            // 4. Quick Category Filter Chips
            SliverToBoxAdapter(
              child: ExploreFilterChips(
                selectedIndex: _selectedFilterChip,
                onSelected: (index) {
                  setState(() => _selectedFilterChip = index);
                  if (index == 0) {
                    _navigateToCollegeSearch();
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // 5. Core 2x3 Feature Grid (6 Cards)
            SliverToBoxAdapter(
              child: ExploreFeatureGrid(
                onCardTap: (card) {
                  if (card.title == 'Find Colleges') {
                    _navigateToCollegeSearch();
                  } else {
                    _showSnackBar('Opening ${card.title}');
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 6)),

            // 6. Continue Your Exploration
            SliverToBoxAdapter(
              child: ContinueExplorationSection(
                onViewAll: () => _showSnackBar('All in-progress items'),
                onItemTap: (item) {
                  if (item.title.contains('IIT') || item.title.contains('Oxford')) {
                    _navigateToCollegeSearch();
                  } else {
                    _showSnackBar('Resuming ${item.title}');
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),

            // 7. Top Colleges For You
            SliverToBoxAdapter(
              child: TopCollegesSection(
                onCollegeTap: (college) => _navigateToCollegeSearch(),
              ),
            ),

            // Bottom space so content scrolls past floating bottom navigation bar cleanly
            const SliverToBoxAdapter(child: SizedBox(height: 104)),
          ],
        ),
      ),
    );
  }
}
