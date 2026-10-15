import 'package:flutter/material.dart';
import '../data/dashboard_data.dart';
import '../data/features.dart';
import '../widgets/dashboard/career_paths_section.dart';
import '../widgets/dashboard/dashboard_bottom_nav.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/journey_hero_section.dart';
import '../widgets/dashboard/preparation_section.dart';
import '../widgets/dashboard/quick_actions_bar.dart';
import '../widgets/dashboard/recommended_section.dart';
import '../widgets/dashboard/upcoming_section.dart';
import '../widgets/feature_widgets.dart';
import 'college_search_screen.dart';
import 'explore_screen.dart';
import 'feature_screen.dart';
import 'prepare_screen.dart';
import 'opportunities_screen.dart';
import 'study_abroad_screen.dart';
import '../data/profile_data.dart';
import 'profile_screen.dart';

/// Full-featured, responsive dashboard. Content adapts to the user's [Persona].
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

  Persona get _p => Persona.of(widget.stage);

  String get _displayName =>
      widget.userName.trim().isNotEmpty ? widget.userName.trim() : 'Saurabh';

  String get _displayRole => switch (_p) {
        Persona.school => '${widget.selectedClass} Student'.trim(),
        Persona.pro => widget.stream.isNotEmpty ? widget.stream : 'Working Professional',
        _ => '${widget.stream.isNotEmpty ? widget.stream : widget.stage} Aspirant',
      };

  String get _location => widget.location.isNotEmpty ? widget.location : 'India';

  void _go(int tab) => setState(() => _navIndex = tab);

  /// Opens the first feature available to this persona, else [orElse].
  void _open(List<Feature> candidates, [VoidCallback? orElse]) {
    final f = Feature.firstFor(_p, candidates);
    f != null ? openFeature(context, f) : orElse?.call();
  }

  void _navigateToCollegeSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CollegeSearchScreen(location: _location)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (tabLabel, tabIcon) = _p.tab;
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
      floatingActionButton: AiFab(persona: _p),
      bottomNavigationBar: DashboardBottomNav(
        currentIndex: _navIndex,
        thirdLabel: tabLabel,
        thirdIcon: tabIcon,
        onTap: _go,
      ),
    );
  }

  Widget _buildCurrentBody() => switch (_navIndex) {
        1 => ExploreScreen(location: _location, persona: _p),
        2 => _buildThirdTab(),
        3 => OpportunitiesScreen(persona: _p, onAction: _showSnackBar),
        4 => _buildProfileTab(),
        _ => _buildHomeTab(),
      };

  Widget _buildThirdTab() => switch (_p) {
        Persona.senior || Persona.gap => PrepareScreen(onAction: _showSnackBar),
        Persona.school => FeatureHubTab(
            title: 'Discover Yourself',
            subtitle: 'Explore streams, careers & fun challenges before you choose your path.',
            icon: Icons.lightbulb_rounded,
            features: _p.hub,
            footer: CareerPathsSection(
              onSeeAll: () => _open(const [Feature.after12th]),
              onItemTap: (_) => _open(const [Feature.after12th]),
            ),
          ),
        _ => StudyAbroadScreen(
            onSearchTap: _navigateToCollegeSearch,
          ),
      };

  Widget _buildHomeTab() {
    final p = _p;
    const gap = SliverToBoxAdapter(child: SizedBox(height: 14));
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: DashboardHeader(
            userName: _displayName,
            role: _displayRole,
            onSearchTap: () => _go(1),
            onNotificationTap: () => _showSnackBar('No new notifications'),
            onProfileTap: () => _go(4),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 6)),

        // Journey & Ambition hero
        SliverToBoxAdapter(
          child: JourneyHeroSection(
            stream: widget.stream.isNotEmpty
                ? widget.stream
                : (p == Persona.school ? 'Discovery' : 'Career'),
            onContinueJourney: () => _go(2),
            onAmbitionTap: () => _open(const [Feature.uniQuest, Feature.indiaCourses, Feature.after12th]),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),

        // Quick actions (prep only for JEE track, no internships for school)
        SliverToBoxAdapter(
          child: QuickActionsBar(
            items: quickActions
                .where((q) =>
                    (p.preps || !q.title.contains('Preparation')) &&
                    (p != Persona.school || !q.title.contains('Internships')))
                .toList(),
            onItemTap: (item) => switch (item.title) {
              String t when t.contains('Preparation') => _go(2),
              String t when t.contains('Colleges') => _navigateToCollegeSearch(),
              String t when t.contains('Careers') => _open(const [Feature.after12th, Feature.hackathons], () => _go(1)),
              _ => _open(const [Feature.hackathons], () => _go(3)),
            },
          ),
        ),
        gap,

        // Persona tools
        SliverToBoxAdapter(
          child: FeatureRow(
            features: Feature.forPersona(p),
            onSeeAll: () => _go(p.preps ? 1 : 2),
          ),
        ),
        gap,

        // JEE / NEET track only
        if (p.preps) ...[
          SliverToBoxAdapter(
            child: PreparationSection(
              onViewAll: () => _go(2),
              onItemTap: (item) => item.title.contains('Mock') || item.title.contains('Practice')
                  ? openFeature(context, Feature.examArena)
                  : _go(2),
            ),
          ),
          gap,
          SliverToBoxAdapter(
            child: RecommendedSection(
              onSeeAll: _navigateToCollegeSearch,
              onItemTap: (item) => item.title.contains('Scholarships')
                  ? openFeature(context, Feature.scholarships)
                  : item.title.contains('Career')
                      ? openFeature(context, Feature.after12th)
                      : openFeature(context, Feature.indiaCourses),
            ),
          ),
          gap,
          SliverToBoxAdapter(
            child: UpcomingSection(
              onSeeAll: () => _go(3),
              onItemTap: (item) => openFeature(
                context,
                item.title.contains('JEE') ? Feature.examArena : Feature.indiaCourses,
              ),
            ),
          ),
          gap,
        ],

        SliverToBoxAdapter(
          child: CareerPathsSection(
            onSeeAll: () => _go(1),
            onItemTap: (_) => _open(const [Feature.after12th, Feature.hackathons]),
          ),
        ),

        // Bottom padding to avoid nav bar overlap
        const SliverToBoxAdapter(child: SizedBox(height: 104)),
      ],
    );
  }

  Widget _buildProfileTab() {
    return ProfileScreen(
      user: UserProfileModel(
        name: _displayName,
        email: 'saurabh.singh@example.com',
        selectedClass: widget.selectedClass.isNotEmpty ? widget.selectedClass : widget.stage,
        exam: widget.stream.isNotEmpty ? widget.stream : widget.stage,
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
