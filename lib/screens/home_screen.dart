import 'package:flutter/material.dart';
import '../widgets/dashboard/career_paths_section.dart';
import '../widgets/dashboard/dashboard_bottom_nav.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/journey_hero_section.dart';
import '../widgets/dashboard/preparation_section.dart';
import '../widgets/dashboard/quick_actions_bar.dart';
import '../widgets/dashboard/recommended_section.dart';
import '../widgets/dashboard/upcoming_section.dart';
import 'college_search_screen.dart';
import 'explore_screen.dart';
import 'prepare_screen.dart';
import 'opportunities_screen.dart';
import '../data/profile_data.dart';
import 'profile_screen.dart';

/// Full-featured, responsive dashboard matching the reference design.
class HomeScreen extends StatefulWidget {
  final String userName;
  final String stage;
  final String stream;
  final String selectedClass;
  final List<String> interests;
  final List<String> goals;
  final String location;

  const HomeScreen({
    super.key,
    this.userName = 'Saurabh',
    this.stage = '',
    this.stream = '',
    this.selectedClass = '',
    this.interests = const [],
    this.goals = const [],
    this.location = '',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  String get _displayName =>
      widget.userName.trim().isNotEmpty ? widget.userName.trim() : 'Saurabh';

  String get _displayRole {
    if (widget.stream.isNotEmpty) {
      return '${widget.stream} Aspirant';
    }
    if (widget.stage.isNotEmpty) {
      return '${widget.stage} Aspirant';
    }
    return 'Engineering Aspirant';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: _buildCurrentBody(),
          ),
        ),
      ),
      bottomNavigationBar: DashboardBottomNav(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
    );
  }

  Widget _buildCurrentBody() {
    switch (_navIndex) {
      case 1:
        return _buildExploreTab();
      case 2:
        return _buildPrepareTab();
      case 3:
        return _buildOpportunitiesTab();
      case 4:
        return _buildProfileTab();
      case 0:
      default:
        return _buildHomeTab();
    }
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // 1. Dashboard Top Bar (Header)
        SliverToBoxAdapter(
          child: DashboardHeader(
            userName: _displayName,
            role: _displayRole,
            onSearchTap: () => setState(() => _navIndex = 1),
            onNotificationTap: () => _showSnackBar('No new notifications'),
            onProfileTap: () => setState(() => _navIndex = 4),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 6)),

        // 2. Journey & Ambition Hero Cards
        SliverToBoxAdapter(
          child: JourneyHeroSection(
            stream: widget.stream.isNotEmpty ? widget.stream : 'Engineering',
            onContinueJourney: () => setState(() => _navIndex = 2),
            onAmbitionTap: () => setState(() => _navIndex = 1),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // 3. Quick Action Shortcuts
        SliverToBoxAdapter(
          child: QuickActionsBar(
            onItemTap: (item) {
              if (item.title.contains('Colleges')) {
                _navigateToCollegeSearch();
              } else {
                _showSnackBar('Selected: ${item.title.replaceAll('\n', ' ')}');
              }
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // 4. Your Preparation Section
        SliverToBoxAdapter(
          child: PreparationSection(
            onViewAll: () => setState(() => _navIndex = 2),
            onItemTap: (item) => _showSnackBar('Opened: ${item.title}'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // 5. Recommended For You Section
        SliverToBoxAdapter(
          child: RecommendedSection(
            onSeeAll: _navigateToCollegeSearch,
            onItemTap: (item) {
              if (item.title.contains('Colleges') ||
                  item.title.contains('IIT') ||
                  item.title.contains('NIRF')) {
                _navigateToCollegeSearch();
              } else {
                _showSnackBar('Opened: ${item.title.replaceAll('\n', ' ')}');
              }
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // 6. Upcoming For You Section
        SliverToBoxAdapter(
          child: UpcomingSection(
            onSeeAll: () => setState(() => _navIndex = 3),
            onItemTap: (item) => _showSnackBar('Event: ${item.title}'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),

        // 7. Explore Career Paths Section
        SliverToBoxAdapter(
          child: CareerPathsSection(
            onSeeAll: () => setState(() => _navIndex = 1),
            onItemTap: (item) => _showSnackBar('Career: ${item.title.replaceAll('\n', ' ')}'),
          ),
        ),

        // Bottom padding to avoid nav bar overlap
        const SliverToBoxAdapter(child: SizedBox(height: 104)),
      ],
    );
  }

  Widget _buildExploreTab() {
    return ExploreScreen(
      location: widget.location.isNotEmpty ? widget.location : 'India',
    );
  }

  Widget _buildPrepareTab() {
    return PrepareScreen(
      onAction: _showSnackBar,
    );
  }

  Widget _buildOpportunitiesTab() {
    return OpportunitiesScreen(
      onAction: _showSnackBar,
    );
  }

  Widget _buildProfileTab() {
    return ProfileScreen(
      user: UserProfileModel(
        name: _displayName,
        email: 'saurabh.singh@example.com',
        selectedClass: widget.selectedClass.isNotEmpty ? widget.selectedClass : 'Class 12th',
        exam: widget.stream.isNotEmpty ? widget.stream : 'JEE (Main + Advanced)',
        preparationProgress: 0.75,
      ),
      onAction: _showSnackBar,
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
}
