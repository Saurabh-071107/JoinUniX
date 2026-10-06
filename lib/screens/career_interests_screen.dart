import 'package:flutter/material.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/interest_card_item.dart';

/// Screen allowing the user to select up to 5 career interests (Technology, Medicine, etc.).
class CareerInterestsScreen extends StatefulWidget {
  final List<String> initialSelected;
  final VoidCallback? onBack;
  final ValueChanged<List<String>>? onContinue;

  const CareerInterestsScreen({
    super.key,
    this.initialSelected = const ['Technology'],
    this.onBack,
    this.onContinue,
  });

  @override
  State<CareerInterestsScreen> createState() => _CareerInterestsScreenState();
}

class _CareerInterestsScreenState extends State<CareerInterestsScreen> {
  late final Set<String> _selectedInterests;

  static const _interests = [
    (title: 'Technology', imagePath: 'assets/images/interests/technology.png'),
    (title: 'Medicine', imagePath: 'assets/images/interests/medicine.png'),
    (title: 'Business', imagePath: 'assets/images/interests/business.png'),
    (title: 'Design', imagePath: 'assets/images/goals/career.png'),
    (title: 'Law', imagePath: 'assets/images/interests/law.png'),
    (title: 'Aviation', imagePath: 'assets/images/interests/aviation.png'),
    (title: 'Media', imagePath: 'assets/images/interests/media.png'),
    (title: 'Environment', imagePath: 'assets/images/interests/environment.png'),
    (title: 'Gaming', imagePath: 'assets/images/interests/gaming.png'),
    (title: 'Research', imagePath: 'assets/images/interests/research.png'),
    (title: 'Entrepreneurship', imagePath: 'assets/images/interests/entrepreneurship.png'),
    (title: 'Not Sure', imagePath: 'assets/images/common/question_mark.png'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedInterests = Set<String>.from(widget.initialSelected);
  }

  void _toggleInterest(String title) {
    setState(() {
      if (_selectedInterests.contains(title)) {
        _selectedInterests.remove(title);
      } else {
        if (_selectedInterests.length < 5) {
          _selectedInterests.add(title);
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You can select up to 5 interests'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });
  }

  void _handleContinue() {
    if (_selectedInterests.isNotEmpty) {
      widget.onContinue?.call(_selectedInterests.toList());
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
                      // --- Scrollable Content: Title, Subtitle, 3-Column Grid ---
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + 14,
                            left: 18,
                            right: 18,
                            bottom: bottomPadding + 96,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),

                              // Header Title
                              const Text(
                                'What are you interested in?',
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
                                'Select up to 5 interests',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5D7196),
                                ),
                              ),
                              SizedBox(height: isCompact ? 18 : 24),

                              // 3-Column Grid of 12 Career Cards
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: isCompact ? 0.86 : 0.88,
                                children: [
                                  for (final item in _interests)
                                    InterestCardItem(
                                      title: item.title,
                                      imagePath: item.imagePath,
                                      isSelected: _selectedInterests.contains(item.title),
                                      onTap: () => _toggleInterest(item.title),
                                    ),
                                ],
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
                                onPressed: _selectedInterests.isNotEmpty ? _handleContinue : null,
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
