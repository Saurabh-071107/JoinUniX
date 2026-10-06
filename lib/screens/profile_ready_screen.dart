import 'package:flutter/material.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/profile_summary_item.dart';

/// Screen celebrating the completion of onboarding ("You're All Set!").
class ProfileReadyScreen extends StatefulWidget {
  final String selectedClass;
  final String selectedStream;
  final List<String> selectedInterests;
  final List<String> selectedGoals;
  final String selectedLocation;
  final VoidCallback? onStartExploring;

  const ProfileReadyScreen({
    super.key,
    this.selectedClass = 'Class 10',
    this.selectedStream = 'Science (PCM)',
    this.selectedInterests = const ['Technology', 'Business'],
    this.selectedGoals = const ['Find a College', 'Prepare for Exams'],
    this.selectedLocation = 'India',
    this.onStartExploring,
  });

  @override
  State<ProfileReadyScreen> createState() => _ProfileReadyScreenState();
}

class _ProfileReadyScreenState extends State<ProfileReadyScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _studentScaleAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _cardFadeAnimation;
  late final Animation<Offset> _cardSlideAnimation;
  late final Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _studentScaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.65, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _cardFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOut),
      ),
    );

    _cardSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              // Atmospheric glowing background
              const AtmosphericBackground(),

              // Centered Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    children: [
                      // Confetti Celebration Overlay
                      Positioned(
                        top: topPadding - 10,
                        left: 0,
                        right: 0,
                        height: 250,
                        child: IgnorePointer(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Image.asset(
                              'assets/images/profile/confetti.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),

                      // Scrollable Content
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + 10,
                            left: 20,
                            right: 20,
                            bottom: bottomPadding + 96,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // 3D Student Character with Bounce Entrance Animation
                              ScaleTransition(
                                scale: _studentScaleAnimation,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: SizedBox(
                                    height: isCompact ? 210 : 255,
                                    child: Image.asset(
                                      'assets/images/profile/thumbs_up_student.png',
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                        Icons.person_rounded,
                                        size: 130,
                                        color: Color(0xFF6F2CFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Header Title & Subtitles with Slide + Fade Transition
                              SlideTransition(
                                position: _slideAnimation,
                                child: FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Column(
                                    children: [
                                      // Header Title
                                      const Text(
                                        "You're All Set!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF1B2A56),
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      // Subtitle with Party Popper Emoji
                                      const Text(
                                        'Your JoinUNiX profile is ready 🎉',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF24345B),
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                      const SizedBox(height: 3),

                                      // Secondary Subtitle
                                      const Text(
                                        'Get ready to explore amazing opportunities!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF5D7196),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: isCompact ? 18 : 24),

                              // Summary Card with Slide + Fade Transition
                              SlideTransition(
                                position: _cardSlideAnimation,
                                child: FadeTransition(
                                  opacity: _cardFadeAnimation,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      border: Border.all(
                                        color: const Color(0xFFDCE6F5),
                                        width: 1.3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF1E2A54)
                                              .withValues(alpha: 0.05),
                                          blurRadius: 16,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Class
                                        ProfileSummaryItem.icon(
                                          icon: Icons.school_rounded,
                                          label: widget.selectedClass.isNotEmpty
                                              ? widget.selectedClass
                                              : 'Class 10',
                                        ),
                                        const Divider(
                                          color: Color(0xFFEFF3FA),
                                          height: 1,
                                        ),

                                        // Stream
                                        ProfileSummaryItem.icon(
                                          icon: Icons.biotech_rounded,
                                          label: widget.selectedStream.isNotEmpty
                                              ? widget.selectedStream
                                              : 'Science (PCM)',
                                        ),
                                        const Divider(
                                          color: Color(0xFFEFF3FA),
                                          height: 1,
                                        ),

                                        // Career Interests
                                        ProfileSummaryItem.icon(
                                          icon: Icons.computer_rounded,
                                          label: widget.selectedInterests.isNotEmpty
                                              ? widget.selectedInterests.join(', ')
                                              : 'Technology, Business',
                                        ),
                                        const Divider(
                                          color: Color(0xFFEFF3FA),
                                          height: 1,
                                        ),

                                        // Future Goals
                                        ProfileSummaryItem.icon(
                                          icon: Icons.track_changes_rounded,
                                          label: widget.selectedGoals.isNotEmpty
                                              ? widget.selectedGoals.join(', ')
                                              : 'Find a College, Prepare for Exams',
                                        ),
                                        const Divider(
                                          color: Color(0xFFEFF3FA),
                                          height: 1,
                                        ),

                                        // Location Preference
                                        ProfileSummaryItem(
                                          leading: SizedBox(
                                            width: 38,
                                            height: 38,
                                            child: Image.asset(
                                              'assets/images/locations/india.png',
                                              fit: BoxFit.contain,
                                              errorBuilder:
                                                  (context, error, stackTrace) =>
                                                      Container(
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFF1EBFF),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.place_rounded,
                                                  size: 20,
                                                  color: Color(0xFF6F2CFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          label: widget.selectedLocation.isNotEmpty
                                              ? widget.selectedLocation
                                              : 'India',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Floating Bottom CTA Button
                      Positioned(
                        bottom: (bottomPadding + 16).clamp(16.0, 40.0),
                        left: 20,
                        right: 20,
                        child: Center(
                          child: ScaleTransition(
                            scale: _buttonScaleAnimation,
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
                                      color: const Color(0xFF6F2CFF)
                                          .withValues(alpha: 0.38),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: widget.onStartExploring,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Start Exploring',
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
