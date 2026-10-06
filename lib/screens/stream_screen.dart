import 'package:flutter/material.dart';
import '../widgets/stream_card_item.dart';
import '../widgets/atmospheric_background.dart';

/// Screen allowing the user to select their stream (PCM, PCB, Commerce, etc.).
class StreamScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  const StreamScreen({
    super.key,
    this.onBack,
    this.onContinue,
  });

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  String _selectedStream = '';

  static const _streams = [
    (
      title: 'Science',
      subtitle: '(PCM)',
      keyName: 'Science (PCM)',
      imagePath: 'assets/images/streams/science_pcm.png',
      bgColor: Color(0xFFF7F8FE),
      borderColor: Color(0xFFE4E7FA),
    ),
    (
      title: 'Science',
      subtitle: '(PCB)',
      keyName: 'Science (PCB)',
      imagePath: 'assets/images/streams/science_pcb.png',
      bgColor: Color(0xFFF3FBF7),
      borderColor: Color(0xFFDAEFE5),
    ),
    (
      title: 'Commerce',
      subtitle: null,
      keyName: 'Commerce',
      imagePath: 'assets/images/streams/commerce.png',
      bgColor: Color(0xFFFEFBF2),
      borderColor: Color(0xFFF8EED9),
    ),
    (
      title: 'Arts & Humanities',
      subtitle: null,
      keyName: 'Arts & Humanities',
      imagePath: 'assets/images/streams/arts_humanities.png',
      bgColor: Color(0xFFFDF4FB),
      borderColor: Color(0xFFF8E1F3),
    ),
    (
      title: 'Vocational',
      subtitle: null,
      keyName: 'Vocational',
      imagePath: 'assets/images/streams/vocational.png',
      bgColor: Color(0xFFF3F8FE),
      borderColor: Color(0xFFDDE8FA),
    ),
    (
      title: 'Not Sure Yet',
      subtitle: null,
      keyName: 'Not Sure Yet',
      imagePath: 'assets/images/streams/not_sure_yet.png',
      bgColor: Color(0xFFFEF8EE),
      borderColor: Color(0xFFF8EAD4),
    ),
  ];

  void _handleContinue() {
    if (_selectedStream.isNotEmpty) {
      widget.onContinue?.call(_selectedStream);
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final topPadding = media.padding.top;
    final bottomPadding = media.padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFE),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalH = constraints.maxHeight;
          final totalW = constraints.maxWidth;
          final canvasW = totalW > 540 ? 460.0 : totalW;
          final isCompact = totalH < 720;

          return Stack(
            fit: StackFit.expand,
            children: [
              // 1. Rich Atmospheric Background
              const AtmosphericBackground(),

              // 2. Centered Canvas
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: canvasW,
                  height: totalH,
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

                      // --- Scrollable Content: Header + 2-Column Grid ---
                      Positioned.fill(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            top: topPadding + 12,
                            left: 20,
                            right: 20,
                            bottom: bottomPadding + 90,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 42),

                              // Header Title (Enlarged)
                              const Text(
                                'Which stream are you in?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B2A56),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Header Subtitle (Enlarged)
                              const Text(
                                'Choose your stream',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF5D7196),
                                ),
                              ),
                              SizedBox(height: isCompact ? 18 : 26),

                              // 2-Column Grid of 6 Stream Cards
                              GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: isCompact ? 1.05 : 1.10,
                                children: [
                                  for (final s in _streams)
                                    StreamCardItem(
                                      title: s.title,
                                      subtitle: s.subtitle,
                                      imagePath: s.imagePath,
                                      bgColor: s.bgColor,
                                      borderColor: s.borderColor,
                                      isSelected: _selectedStream == s.keyName,
                                      onTap: () {
                                        setState(() {
                                          _selectedStream = s.keyName;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // --- Floating Bottom Continue Button (Enlarged) ---
                      Positioned(
                        bottom: (bottomPadding + 18).clamp(18.0, 42.0),
                        left: 20,
                        right: 20,
                        child: Center(
                          child: SizedBox(
                            width: (canvasW * 0.90).clamp(270.0, 380.0),
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
                                onPressed: _selectedStream.isNotEmpty ? _handleContinue : null,
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
