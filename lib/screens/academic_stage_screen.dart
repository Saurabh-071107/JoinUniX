import 'package:flutter/material.dart';
import '../widgets/stage_card_item.dart';
import '../widgets/atmospheric_background.dart';

/// Screen allowing the user to select their current academic stage.
class AcademicStageScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onStageSelected;

  const AcademicStageScreen({
    super.key,
    this.onBack,
    this.onStageSelected,
  });

  static const _stages = [
    (
      title: 'School (Class 8 - 10)',
      subtitle: 'Explore your interests',
      imagePath: 'assets/images/stages/school_bag.png',
      gradientColors: [Color(0xFFF2FCE8), Color(0xFFFDFEF6)],
      borderColor: Color(0xFFE1F3D5),
    ),
    (
      title: 'Class 11 - 12',
      subtitle: 'Prepare for your next step',
      imagePath: 'assets/images/stages/class11_12_bag.png',
      gradientColors: [Color(0xFFEDF5FE), Color(0xFFF9FBFF)],
      borderColor: Color(0xFFD6E7FC),
    ),
    (
      title: 'Undergraduate',
      subtitle: 'Engineering, Medical, Commerce, Arts and more',
      imagePath: 'assets/images/stages/undergraduate.png',
      gradientColors: [Color(0xFFEFF1FE), Color(0xFFF9FAFF)],
      borderColor: Color(0xFFDCE1FC),
    ),
    (
      title: 'Postgraduate',
      subtitle: 'Masters, PhD, Research',
      imagePath: 'assets/images/stages/postgraduate.png',
      gradientColors: [Color(0xFFFBEFFC), Color(0xFFFCF6FD)],
      borderColor: Color(0xFFF4DAF7),
    ),
    (
      title: 'Working Professional',
      subtitle: 'Upskill, Switch or Grow',
      imagePath: 'assets/images/stages/professional.png',
      gradientColors: [Color(0xFFFEF4ED), Color(0xFFFFF9F5)],
      borderColor: Color(0xFFFCDFCF),
    ),
    (
      title: 'Gap Year / Other',
      subtitle: 'Exploring Opportunities',
      imagePath: 'assets/images/stages/gap_year.png',
      gradientColors: [Color(0xFFEAFBF8), Color(0xFFF7FEFD)],
      borderColor: Color(0xFFCEF5EF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final bottomPadding = media.padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          final canvasW = totalW > 540 ? 460.0 : totalW;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Rich Atmospheric Background
              const AtmosphericBackground(),

              // 2. Centered Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    children: [
                      // --- Back Button ---
                      Positioned(
                        top: topPadding + 6,
                        left: 16,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onBack ?? () => Navigator.maybePop(context),
                            borderRadius: BorderRadius.circular(22),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFE2E7F2),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 17,
                                color: Color(0xFF1E2A54),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // --- Scrollable Content: Header + Stage Cards ---
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + 8,
                            left: 20,
                            right: 20,
                            bottom: bottomPadding + 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Top space so header is visually centered below back button
                              const SizedBox(height: 42),

                              // Header Title (Enlarged)
                              const Text(
                                'Where are you right now?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B2A56),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Header Subtitle (Enlarged)
                              const Text(
                                'Select your current academic stage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5D7196),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Stage Cards List
                              for (final stage in _stages)
                                StageCardItem(
                                  title: stage.title,
                                  subtitle: stage.subtitle,
                                  imagePath: stage.imagePath,
                                  gradientColors: stage.gradientColors,
                                  borderColor: stage.borderColor,
                                  onTap: () => onStageSelected?.call(stage.title),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
