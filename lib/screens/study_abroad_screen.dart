import 'package:flutter/material.dart';
import '../data/features.dart';
import '../widgets/abroad/abroad_feature_card.dart';
import '../widgets/abroad/study_abroad_header.dart';
import 'college_search_screen.dart';

/// Full pixel-perfect Study Abroad screen matching Image 2.
///
/// Responsive for all screen sizes:
/// - Centers content within max width (640px)
/// - 2-column grid on mobile / tablet
/// - Smooth scroll with extra bottom space for bottom nav
class StudyAbroadScreen extends StatefulWidget {
  final VoidCallback? onSearchTap;

  const StudyAbroadScreen({
    super.key,
    this.onSearchTap,
  });

  @override
  State<StudyAbroadScreen> createState() => _StudyAbroadScreenState();
}

class _StudyAbroadScreenState extends State<StudyAbroadScreen> {
  static const List<Feature> _abroadFeatures = [
    Feature.countryGuides,
    Feature.coursesCampus,
    Feature.appTracker,
    Feature.uniFinance,
    Feature.consultancies,
    Feature.uniStay,
    Feature.scholarships,
    Feature.events,
  ];

  void _handleSearchTap() {
    if (widget.onSearchTap != null) {
      widget.onSearchTap!();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const CollegeSearchScreen(location: 'Abroad'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Top Header with Landmarks Collage & Search Bar
                SliverToBoxAdapter(
                  child: StudyAbroadHeader(
                    onSearchTap: _handleSearchTap,
                  ),
                ),

                // 2. Responsive 2-Column Cards Grid matching Image 2
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 116),
                  sliver: SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      mainAxisExtent: 214,
                    ),
                    itemCount: _abroadFeatures.length,
                    itemBuilder: (context, index) {
                      return AbroadFeatureCard(
                        feature: _abroadFeatures[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
