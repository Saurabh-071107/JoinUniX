import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

/// Pixel-perfect Country Guides workflow matching Image 1.
///
/// Features:
/// - World map background watermark in the header
/// - Eyebrow label `COUNTRY BLUEPRINTS —`
/// - Multi-line title with radiant blue gradient on `Destination`
/// - Country selector chips with clean flags and dark navy selected state
/// - Panoramic landmark hero banner with Statue of Liberty / Big Ben / Germany landmarks
/// - Frosted glass highlight card inside the hero
/// - `Official Immigration & Cost Blueprint —` section header with divider line
/// - 5 themed blueprint cards with soft pastel gradients, multi-layered vertical background accents, icons, and chevrons
/// - Dark navy checklist download action button
class CountryGuidesWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const CountryGuidesWorkflow({super.key, this.onCompleted});

  @override
  State<CountryGuidesWorkflow> createState() => _CountryGuidesWorkflowState();
}

class _CountryGuidesWorkflowState extends State<CountryGuidesWorkflow> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final guide = sampleCountryGuides[_selectedIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Typography
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eyebrow: COUNTRY BLUEPRINTS —
                Row(
                  children: [
                    const Text(
                      'COUNTRY BLUEPRINTS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 28,
                      height: 1.5,
                      decoration: BoxDecoration(
                        color: const Color(0xFF94A3B8),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Title: Study Abroad Destination Guides
                const Text(
                  'Study Abroad',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.9,
                    height: 1.05,
                  ),
                ),
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Destination',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.9,
                          height: 1.05,
                        ),
                      ),
                    ),
                    const Text(
                      ' Guides',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.9,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Explore post-study work permits (PSWV), tuition benchmarks, visa processing & PR pathways',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
        const SizedBox(height: 16),

        // 2. Country Selector Pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(sampleCountryGuides.length, (idx) {
              final c = sampleCountryGuides[idx];
              final isSelected = _selectedIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() => _selectedIndex = idx),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1B2A56) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1B2A56) : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF1B2A56).withValues(alpha: 0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: const Color(0xFF64748B).withValues(alpha: 0.08),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.flag, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(
                            c.country,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),

        // 3. Hero Country Landmark Panoramic Card (Soft Blue Background)
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFDBEAFE), // Soft pastel sky blue
                Color(0xFFEFF6FF), // Soft airy mist blue
                Color(0xFFE0F2FE), // Soft ice blue
              ],
            ),
            border: Border.all(
              color: const Color(0xFF93C5FD).withValues(alpha: 0.70),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Panoramic Landmark Photography
                Image.asset(
                  guide.landmarkAsset,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),

                // Soft pastel blue gradient overlay for clear text readability
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFFDBEAFE).withValues(alpha: 0.95),
                        const Color(0xFFEFF6FF).withValues(alpha: 0.68),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.58, 1.0],
                    ),
                  ),
                ),

                // Card Foreground Details
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Flag & Country Title
                      Row(
                        children: [
                          Text(guide.flag, style: const TextStyle(fontSize: 30)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  guide.country,
                                  style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                Text(
                                  '${guide.topUniversitiesCount}+ Listed Global Universities',
                                  style: const TextStyle(
                                    color: Color(0xFF475569),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Visa Category Pill with soft blue styling
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                          ),
                        ),
                        child: Text(
                          guide.visaCategory,
                          style: const TextStyle(
                            color: Color(0xFF1D4ED8),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Frosted Soft White/Blue Highlight Card (Zero Black Shadow)
                      Container(
                        constraints: const BoxConstraints(maxWidth: 245),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF93C5FD).withValues(alpha: 0.60),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withValues(alpha: 0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          guide.highlight,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
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

        const SizedBox(height: 20),

        // 4. Official Immigration & Cost Blueprint Section Header
        Row(
          children: [
            const Text(
              'Official Immigration & Cost Blueprint',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 1.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Key data metrics verified against official embassy portals',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 14),

        // 5. The 5 Blueprint Cards (Single Uniform Light Shade per Box)
        _buildBlueprintCard(
          icon: Icons.assignment_rounded,
          accentColor: const Color(0xFF059669),
          bgColor: const Color(0xFFF0FDF4),
          label: 'POST-STUDY WORK VISA (PSWV)',
          value: guide.pswvYears,
          note: 'Allows full-time work authorization upon graduation without immediate company sponsorship.',
        ),
        const SizedBox(height: 10),

        _buildBlueprintCard(
          icon: Icons.school_rounded,
          accentColor: const Color(0xFF2563EB),
          bgColor: const Color(0xFFEFF6FF),
          label: 'ESTIMATED ANNUAL TUITION FEES',
          value: guide.avgTuition,
          note: 'Tuition rates depend on public vs private status and program discipline.',
        ),
        const SizedBox(height: 10),

        _buildBlueprintCard(
          icon: Icons.home_rounded,
          accentColor: const Color(0xFFD97706),
          bgColor: const Color(0xFFFFFBEB),
          label: 'ESTIMATED LIVING EXPENSES',
          value: guide.livingCost,
          note: 'Covers verified student dorms, meals, local transit and health insurance.',
        ),
        const SizedBox(height: 10),

        _buildBlueprintCard(
          icon: Icons.hourglass_top_rounded,
          accentColor: const Color(0xFFE11D48),
          bgColor: const Color(0xFFFFF1F2),
          label: 'VISA PROCESSING TIMELINE',
          value: guide.visaProcessing,
          note: 'Average turnaround from biometric submission to passport stamping.',
        ),
        const SizedBox(height: 10),

        _buildBlueprintCard(
          icon: Icons.ballot_rounded,
          accentColor: const Color(0xFF7C3AED),
          bgColor: const Color(0xFFFAF5FF),
          label: 'PERMANENT RESIDENCY (PR) PATHWAY',
          value: guide.prPathway,
          note: 'Points-based or employer-sponsored path to long-term residency.',
        ),
        const SizedBox(height: 18),

        // 6. Download Checklist Action Button (Vibrant Royal Blue Shade)
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading official ${guide.country} Visa Checklist PDF...'),
                  backgroundColor: const Color(0xFF0F62FE),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(14),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F62FE), Color(0xFF2563EB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F62FE).withValues(alpha: 0.32),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description_rounded,
                    color: Colors.white,
                    size: 19,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Download ${guide.country} Complete Visa Checklist (PDF)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Reusable blueprint card with a single light uniform pastel shade.
  Widget _buildBlueprintCard({
    required IconData icon,
    required Color accentColor,
    required Color bgColor,
    required String label,
    required String value,
    required String note,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.18),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Vertical accent bar on the left
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 3.5,
              child: Container(
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                ),
              ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Badge
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: accentColor, size: 22),
                  ),
                  const SizedBox(width: 14),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          note,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF475569),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Trailing Chevron
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
