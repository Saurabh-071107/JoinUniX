import 'package:flutter/material.dart';
import '../data/onboarding_options.dart';
import '../widgets/stream_card_item.dart';
import '../widgets/atmospheric_background.dart';

/// Card-grid picker reused for stream / course / profession selection.
class StreamScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;
  final String title;
  final String subtitle;
  final List<StreamOption>? options;

  /// Optional dropdown shown under the grid; items depend on the selected card.
  final String? dropdownHint;
  final String? dropdownLabel;
  final IconData? dropdownIcon;
  final List<String> Function(String selected)? dropdownItems;

  const StreamScreen({
    super.key,
    this.onBack,
    this.onContinue,
    this.title = 'Which stream are you in?',
    this.subtitle = 'Choose your stream',
    this.options,
    this.dropdownHint,
    this.dropdownLabel,
    this.dropdownIcon,
    this.dropdownItems,
  });

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  String _selectedStream = '';
  String? _dropdownValue;
  final _otherCtrl = TextEditingController();

  List<StreamOption> get _streams => widget.options ?? schoolStreams;
  bool get _isOther => _selectedStream == 'Other';
  List<String> get _items =>
      _selectedStream.isEmpty ? const [] : widget.dropdownItems?.call(_selectedStream) ?? const [];

  bool get _canContinue =>
      _selectedStream.isNotEmpty &&
      (!_isOther || _otherCtrl.text.trim().isNotEmpty) &&
      (_items.isEmpty || _dropdownValue != null);

  @override
  void dispose() {
    _otherCtrl.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final main = _isOther ? _otherCtrl.text.trim() : _selectedStream;
    widget.onContinue?.call(_dropdownValue == null ? main : '$main • $_dropdownValue');
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

          return Stack(            fit: StackFit.expand,
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
                              Text(
                                widget.title,
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
                              Text(
                                widget.subtitle,
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
                                childAspectRatio: isCompact ? 0.90 : 0.86,
                                children: [
                                  for (final s in _streams)
                                    StreamCardItem(
                                      title: s.title,
                                      subtitle: s.subtitle,
                                      imagePath: s.imagePath,
                                      icon: s.icon,
                                      bgColor: s.bgColor,
                                      borderColor: s.borderColor,
                                      isSelected: _selectedStream == s.keyName,
                                      onTap: () {
                                        setState(() {
                                          _selectedStream = s.keyName;
                                          if (!_items.contains(_dropdownValue)) _dropdownValue = null;
                                        });
                                      },
                                    ),
                                ],
                              ),

                              // "Other" custom specification input
                              if (_isOther) ...[
                                const SizedBox(height: 18),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: _otherCtrl.text.trim().isNotEmpty
                                          ? const Color(0xFF6F2CFF).withValues(alpha: 0.35)
                                          : const Color(0xFFE2E7F2),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.03),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.edit_note_rounded,
                                            size: 20,
                                            color: Color(0xFF6F2CFF),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Custom Specification',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF1B2A56),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      TextField(
                                        controller: _otherCtrl,
                                        onChanged: (_) => setState(() {}),
                                        textCapitalization: TextCapitalization.words,
                                        style: const TextStyle(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1B2A56),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Please specify your title / role',
                                          hintStyle: const TextStyle(
                                            color: Color(0xFF94A3B8),
                                            fontSize: 14.5,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF8FAFC),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: Color(0xFFE2E7F2)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE2E7F2),
                                              width: 1.2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF6F2CFF),
                                              width: 1.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              // Redesigned Context Dropdown (Experience / Specialization)
                              if (_items.isNotEmpty) ...[
                                const SizedBox(height: 18),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: _dropdownValue != null
                                          ? const Color(0xFF6F2CFF).withValues(alpha: 0.35)
                                          : const Color(0xFFE2E7F2),
                                      width: _dropdownValue != null ? 1.5 : 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _dropdownValue != null
                                            ? const Color(0xFF6F2CFF).withValues(alpha: 0.08)
                                            : Colors.black.withValues(alpha: 0.03),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Label row with badge
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFEDE9FE),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              widget.dropdownIcon ?? Icons.work_history_rounded,
                                              size: 18,
                                              color: const Color(0xFF6F2CFF),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.dropdownLabel ?? 'Experience Level',
                                                  style: const TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xFF1B2A56),
                                                    letterSpacing: -0.2,
                                                  ),
                                                ),
                                                const SizedBox(height: 1),
                                                Text(
                                                  _dropdownValue != null
                                                      ? 'Selected'
                                                      : 'Required to continue',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: _dropdownValue != null
                                                        ? const Color(0xFF10B981)
                                                        : const Color(0xFF8A99B5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (_dropdownValue != null)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFEDE9FE),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                _dropdownValue!,
                                                style: const TextStyle(
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF6F2CFF),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),

                                      // Dropdown Form Field
                                      DropdownButtonFormField<String>(
                                        key: ValueKey('$_selectedStream-${widget.dropdownHint}'),
                                        initialValue: _dropdownValue,
                                        isExpanded: true,
                                        dropdownColor: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        elevation: 8,
                                        icon: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3F5FA),
                                            borderRadius: BorderRadius.circular(9),
                                          ),
                                          child: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            size: 20,
                                            color: Color(0xFF5D7196),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1B2A56),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: widget.dropdownHint ?? 'Select your experience',
                                          hintStyle: const TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF94A3B8),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFFF8FAFC),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE2E7F2),
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFE2E7F2),
                                              width: 1.2,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                              color: Color(0xFF6F2CFF),
                                              width: 1.8,
                                            ),
                                          ),
                                        ),
                                        items: [
                                          for (final i in _items)
                                            DropdownMenuItem(
                                              value: i,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 7,
                                                    height: 7,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: _dropdownValue == i
                                                          ? const Color(0xFF6F2CFF)
                                                          : const Color(0xFFCBD5E1),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      i,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: _dropdownValue == i
                                                            ? FontWeight.w700
                                                            : FontWeight.w500,
                                                        color: _dropdownValue == i
                                                            ? const Color(0xFF6F2CFF)
                                                            : const Color(0xFF1B2A56),
                                                      ),
                                                    ),
                                                  ),
                                                  if (_dropdownValue == i)
                                                    const Icon(
                                                      Icons.check_rounded,
                                                      size: 18,
                                                      color: Color(0xFF6F2CFF),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                        onChanged: (v) => setState(() => _dropdownValue = v),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      // --- Top-Left Back Button (On top in Z-index) ---
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
                                onPressed: _canContinue ? _handleContinue : null,
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
