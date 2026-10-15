import 'package:flutter/material.dart';
import '../data/features.dart';
import '../screens/feature_screen.dart';
import 'dashboard/section_header.dart';

/// Tappable tile for one feature. Used in Home row and hub grids.
class FeatureCard extends StatelessWidget {
  final Feature feature;

  const FeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final f = feature;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => openFeature(context, f),
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: f.color.withValues(alpha: 0.18)),
            gradient: LinearGradient(
              colors: [f.color.withValues(alpha: 0.08), Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [BoxShadow(color: f.color.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(color: f.color, borderRadius: BorderRadius.circular(12)),
                    child: Icon(f.icon, size: 18, color: Colors.white),
                  ),
                  const Spacer(),
                  if (f.ai) const AiBadge() else Icon(Icons.arrow_forward_rounded, size: 16, color: f.color),
                ],
              ),
              const Spacer(),
              Text(
                f.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), height: 1.15),
              ),
              const SizedBox(height: 3),
              Text(
                f.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Horizontal "Tools for You" row on Home matching screenshot.
class FeatureRow extends StatelessWidget {
  final List<Feature> features;
  final VoidCallback? onSeeAll;

  const FeatureRow({super.key, required this.features, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    if (features.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        SectionHeader(
          iconData: Icons.work_rounded,
          iconColor: const Color(0xFFDC2626),
          title: 'Tools for You',
          onActionTap: onSeeAll,
        ),
        SizedBox(
          height: 256,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: features.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => SizedBox(
              width: 160,
              child: HomeToolCard(feature: features[i]),
            ),
          ),
        ),
      ],
    );
  }
}

/// Modern 3D tile for "Tools for You" on Home screen matching screenshot.
class HomeToolCard extends StatelessWidget {
  final Feature feature;

  const HomeToolCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    final f = feature;
    // Feature-specific title for Home "Tools for You"
    final displayTitle = switch (f) {
      Feature.consultancies => 'Consultancies',
      Feature.uniStay => 'UniStay & Mentors',
      Feature.scholarships => 'Scholarships',
      Feature.after12th => 'After 12th Hub',
      Feature.sharkTank => 'SharkTank & Stocks',
      _ => f.title,
    };

    // Feature-specific subtitle for Home "Tools for You"
    final displaySubtitle = switch (f) {
      Feature.uniStay => 'Student housing & 1-on-1 alumni mentors',
      Feature.scholarships => 'Merit scholarships across the globe',
      Feature.appTracker => 'Track admissions from submit to visa',
      Feature.uniFinance => 'Education loan EMIs & lender sanctions',
      Feature.consultancies => 'Verified overseas education advisors',
      Feature.after12th => 'Streams, courses & careers explained',
      Feature.sharkTank => 'Pitch startups & trade with virtual cash',
      _ => f.subtitle,
    };

    // 3D box illustration from D:\Downloads\box assets
    final boxAsset = switch (f) {
      Feature.uniStay => 'assets/images/home/box_unistay.png',
      Feature.scholarships => 'assets/images/home/box_scholarships.png',
      Feature.events => 'assets/images/home/box_events.png',
      Feature.sharkTank => 'assets/images/home/box_shark_tank.png',
      Feature.hackathons => 'assets/images/home/box_hackathons.png',
      Feature.countryGuides => 'assets/images/home/box_country_guides.png',
      Feature.appTracker => 'assets/images/home/box_app_tracker.png',
      Feature.coursesCampus => 'assets/images/home/box_campus.png',
      Feature.uniFinance => 'assets/images/home/box_unifinance.png',
      Feature.consultancies => 'assets/images/home/box_consultancies.png',
      Feature.after12th => 'assets/images/home/box_after_12th.png',
      _ => f.imageAsset ?? 'assets/images/home/box_events.png',
    };

