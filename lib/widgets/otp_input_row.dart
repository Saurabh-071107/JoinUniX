import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 6-digit OTP input row with auto-advance and backspace handling.
class OtpInputRow extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  const OtpInputRow({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
  });

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              _controllers[index].text.isEmpty &&
              index > 0) {
            _controllers[index - 1].clear();
            _focusNodes[index - 1].requestFocus();
            setState(() {});
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
      ),
    );
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      // If user pasted or typed multiple digits
      if (value.length > 1) {
        final chars = value.split('');
        for (int i = 0; i < chars.length && (index + i) < widget.length; i++) {
          _controllers[index + i].text = chars[i];
        }
        final nextIndex = (index + chars.length).clamp(0, widget.length - 1);
        _focusNodes[nextIndex].requestFocus();
      } else {
        if (index < widget.length - 1) {
          _focusNodes[index + 1].requestFocus();
        } else {
          _focusNodes[index].unfocus();
        }
      }
    }

    final otp = _controllers.map((c) => c.text).join();
    widget.onChanged?.call(otp);
    if (otp.length == widget.length) {
      widget.onCompleted?.call(otp);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    final canvasW = screenW > 540 ? 460.0 : screenW;
    final totalGaps = (widget.length - 1) * 8.0;
    final boxSize = ((canvasW - 40.0 - totalGaps) / widget.length).clamp(44.0, 52.0);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.length, (index) {
          final isFilled = _controllers[index].text.isNotEmpty;
          final isFocused = _focusNodes[index].hasFocus;

          return Container(
            width: boxSize,
            height: boxSize * 1.2,
            margin: const EdgeInsets.symmetric(horizontal: 4.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isFocused
                    ? const Color(0xFF6F2CFF)
                    : isFilled
                        ? const Color(0xFF8B5CF6)
                        : const Color(0xFFD6DFEE),
                width: isFocused ? 2.0 : 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: isFocused
                      ? const Color(0xFF6F2CFF).withValues(alpha: 0.18)
                      : isFilled
                          ? const Color(0xFF8B5CF6).withValues(alpha: 0.10)
                          : Colors.black.withValues(alpha: 0.03),
                  blurRadius: isFocused ? 10 : 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2A56),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                onChanged: (val) => _onDigitChanged(index, val),
              ),
            ),
          );
        }),
      ),
    );
  }
}
