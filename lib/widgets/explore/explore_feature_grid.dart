import 'package:flutter/material.dart';
import '../../data/explore_data.dart';

class ExploreFeatureGrid extends StatelessWidget {
  final ValueChanged<ExploreFeatureCardItem>? onCardTap;

  const ExploreFeatureGrid({
    super.key,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive cross axis count: 2 for mobile, up to 3 for wide tablet
          final crossAxisCount = constraints.maxWidth > 580 ? 3 : 2;
          final aspectRatio = constraints.maxWidth > 580
              ? 1.25
              : (constraints.maxWidth < 360 ? 1.10 : 1.15);

          // Chunk items into rows based on column count
          final rows = <List<ExploreFeatureCardItem>>[];
          for (var i = 0; i < exploreFeatureCards.length; i += crossAxisCount) {
            final end = (i + crossAxisCount > exploreFeatureCards.length)
                ? exploreFeatureCards.length
                : i + crossAxisCount;
            rows.add(exploreFeatureCards.sublist(i, end));
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var r = 0; r < rows.length; r++) ...[
                if (r > 0) const SizedBox(height: 12),
                Row(
                  children: [
                    for (var c = 0; c < rows[r].length; c++) ...[
                      if (c > 0) const SizedBox(width: 12),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: aspectRatio,
                          child: _buildFeatureCard(rows[r][c]),
                        ),
                      ),
                    ],
                    for (var pad = 0; pad < crossAxisCount - rows[r].length; pad++) ...[
                      const SizedBox(width: 12),
                      const Expanded(child: SizedBox()),
                    ],
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeatureCard(ExploreFeatureCardItem item) {
    // Tailored dimension adjustments to fill the card beautifully and eliminate awkward empty gaps
    final isCareers = item.title.contains('Careers');
    final isColleges = item.title.contains('Colleges');
    final isAbroad = item.title.contains('Abroad');
    final isCourses = item.title.contains('Courses') || item.title.contains('Degrees');
    final isBriefcase = item.title.contains('Jobs') || item.title.contains('Internships');
    final isCompetitions = item.title.contains('Competitions') || item.title.contains('Events');

    final double imgWidth;
    final double imgHeight;
    final double imgRight;
    final double imgBottom;

    if (isCareers) {
      imgWidth = 120.0;
      imgHeight = 135.0;
      imgRight = -2.0;
      imgBottom = 0.0;
    } else if (isColleges) {
      imgWidth = 124.0;
      imgHeight = 108.0;
      imgRight = -2.0;
      imgBottom = 0.0;
    } else if (isAbroad) {
      imgWidth = 122.0;
      imgHeight = 114.0;
      imgRight = -4.0;
      imgBottom = 0.0;
    } else if (isCourses) {
      imgWidth = 124.0;
      imgHeight = 108.0;
      imgRight = -2.0;
      imgBottom = 0.0;
    } else if (isBriefcase) {
      imgWidth = 110.0;
      imgHeight = 100.0;
      imgRight = 2.0;
      imgBottom = 2.0;
    } else if (isCompetitions) {
      imgWidth = 118.0;
      imgHeight = 120.0;
      imgRight = 0.0;
      imgBottom = 0.0;
    } else {
      imgWidth = 116.0;
      imgHeight = 112.0;
      imgRight = 0.0;
      imgBottom = 0.0;
    }

    return GestureDetector(
      onTap: () => onCardTap?.call(item),
      child: Container(
        decoration: BoxDecoration(
          color: item.bgColor,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: item.buttonColor.withValues(alpha: 0.12),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: item.buttonColor.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Top Left Text (Title + Subtitle)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 8, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      color: item.accentColor,
                      height: 1.15,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: item.subColor,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Right 3D Illustration - snugly fitted to remove empty gap
            Positioned(
              right: imgRight,
              bottom: imgBottom,
              width: imgWidth,
              height: imgHeight,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
                errorBuilder: (_, _, _) => Icon(
                  Icons.auto_awesome_rounded,
                  size: 42,
                  color: item.buttonColor.withValues(alpha: 0.4),
                ),
              ),
            ),

            // Bottom Left Circular Arrow Button
            Positioned(
              left: 14,
              bottom: 12,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: item.buttonColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: item.buttonColor.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