    // Solid accent color for top-left container, arrows & glow
    final solidColor = switch (f) {
      Feature.uniStay => const Color(0xFFF97316),
      Feature.scholarships => const Color(0xFF7C3AED),
      Feature.events => const Color(0xFF2563EB),
      Feature.sharkTank => const Color(0xFFEF4444),
      Feature.hackathons => const Color(0xFF7C3AED),
      Feature.countryGuides => const Color(0xFF7C3AED),
      Feature.coursesCampus => const Color(0xFF0F62FE),
      Feature.appTracker => const Color(0xFF00A884),
      Feature.uniFinance => const Color(0xFF00A884),
      Feature.consultancies => const Color(0xFF00A884),
      Feature.after12th => const Color(0xFFF97316),
      Feature.indiaCourses => const Color(0xFF1B2A56),
      _ => f.color,
    };

    // Top-left icon
    final topIcon = switch (f) {
      Feature.uniStay => Icons.apartment_rounded,
      Feature.scholarships => Icons.school_rounded,
      Feature.events => Icons.calendar_month_rounded,
      Feature.sharkTank => Icons.trending_up_rounded,
      Feature.hackathons => Icons.terminal_rounded,
      Feature.countryGuides => Icons.public_rounded,
      Feature.coursesCampus => Icons.auto_stories_rounded,
      Feature.appTracker => Icons.checklist_rounded,
      Feature.uniFinance => Icons.account_balance_wallet_rounded,
      Feature.consultancies => Icons.verified_user_rounded,
      Feature.after12th => Icons.menu_book_rounded,
      _ => f.icon,
    };

    // Top-left squircle background color
    final topIconBgColor = solidColor;

    // Top-left icon color
    final topIconColor = Colors.white;

    // Soft tinted gradient matching screenshot
    final gradientColors = switch (f) {
      Feature.uniStay => const [
          Color(0xFFFFFBEB),
          Color(0xFFFEF3C7),
          Color(0xFFFED7AA),
        ],
      Feature.scholarships => const [
          Color(0xFFFAF5FF),
          Color(0xFFF3E8FF),
          Color(0xFFE9D5FF),
        ],
      Feature.events => const [
          Color(0xFFF0F9FF),
          Color(0xFFE0F2FE),
          Color(0xFFBAE6FD),
        ],
      Feature.sharkTank => const [
          Color(0xFFFFF1F2),
          Color(0xFFFFE4E6),
          Color(0xFFFED7AA),
        ],
      Feature.after12th => const [
          Color(0xFFFFFBEB),
          Color(0xFFFEF3C7),
          Color(0xFFFED7AA),
        ],
      Feature.hackathons => const [
          Color(0xFFFAF5FF),
          Color(0xFFF3E8FF),
          Color(0xFFE9D5FF),
        ],
      Feature.countryGuides => const [
          Color(0xFFFAF5FF),
          Color(0xFFF3E8FF),
          Color(0xFFDDD6FE),
        ],
      Feature.coursesCampus => const [
          Color(0xFFF0F9FF),
          Color(0xFFE0F2FE),
          Color(0xFFBAE6FD),
        ],
      Feature.appTracker || Feature.uniFinance || Feature.consultancies => const [
          Color(0xFFF0FDF9),
          Color(0xFFE6FFFA),
          Color(0xFFCCFBF1),
        ],
      _ => [
          solidColor.withValues(alpha: 0.12),
          solidColor.withValues(alpha: 0.06),
          Colors.white,
        ],
    };

