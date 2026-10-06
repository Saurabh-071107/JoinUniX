import 'package:flutter/material.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/location_card_item.dart';

/// Screen allowing the user to select their study location preference (India, Abroad, etc.).
class StudyLocationScreen extends StatefulWidget {
  final String initialSelected;
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  const StudyLocationScreen({
    super.key,
    this.initialSelected = 'India',
    this.onBack,
    this.onContinue,
  });

  @override
  State<StudyLocationScreen> createState() => _StudyLocationScreenState();
}

class _StudyLocationScreenState extends State<StudyLocationScreen> {
  late String _selectedLocation;

  static const _locations = [
    (
      title: 'India',
      subtitle: '(Within India)',
      imagePath: 'assets/images/locations/india.png',
    ),
    (
      title: 'Abroad',
      subtitle: '(Global)',
      imagePath: 'assets/images/locations/abroad.png',
    ),
    (
      title: 'India + Abroad',
      subtitle: '(Both)',
      imagePath: 'assets/images/locations/india_and_abroad.png',
    ),
    (
      title: "I'm Not Sure Yet",
      subtitle: null,
      imagePath: 'assets/images/common/question_mark.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.initialSelected;
  }

  void _handleContinue() {
    if (_selectedLocation.isNotEmpty) {
      widget.onContinue?.call(_selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final bottomPadding = media.padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          final canvasW = totalW > 540 ? 460.0 : totalW;
          final isCompact = totalH < 720;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Rich atmospheric background with ambient glow & floating sparks
              const AtmosphericBackground(),

              // Centered Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    children: [
                      // --- Scrollable Content: Title, Subtitle, 2x2 Grid, Info Banner ---
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + 14,
                            left: 20,
                            right: 20,
                            bottom: bottomPadding + 96,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),

                              // Header Title
                              const Text(
                                'Where do you want to study?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B2A56),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Header Subtitle
                              const Text(
                                'Select your preference',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5D7196),
                                ),
                              ),
                              SizedBox(height: isCompact ? 18 : 26),

                              // 2x2 Grid of 4 Location Cards
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: isCompact ? 1.02 : 1.08,
                                children: [
                                  for (final item in _locations)
                                    LocationCardItem(
                                      title: item.title,
                                      subtitle: item.subtitle,
                                      imagePath: item.imagePath,
                                      isSelected: _selectedLocation == item.title,
                                      onTap: () {
                                        setState(() {
                                          _selectedLocation = item.title;
                                        });
                                      },
                                    ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Profile Setting Info Banner
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: const Color(0xFFD6E4FB),
                                    width: 1.2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1E2A54).withValues(alpha: 0.04),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF4A72E8).withValues(alpha: 0.12),
                                      ),
                                      child: const Icon(
                                        Icons.shield_outlined,
                                        size: 20,
                                        color: Color(0xFF4A72E8),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'You can always change this later in your profile settings.',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4D6084),
                                          height: 1.35,
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

                      // --- Top-Left Back Button (On top in Z-index) ---
                      Positioned(
                        top: topPadding + 8,
                        left: 14,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.onBack ?? () => Navigator.maybePop(context),
                            borderRadius: BorderRadius.circular(21),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(0xFFDCE4F2),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1E2A54).withValues(alpha: 0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
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

                      // --- Floating Bottom Continue Button ---
                      Positioned(
                        bottom: (bottomPadding + 16).clamp(16.0, 40.0),
                        left: 20,
                        right: 20,
                        child: Center(
                          child: SizedBox(
                            width: (canvasW * 0.90).clamp(280.0, 390.0),
                            height: 60,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6F2CFF),
                                    Color(0xFF5A33EF),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF6F2CFF).withValues(alpha: 0.38),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _selectedLocation.isNotEmpty ? _handleContinue : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  disabledBackgroundColor: Colors.transparent,
                                  disabledForegroundColor: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Continue',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
