import 'package:flutter/material.dart';

/// Intro / Onboarding screen arranged with Stack, featuring JoinUNiX branding,
/// animated rolling number stats on top of the students, and the "Get Started" button.
class IntroScreen extends StatefulWidget {
  final VoidCallback? onGetStarted;
  final VoidCallback? onBack;

  const IntroScreen({
    super.key,
    this.onGetStarted,
    this.onBack,
  });

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _countAnimation;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _headerSlide;
  late final Animation<Offset> _buttonSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Fast, punchy count-up curve: rolls quickly then firmly settles
    _countAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    ));

    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 0.60, curve: Curves.easeOutCubic),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static String _formatNumber(int val) {
    final str = val.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final bottomPadding = media.padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          // Responsive centered canvas for tablet/desktop
          final canvasW = totalW > 540 ? 460.0 : totalW;

          // Responsive sizing & offsets
          final isCompact = totalH < 740;
          final headerTop = (topPadding + (isCompact ? 6.0 : 16.0)).clamp(22.0, 56.0);
          final logoWidth = (canvasW * 0.6).clamp(150.0, 205.0);
          // Shifted "Get Started" bar a little up from the bottom edge
          final buttonBottom = (bottomPadding + 36.0).clamp(32.0, 56.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Sky Gradient Fallback
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF20A0FF),
                        Color(0xFF8AD2FF),
                        Color(0xFFF0E4FF),
                        Colors.white,
                      ],
                      stops: [0.0, 0.35, 0.75, 1.0],
                    ),
                  ),
                ),
              ),

              // 2. Full Background Illustration (sky, petals, students in clouds)
              Positioned.fill(
                child: Image.asset(
                  'assets/images/intro/welcome_illustration.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),

              // 3. Centered Content Canvas
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // --- Back Button ---
                      Positioned(
                        top: topPadding + 6,
                        left: 14,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: widget.onBack ?? () => Navigator.maybePop(context),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.82),
                                border: Border.all(
                                  color: const Color(0xFFD8E3F5),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 16,
                                color: Color(0xFF1E2A54),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // --- Header: Title, Logo, Description & Animated Numbers on top of students ---
                      Positioned(
                        top: headerTop,
                        left: 20,
                        right: 20,
                        child: SlideTransition(
                          position: _headerSlide,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Welcome to',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E2A54),
                                  ),
                                ),
                                // Reused JoinUniX Logo
                                Image.asset(
                                  'assets/images/common/logo.png',
                                  width: logoWidth,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Your Future\nStarts Here!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: isCompact ? 25 : 30,
                                    fontWeight: FontWeight.w800,
                                    height: 1.18,
                                    color: const Color(0xFF2A3A75),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(
                                    'Discover careers, colleges, courses ,\n exams, scholarships and amazing\n opportunities — all in one place.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: isCompact ? 13 : 14,
                                      height: 1.35,
                                      color: const Color(0xFF5D6F92),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: isCompact ? 14 : 20),

                                // Fast Animated Numbers Countdown / Count-up (Little Big)
                                AnimatedBuilder(
                                  animation: _countAnimation,
                                  builder: (context, _) {
                                    final progress = _countAnimation.value;
                                    final val1 = (progress * 10).round();
                                    final val2 = (progress * 10000).round();
                                    final val3 = (progress * 50).round();

                                    return FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _buildStatItem('${val1}M+', 'Students'),
                                          const SizedBox(width: 10),
                                          _buildStatDivider(),
                                          const SizedBox(width: 10),
                                          _buildStatItem('${_formatNumber(val2)}+', 'Universities'),
                                          const SizedBox(width: 10),
                                          _buildStatDivider(),
                                          const SizedBox(width: 10),
                                          _buildStatItem('$val3+', 'Countries'),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // --- Subtle Cloud Floor Fade behind bottom button ---
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: (buttonBottom + 65).clamp(70.0, 130.0),
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.45, 0.85, 1.0],
                                colors: [
                                  Colors.white.withValues(alpha: 0.0),
                                  Colors.white.withValues(alpha: 0.28),
                                  Colors.white.withValues(alpha: 0.82),
                                  Colors.white,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // --- Action CTA: "Get Started →" shifted a little up ---
                      Positioned(
                        bottom: buttonBottom,
                        left: 28,
                        right: 28,
                        child: SlideTransition(
                          position: _buttonSlide,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Center(
                              child: SizedBox(
                                width: (canvasW * 0.78).clamp(240.0, 320.0),
                                height: 60,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6F2CFF),
                                        Color(0xFF5A33EF),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6F2CFF).withValues(alpha: 0.38),
                                        blurRadius: 16,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: widget.onGetStarted,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(26),
                                      ),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Get Started',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 25,
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

  static Widget _buildStatItem(String number, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 29.0, // A little big & prominent
            fontWeight: FontWeight.w800,
            color: Color(0xFF1B2A56),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF677797),
          ),
        ),
      ],
    );
  }

  static Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 26,
      color: const Color(0xFFE2E7F2),
    );
  }
}
