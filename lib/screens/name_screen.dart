import 'package:flutter/material.dart';

/// Screen allowing the user to enter their name as part of onboarding.
class NameScreen extends StatefulWidget {
  final String initialName;
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  const NameScreen({
    super.key,
    this.initialName = 'Saurabh',
    this.onBack,
    this.onContinue,
  });

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> with TickerProviderStateMixin {
  late final TextEditingController _nameController;

  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);

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
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0.0, end: -7.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      widget.onContinue?.call(name);
    }
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

          final avatarWidth = (canvasW * 0.85).clamp(250.0, 360.0);
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
                top: artworkTop + 35,
                left: (totalW / 2) - 120,
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFEDE9FE).withValues(alpha: 0.60),
                        const Color(0xFFEDE9FE).withValues(alpha: 0.0),
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
                top: artworkTop + 140,
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

                          // --- Content Column: Avatar + Title + Name Input + Button ---
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: artworkTop,
                                  left: 24,
                                  right: 24,
                                  bottom: bottomPadding + 36,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 3D Animated Floating Avatar Artwork
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
                                          'assets/images/auth/user_avatar.png',
                                          width: avatarWidth,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: isCompact ? 16 : 26),

                                    // Headlines (Enlarged & Prominent)
                                    const Text(
                                      "First, let's get to know you",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B2A56),
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'What should we call you?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1B2A56),
                                      ),
                                    ),
                                    SizedBox(height: isCompact ? 22 : 32),

                                    // --- Name Input Box with Clear Button (Enlarged) ---
                                    Container(
                                      height: 60,
                                      padding: const EdgeInsets.symmetric(horizontal: 18),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        border: Border.all(
                                          color: _nameController.text.trim().isNotEmpty
                                              ? const Color(0xFF6F2CFF)
                                              : const Color(0xFFD6DFEE),
                                          width: _nameController.text.trim().isNotEmpty ? 1.8 : 1.2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _nameController.text.trim().isNotEmpty
                                                ? const Color(0xFF6F2CFF).withValues(alpha: 0.12)
                                                : Colors.black.withValues(alpha: 0.03),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _nameController,
                                              textCapitalization: TextCapitalization.words,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF1B2A56),
                                              ),
                                              decoration: const InputDecoration(
                                                hintText: 'Enter your name',
                                                hintStyle: TextStyle(
                                                  color: Color(0xFF9EADC6),
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              onChanged: (_) => setState(() {}),
                                              onSubmitted: (_) => _handleContinue(),
                                            ),
                                          ),
                                          if (_nameController.text.isNotEmpty)
                                            InkWell(
                                              onTap: () {
                                                _nameController.clear();
                                                setState(() {});
                                              },
                                              borderRadius: BorderRadius.circular(12),
                                              child: const Padding(
                                                padding: EdgeInsets.all(6),
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  size: 20,
                                                  color: Color(0xFF94A3B8),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: isCompact ? 16 : 22),

                                    // --- Continue Button (Enlarged) ---
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
                                          onPressed: _nameController.text.trim().isNotEmpty
                                              ? _handleContinue
                                              : null,
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
                                  ],
                                ),
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
