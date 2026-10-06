import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/otp_input_row.dart';

/// Responsive OTP Verification screen arranged with Stack.
class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback? onBack;
  final VoidCallback? onChangeNumber;
  final ValueChanged<String>? onVerify;

  const OtpScreen({
    super.key,
    this.phoneNumber = '+91 98765 43210',
    this.onBack,
    this.onChangeNumber,
    this.onVerify,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
  int _secondsRemaining = 24;
  Timer? _timer;
  String _currentOtp = '';

  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _startCountdown();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    ));

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsRemaining = 24);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _handleVerify(String otp) {
    _currentOtp = otp;
    widget.onVerify?.call(_currentOtp);
  }

  static Widget _buildSparkle({required double size, required Color color}) {
    return Icon(Icons.auto_awesome, size: size, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final bottomPadding = media.padding.bottom;
    final keyboardHeight = media.viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          final canvasW = totalW > 540 ? 460.0 : totalW;
          final isCompact = totalH < 720;

          final illustrationWidth = (canvasW * 0.88).clamp(250.0, 360.0);
          final artworkTop = (topPadding + (isCompact ? 16.0 : 34.0)).clamp(24.0, 70.0);
          final footerBottom = (bottomPadding + 20.0).clamp(20.0, 48.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Rich Atmospheric Background Gradient
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFEAF3FD),
                        Color(0xFFF3F8FE),
                        Color(0xFFFFFFFF),
                        Color(0xFFF0F5FD),
                      ],
                      stops: [0.0, 0.28, 0.65, 1.0],
                    ),
                  ),
                ),
              ),

              // 2. Decorative Ambient Floating Glow Orbs
              Positioned(
                top: -50,
                right: -40,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFBAE6FD).withValues(alpha: 0.55),
                        const Color(0xFFBAE6FD).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: artworkTop - 20,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFE9D5FF).withValues(alpha: 0.45),
                        const Color(0xFFE9D5FF).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: artworkTop + 40,
                left: (totalW / 2) - 120,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFEF3C7).withValues(alpha: 0.55),
                        const Color(0xFFFEF3C7).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Floating Sparkling Stars & Rings
              Positioned(
                top: artworkTop + 24,
                right: (totalW > 540 ? (totalW / 2) + 160 : totalW * 0.10),
                child: _buildSparkle(
                  size: 22,
                  color: const Color(0xFFFFB020),
                ),
              ),
              Positioned(
                top: artworkTop + 130,
                left: (totalW > 540 ? (totalW / 2) - 190 : totalW * 0.08),
                child: _buildSparkle(
                  size: 18,
                  color: const Color(0xFF4C8DFF),
                ),
              ),
              Positioned(
                bottom: footerBottom + 70,
                right: (totalW > 540 ? (totalW / 2) - 180 : 22),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8E51FF).withValues(alpha: 0.22),
                      width: 2,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: topPadding + 65,
                left: 24,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00BA88).withValues(alpha: 0.25),
                      width: 2,
                    ),
                  ),
                ),
              ),

              // 4. Centered Content Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: SingleChildScrollView(
                    physics: keyboardHeight > 0
                        ? const ClampingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: totalH),
                      child: Stack(
                        children: [
                          // --- Back Button ---
                          Positioned(
                            top: topPadding + 6,
                            left: 16,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: widget.onBack ?? () => Navigator.maybePop(context),
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

                          // --- Content Column: Floating Envelope + OTP Inputs ---
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: artworkTop,
                                  left: 24,
                                  right: 24,
                                  bottom: bottomPadding + 68,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 3D Animated Floating Envelope Artwork
                                    Center(
                                      child: AnimatedBuilder(
                                        animation: _floatAnimation,
                                        builder: (context, child) {
                                          return Transform.translate(
                                            offset: Offset(0, _floatAnimation.value),
                                            child: child,
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/images/auth/otp_envelope.png',
                                          width: illustrationWidth,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: isCompact ? 14 : 26),

                                    // Title (Enlarged & Prominent)
                                    const Text(
                                      'Verify Your Number',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B2A56),
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Subtitle with Phone Number (Enlarged)
                                    const Text(
                                      "We've sent a 6-digit OTP to",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        color: Color(0xFF5D7196),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.phoneNumber,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B2A56),
                                      ),
                                    ),
                                    SizedBox(height: isCompact ? 22 : 30),

                                    // --- 6-Digit OTP Input Row ---
                                    OtpInputRow(
                                      length: 6,
                                      onChanged: (val) => _currentOtp = val,
                                      onCompleted: _handleVerify,
                                    ),
                                    SizedBox(height: isCompact ? 24 : 32),

                                    // --- Resend Section (Enlarged) ---
                                    const Text(
                                      "Didn't receive OTP?",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2563EB),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    if (_secondsRemaining > 0)
                                      Text(
                                        'Resend in ${_secondsRemaining}s',
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF647596),
                                        ),
                                      )
                                    else
                                      InkWell(
                                        onTap: _startCountdown,
                                        borderRadius: BorderRadius.circular(8),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          child: Text(
                                            'Resend Now',
                                            style: TextStyle(
                                              fontSize: 15.5,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF6F2CFF),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // --- Bottom Action: "Change number" (Enlarged) ---
                          Positioned(
                            bottom: footerBottom,
                            left: 20,
                            right: 20,
                            child: Center(
                              child: TextButton(
                                onPressed: widget.onChangeNumber ?? widget.onBack,
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF2563EB),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  textStyle: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Change number'),
                              ),
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
      ),
    );
  }
}
