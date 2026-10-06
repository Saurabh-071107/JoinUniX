import 'package:flutter/material.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/goal_card_item.dart';

/// Screen allowing the user to select what they are looking for (Future Goals).
class FutureGoalsScreen extends StatefulWidget {
  final List<String> initialSelected;
  final VoidCallback? onBack;
  final ValueChanged<List<String>>? onContinue;

  const FutureGoalsScreen({
    super.key,
    this.initialSelected = const ['Find a College'],
    this.onBack,
    this.onContinue,
  });

  @override
  State<FutureGoalsScreen> createState() => _FutureGoalsScreenState();
}

class _FutureGoalsScreenState extends State<FutureGoalsScreen> {
  late final Set<String> _selectedGoals;

  static const _goals = [
    (title: 'Find a College', imagePath: 'assets/images/goals/college.png'),
    (title: 'Find a Course', imagePath: 'assets/images/goals/course.png'),
    (title: 'Discover a Career', imagePath: 'assets/images/goals/career.png'),
    (title: 'Prepare for Exams', imagePath: 'assets/images/goals/exams.png'),
    (title: 'Get Scholarships', imagePath: 'assets/images/goals/scholarships.png'),
    (title: 'Find Internships', imagePath: 'assets/images/goals/internships.png'),
    (title: 'Find a Mentor', imagePath: 'assets/images/goals/mentor.png'),
    (title: 'Build Skills', imagePath: 'assets/images/goals/skills.png'),
    (title: "I'm Exploring", imagePath: 'assets/images/goals/exploring.png'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedGoals = Set<String>.from(widget.initialSelected);
  }

  void _toggleGoal(String title) {
    setState(() {
      if (_selectedGoals.contains(title)) {
        _selectedGoals.remove(title);
      } else {
        _selectedGoals.add(title);
      }
    });
  }

  void _handleContinue() {
    if (_selectedGoals.isNotEmpty) {
      widget.onContinue?.call(_selectedGoals.toList());
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
                            bottom: bottomPadding + 88,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: isCompact ? 30 : 40),

                              // Header Title
                              const Text(
                                'What are you looking for?',
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
                                'You can select multiple options',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5D7196),
                                ),
                              ),
                              SizedBox(height: isCompact ? 14 : 22),

                              // 3-Column Grid of 9 Goal Cards
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                mainAxisSpacing: isCompact ? 10 : 12,
                                crossAxisSpacing: isCompact ? 10 : 12,
                                childAspectRatio: isCompact ? 0.94 : 0.90,
                                children: [
                                  for (final item in _goals)
                                    GoalCardItem(
                                      title: item.title,
                                      imagePath: item.imagePath,
                                      isSelected: _selectedGoals.contains(item.title),
                                      onTap: () => _toggleGoal(item.title),
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
                                onPressed: _selectedGoals.isNotEmpty ? _handleContinue : null,
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
