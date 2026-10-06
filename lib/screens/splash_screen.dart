import 'package:flutter/material.dart';
import '../widgets/loading_bar.dart';

/// Splash screen arranged with Stack, displaying JoinUNiX branding,
/// complete background illustration, tagline, and an animated loading bar.
class SplashScreen extends StatefulWidget {
  final VoidCallback? onLoaded;
  final Duration duration;

  const SplashScreen({
    super.key,
    this.onLoaded,
    this.duration = const Duration(milliseconds: 2600),
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnimation;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _bottomFade;
  late final Animation<Offset> _bottomSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _headerFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.38, curve: Curves.easeOutCubic),
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(_headerFade);

    _bottomFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.45, curve: Curves.easeOutCubic),
    );

    _bottomSlide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(_bottomFade);

    _progressAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.20, 0.95, curve: Curves.easeInOutCubic),
    );

    _controller.forward().then((_) {
      if (mounted) {
        widget.onLoaded?.call();
      }
    });
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
      backgroundColor: const Color(0xFFE9F3FE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          // Responsive canvas width (constrain on tablet/desktop for optimal composition)
          final canvasW = totalW > 540 ? 460.0 : totalW;

          // Proportional sizing
          final logoWidth = (canvasW * 0.60).clamp(190.0, 290.0);
          final capWidth = logoWidth * 0.46;
          final capHeight = capWidth * (1024.0 / 1536.0);
          final taglineWidth = (canvasW * 0.64).clamp(210.0, 310.0);
          final loadingBarWidth = (canvasW * 0.54).clamp(170.0, 240.0);

          // Responsive vertical rhythm
          final headerTop = topPadding + (capHeight * 1.1) + (totalH * 0.015).clamp(8.0, 22.0);
          final bottomSectionOffset = bottomPadding + (totalH * 0.035).clamp(24.0, 48.0);
          final loadingBarGap = (totalH * 0.018).clamp(14.0, 22.0);

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
                        Color(0xFF2E93EE),
                        Color(0xFF88C9FB),
                        Color(0xFFE8F2FD),
                        Colors.white,
                      ],
                      stops: [0.0, 0.35, 0.75, 1.0],
                    ),
                  ),
                ),
              ),

              // 2. Full Background Illustration (sky, plane, monuments, globe, clouds)
              Positioned.fill(
                child: Image.asset(
                  'assets/images/splash/splash_illustration.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),

              // 3. Foreground Layout Canvas
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // --- Header: Graduation Cap, Logo & Subtitle with smooth entrance ---
                      Positioned(
                        top: headerTop,
                        left: 0,
                        right: 0,
                        child: SlideTransition(
                          position: _headerSlide,
                          child: FadeTransition(
                            opacity: _headerFade,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Cap + Logo in Stack: Cap perches directly on top of letters
                                SizedBox(
                                  width: logoWidth,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.topCenter,
                                    children: [
                                      // Graduation Cap perched atop logo with clean clip
                                      Positioned(
                                        top: -capHeight * 0.9,
                                        child: ClipRect(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            heightFactor: 0.88,
                                            child: Image.asset(
                                              'assets/images/splash/cap.png',
                                              width: capWidth,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // JoinUniX Logo
                                      Image.asset(
                                        'assets/images/common/logo.png',
                                        width: logoWidth,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                                // Subtitle
                                const Text(
                                  'Connecting Talent\nBuilding Futures',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'sans-serif',
                                    fontSize: 21.5,
                                    height: 1.25,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1B2A56),
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // --- Bottom: Tagline + Loading Bar unified column with smooth entrance ---
                      Positioned(
                        bottom: bottomSectionOffset,
                        left: 0,
                        right: 0,
                        child: SlideTransition(
                          position: _bottomSlide,
                          child: FadeTransition(
                            opacity: _bottomFade,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tagline Script nestled comfortably in the clouds
                                Image.asset(
                                  'assets/images/splash/tagline.png',
                                  width: taglineWidth,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(height: loadingBarGap),
                                // Animated Gradient Loading Bar
                                AnimatedBuilder(
                                  animation: _progressAnimation,
                                  builder: (context, _) {
                                    return SplashLoadingBar(
                                      progress: _progressAnimation.value,
                                      width: loadingBarWidth,
                                      height: 6.5,
                                    );
                                  },
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
            ],
          );
        },
      ),
    );
  }
}