    // Subtle border color
    final borderColor = switch (f) {
      Feature.uniStay => const Color(0xFFFDE68A).withValues(alpha: 0.8),
      Feature.scholarships => const Color(0xFFDDD6FE).withValues(alpha: 0.8),
      Feature.events => const Color(0xFFBAE6FD).withValues(alpha: 0.8),
      Feature.sharkTank => const Color(0xFFFECDD3).withValues(alpha: 0.8),
      Feature.after12th => const Color(0xFFFDE68A).withValues(alpha: 0.8),
      Feature.hackathons => const Color(0xFFDDD6FE).withValues(alpha: 0.8),
      Feature.countryGuides => const Color(0xFFDDD6FE).withValues(alpha: 0.8),
      Feature.coursesCampus => const Color(0xFFBAE6FD).withValues(alpha: 0.8),
      Feature.appTracker || Feature.uniFinance || Feature.consultancies => const Color(0xFF99F6E4).withValues(alpha: 0.85),
      _ => solidColor.withValues(alpha: 0.2),
    };

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: () => openFeature(context, f),
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          height: 256,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: solidColor.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Multiple architectural vertical background lines
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 2.2,
                        margin: const EdgeInsets.only(right: 12),
                        color: solidColor.withValues(alpha: 0.05),
                      ),
                      Container(
                        width: 1.4,
                        margin: const EdgeInsets.only(right: 16),
                        color: solidColor.withValues(alpha: 0.04),
                      ),
                      Container(
                        width: 1.0,
                        margin: const EdgeInsets.only(right: 20),
                        color: solidColor.withValues(alpha: 0.03),
                      ),
                      Container(
                        width: 0.8,
                        margin: const EdgeInsets.only(right: 24),
                        color: solidColor.withValues(alpha: 0.02),
                      ),
                    ],
                  ),
                ),
              ),

              // Soft ambient bottom contour behind 3D artwork
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(21),
                    bottomRight: Radius.circular(21),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          solidColor.withValues(alpha: 0.0),
                          solidColor.withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ),

              // Content layout
              Positioned.fill(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Icon container on left, arrow button on right
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: topIconBgColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Icon(topIcon, size: 20, color: topIconColor),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: solidColor.withValues(alpha: 0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: solidColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Title in Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        displayTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.3,
                          height: 1.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle in Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        displaySubtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF475569),
                          height: 1.25,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Big 3D Artwork below filling bottom space
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(21),
                          bottomRight: Radius.circular(21),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            boxAsset,
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomCenter,
                            errorBuilder: (_, _, _) => const SizedBox(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Discover / Abroad bottom tab: gradient header + responsive grid of features.
class FeatureHubTab extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Feature> features;
  final Widget? footer;

  const FeatureHubTab({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.features,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFF9333EA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Star sparkles in background
                Positioned(
                  top: 0,
                  right: 98,
                  child: Icon(Icons.auto_awesome, color: Colors.white.withValues(alpha: 0.5), size: 16),
                ),
                Positioned(
                  bottom: 2,
                  right: 124,
                  child: Icon(Icons.auto_awesome, color: Colors.white.withValues(alpha: 0.35), size: 12),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 106,
                      height: 94,
                      child: Image.asset(
                        'assets/images/home/banner_lightbulb.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight,
                        errorBuilder: (_, _, _) => Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, size: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 256,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemCount: features.length,
            itemBuilder: (_, i) => HomeToolCard(feature: features[i]),
          ),
        ),
        if (footer != null) SliverToBoxAdapter(child: footer),
        const SliverToBoxAdapter(child: SizedBox(height: 108)),
      ],
    );
  }
}

/// Floating AI button. Hidden when the persona has no AI tools.
class AiFab extends StatefulWidget {
  final Persona persona;

  const AiFab({super.key, required this.persona});

  @override
  State<AiFab> createState() => _AiFabState();
}

class _AiFabState extends State<AiFab> with SingleTickerProviderStateMixin {
  late final _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: AnimatedBuilder(
        animation: _pulse,
        builder: (_, child) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F2CFF).withValues(alpha: 0.25 + 0.2 * _pulse.value),
                blurRadius: 14 + 10 * _pulse.value,
                spreadRadius: 2 * _pulse.value,
              ),
            ],
          ),
          child: child,
        ),
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => openFeature(context, Feature.consulAi),
            child: Ink(
              width: 58,
              height: 58,
              decoration: const BoxDecoration(gradient: aiGradient),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 26),
            ),
          ),
        ),
      ),
    );
  }
}
