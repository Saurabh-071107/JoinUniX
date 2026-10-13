import 'package:flutter/material.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/class_card_item.dart';

/// Screen allowing the user to select their class/grade (e.g., Class 8 to Class 12).
class ClassSelectionScreen extends StatefulWidget {
  final String initialClass;
  final String title;
  final List<String> options;
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  const ClassSelectionScreen({
    super.key,
    this.initialClass = 'Class 10',
    this.title = 'What class are you in?',
    this.options = const ['Class 8', 'Class 9', 'Class 10', 'Class 11', 'Class 12'],
    this.onBack,
    this.onContinue,
  });

  @override
  State<ClassSelectionScreen> createState() => _ClassSelectionScreenState();
}

class _ClassSelectionScreenState extends State<ClassSelectionScreen> {
  late String _selectedClass;

  List<String> get _classList => widget.options;

  @override
  void initState() {
    super.initState();
    _selectedClass = _classList.contains(widget.initialClass) ? widget.initialClass : '';
  }

  void _handleContinue() {
    if (_selectedClass.isNotEmpty) {
      widget.onContinue?.call(_selectedClass);
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
          final isCompact = totalH < 700;

          return Stack(
            fit: StackFit.expand,
            children: [
              // Rich atmospheric background with ambient glow & floating sparks
              const AtmosphericBackground(),

              // Centered Responsive Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
                  child: Stack(
                    children: [
                      // --- Positioned Top-Right: 3D Books Illustration ---
                      Positioned(
                        top: topPadding + (isCompact ? 4 : 8),
                        right: 12,
                        child: IgnorePointer(
                          child: SizedBox(
                            width: isCompact ? 105 : 130,
                            height: isCompact ? 105 : 130,
                            child: Image.asset(
                              'assets/images/common/books_stack.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),

                      // --- Positioned Content: Title + Class Option Cards ---
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + (isCompact ? 64 : 96),
                            left: 20,
                            right: 20,
                            bottom: bottomPadding + 88,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B2A56),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              SizedBox(height: isCompact ? 18 : 28),

                              // Vertically Arranged Selectable Cards
                              for (final classItem in _classList)
                                Padding(
                                  padding: EdgeInsets.only(bottom: isCompact ? 10 : 14),
                                  child: ClassCardItem(
                                    title: classItem,
                                    isSelected: _selectedClass == classItem,
                                    height: isCompact ? 58 : 68,
                                    onTap: () {
                                      setState(() {
                                        _selectedClass = classItem;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // --- Positioned Top-Left: Circular Back Button (On top in Z-index) ---
                      Positioned(
                        top: topPadding + 10,
                        left: 16,
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

                      // --- Positioned Bottom: Gradient Continue CTA Button ---
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
                                onPressed: _selectedClass.isNotEmpty ? _handleContinue : null,
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
