import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Screen allowing the user to enter their mobile number for OTP verification.
class MobileNumberScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  const MobileNumberScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+91';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    const codes = ['+91', '+1', '+44', '+61', '+971', '+65'];
    showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Country Code',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            for (final code in codes)
              ListTile(
                title: Text(code),
                trailing: _selectedCountryCode == code
                    ? const Icon(Icons.check, color: Color(0xFF6F2CFF))
                    : null,
                onTap: () {
                  setState(() => _selectedCountryCode = code);
                  Navigator.pop(ctx);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _handleContinue() {
    final phone = _phoneController.text.trim();
    widget.onContinue?.call('$_selectedCountryCode $phone');
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

          final illustrationWidth = (canvasW * 1.2).clamp(210.0, 310.0);
          final artworkTop = (topPadding + (isCompact ? 16.0 : 36.0)).clamp(24.0, 70.0);
          final footerBottom = (bottomPadding + 20.0).clamp(20.0, 48.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Atmospheric Background Gradient
              const Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFEAF3FD),
                        Color(0xFFF4F8FD),
                        Color(0xFFFAFCFF),
                        Colors.white,
                      ],
                      stops: [0.0, 0.35, 0.70, 1.0],
                    ),
                  ),
                ),
              ),

              // 2. Ambient Decorative Background Elements (Orbs, Sparkles & Floating Shapes)
              Positioned.fill(
                child: IgnorePointer(
                  child: Stack(
                    children: [
                      // Top-Right Soft Sky Blue Glow Orb
                      Positioned(
                        top: -40,
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

                      // Top-Left Soft Lavender Glow Orb
                      Positioned(
                        top: 40,
                        left: -50,
                        child: Container(
                          width: 190,
                          height: 190,
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

                      // Center Soft Warm Peach Glow behind phone
                      Positioned(
                        top: artworkTop + 30,
                        left: (totalW / 2) - 120,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFFFFEDD5).withValues(alpha: 0.50),
                                const Color(0xFFFFEDD5).withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Floating 4-Point Golden Sparkle (Top-Right)
                      Positioned(
                        top: artworkTop + 18,
                        right: (totalW > 540 ? (totalW / 2) + 160 : totalW * 0.12),
                        child: _buildSparkle(
                          size: 20,
                          color: const Color(0xFFFFB020),
                        ),
                      ),

                      // Floating 4-Point Blue Sparkle (Middle-Left)
                      Positioned(
                        top: artworkTop + 140,
                        left: (totalW > 540 ? (totalW / 2) - 190 : totalW * 0.08),
                        child: _buildSparkle(
                          size: 16,
                          color: const Color(0xFF4C8DFF),
                        ),
                      ),

                      // Floating Translucent Pastel Ring (Bottom-Right)
                      Positioned(
                        bottom: footerBottom + 80,
                        right: (totalW > 540 ? (totalW / 2) - 180 : 20),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF8E51FF).withValues(alpha: 0.20),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      // Floating Translucent Mint Ring (Top-Left)
                      Positioned(
                        top: topPadding + 65,
                        left: 28,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF00BA88).withValues(alpha: 0.25),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      // Subtle Floating Pastel Dot (Center-Right)
                      Positioned(
                        top: artworkTop + 220,
                        right: (totalW > 540 ? (totalW / 2) + 180 : 36),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFFF8E3C).withValues(alpha: 0.40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Centered Canvas Wrapper
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
                      child: IntrinsicHeight(
                        child: Stack(
                          children: [
                            // --- Back Button ---
                            Positioned(
                              top: topPadding + 4,
                              left: 12,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: widget.onBack ?? () => Navigator.maybePop(context),
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFFE2E7F2),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.04),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 20,
                                      color: Color(0xFF1E2A54),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // --- Content Column: Illustration + Form ---
                            Padding(
                              padding: EdgeInsets.only(
                                top: artworkTop,
                                left: 24,
                                right: 24,
                                bottom: footerBottom + 65,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // 3D Phone & OTP Artwork
                                  Center(
                                    child: Image.asset(
                                      'assets/images/auth/phone_illustration.png',
                                      width: illustrationWidth,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(height: isCompact ? 12 : 24),

                                  // Headlines
                                  const Text(
                                    "Let's Get Started",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFF233870),
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const Text(
                                    'Enter your mobile number',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1B2A56),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    "We'll send you a secure OTP\nto verify your number.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      height: 1.35,
                                      color: Color(0xFF637494),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: isCompact ? 18 : 28),

                                  // --- Phone Input Row ---
                                  Row(
                                    children: [
                                      // Country Code Dropdown
                                      InkWell(
                                        onTap: _showCountryPicker,
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          height: 52,
                                          padding: const EdgeInsets.symmetric(horizontal: 14),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: const Color(0xFFE2E7F2),
                                              width: 1.2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.02),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                _selectedCountryCode,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF1B2A56),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(
                                                Icons.keyboard_arrow_down_rounded,
                                                size: 24,
                                                color: Color(0xFF67799B),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Mobile Number Input Field
                                      Expanded(
                                        child: Container(
                                          height: 52,
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: const Color(0xFFE2E7F2),
                                              width: 1.2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.02),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            controller: _phoneController,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(10),
                                            ],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1B2A56),
                                              letterSpacing: 1.0,
                                            ),
                                            decoration: const InputDecoration(
                                              hintText: '98765 43210',
                                              hintStyle: TextStyle(
                                                color: Color(0xFF9EADC6),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.3,
                                              ),
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: isCompact ? 16 : 22),

                                  // --- Continue Button ---
                                  SizedBox(
                                    width: double.infinity,
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
                                            blurRadius: 16,
                                            offset: const Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: _handleContinue,
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
                                              'Continue',
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
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
                                ],
                              ),
                            ),

                            // --- Bottom Security Badge (Elevated & Enlarged) ---
                            Positioned(
                              bottom: footerBottom,
                              left: 20,
                              right: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE3F8EE),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFC6F4DC),
                                        width: 1,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF00BA88).withValues(alpha: 0.12),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.verified_user_rounded,
                                      size: 22,
                                      color: Color(0xFF00BA88),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Flexible(
                                    child: Text(
                                      'Your information is safe with us\nand will never be shared.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.35,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF4C5E82),
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
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Helper to render a decorative 4-point sparkle star
  static Widget _buildSparkle({required double size, required Color color}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SparklePainter(color: color),
      ),
    );
  }
}

/// Custom painter for a smooth 4-point star sparkle accent
class _SparklePainter extends CustomPainter {
  final Color color;

  const _SparklePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = size.width / 2;

    final path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(cx, cy, size.width, cy)
      ..quadraticBezierTo(cx, cy, cx, size.height)
      ..quadraticBezierTo(cx, cy, 0, cy)
      ..quadraticBezierTo(cx, cy, cx, 0)
      ..close();

    canvas.drawPath(path, paint);

    // Subtle center glow
    final glowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(cx, cy), rx * 0.25, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) =>
      oldDelegate.color != color;
}
