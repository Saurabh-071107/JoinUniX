import 'package:flutter/material.dart';
import '../../data/features.dart';
import '../../screens/feature_screen.dart';

/// Pixel-perfect feature card matching the Study Abroad visual design in Image 2.
///
/// Features:
/// - Rich 3-stop soft themed pastel gradient background
/// - Multi-layered vertical and ambient shades (broad gradient band, inner contour, shimmer line, corner glow)
/// - Top-left solid rounded badge icon with ambient aura
/// - Bold title & readable subtitle
/// - Bottom-left circular white arrow button
/// - Extra-large 3D illustration asset in the bottom-right corner (~126-154px)
/// - Fully responsive across all devices
class AbroadFeatureCard extends StatelessWidget {
  final Feature feature;
  final VoidCallback? onTap;

  const AbroadFeatureCard({
    super.key,
    required this.feature,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final asset = feature.imageAsset;
    final badgeColor = feature.badgeColor;
    final badgeIcon = feature.badgeIcon;
    final softGradient = feature.softGradient;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardW = constraints.maxWidth;
        // Increased image size (approx 25-30% larger for bold visual impact)
        final assetSize = (cardW * 0.72).clamp(126.0, 154.0);

        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          child: InkWell(
            onTap: onTap ?? () => openFeature(context, feature),
            borderRadius: BorderRadius.circular(22),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: badgeColor.withValues(alpha: 0.25),
                  width: 1.2,
                ),
                gradient: LinearGradient(
                  colors: softGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: badgeColor.withValues(alpha: 0.10),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Stack(
                  children: [
                    // 3D Illustration positioned in the bottom-right
                    if (asset != null)
                      Positioned(
                        right: -4,
                        bottom: -4,
                        width: assetSize,
                        height: assetSize,
                        child: Image.asset(
                          asset,
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomRight,
                        ),
                      ),

                    // Foreground Content: Badge, Title, Subtitle, and Bottom-Left Arrow
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top-left icon badge
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: badgeColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: badgeColor.withValues(alpha: 0.28),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(badgeIcon, size: 21, color: Colors.white),
                          ),
                          const SizedBox(height: 10),

                          // Title
                          Text(
                            feature.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                              height: 1.18,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Subtitle (flows nicely above/beside bottom-right asset)
                          Padding(
                            padding: const EdgeInsets.only(right: 28),
                            child: Text(
                              feature.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF334155),
                                height: 1.25,
                              ),
                            ),
                          ),
                          const Spacer(),

                          // Bottom-left circular white arrow button
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: badgeColor.withValues(alpha: 0.16),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_forward_rounded,
                              size: 15,
                              color: badgeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
