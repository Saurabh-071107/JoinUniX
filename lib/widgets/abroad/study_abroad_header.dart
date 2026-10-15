import 'package:flutter/material.dart';

/// Top header for the Study Abroad hub matching Image 2 pixel-for-pixel.
///
/// Responsive and adaptive:
/// - 'GLOBAL EDUCATION —' tracking label
/// - Bold 'Study' + radiant gradient 'Abroad'
/// - Multi-line subtitle
/// - High-resolution global landmarks collage positioned on the top right
/// - Modern pill search bar with circular forward action button
class StudyAbroadHeader extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final ValueChanged<String>? onSearchChanged;

  const StudyAbroadHeader({
    super.key,
    this.onSearchTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final imgWidth = (w * 0.58).clamp(190.0, 290.0);
        final imgHeight = (imgWidth * 0.78).clamp(160.0, 215.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero text + Landmarks Collage
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Landmark collage on the right with soft left/bottom blend
                  Positioned(
                    top: 0,
                    right: -6,
                    width: imgWidth,
                    height: imgHeight,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.transparent, Colors.white, Colors.white],
                          stops: [0.0, 0.32, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.transparent, Colors.white, Colors.white],
                            stops: [0.0, 0.22, 1.0],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          'assets/images/abroad/abroad_header_landmarks.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    ),
                  ),

                  // Left typography column
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Eyebrow tag: GLOBAL EDUCATION —
                        Row(
                          children: [
                            const Text(
                              'GLOBAL EDUCATION',
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
                              height: 2,
                              decoration: BoxDecoration(
                                color: const Color(0xFF94A3B8),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // "Study"
                        const Text(
                          'Study',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -1.2,
                            height: 1.02,
                          ),
                        ),

                        // "Abroad" in radiant blue-to-purple gradient
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds),
                          child: const Text(
                            'Abroad',
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -1.2,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subtitle
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: (w * 0.62).clamp(210.0, 270.0),
                          ),
                          child: const Text(
                            'Countries, courses, applications,\nloans & stays — all in one place.',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
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

            // 2. Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                elevation: 0,
                child: InkWell(
                  onTap: onSearchTap,
                  borderRadius: BorderRadius.circular(28),
                  child: Container(
                    height: 54,
                    padding: const EdgeInsets.fromLTRB(18, 0, 6, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Color(0xFF64748B),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Search countries, universities or courses',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF64748B).withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x404F46E5),
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
