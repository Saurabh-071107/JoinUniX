import 'package:flutter/material.dart';

/// Reusable selectable card tile representing a class/grade option.
class ClassCardItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? height;

  const ClassCardItem({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: height ?? 68,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF6F2CFF) : const Color(0xFFE2E7F2),
              width: isSelected ? 2.0 : 1.2,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF6F2CFF).withValues(alpha: 0.16),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                )
              else
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 19.5,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? const Color(0xFF5A33EF) : const Color(0xFF1B2A56),
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6F2CFF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                )
              else
                const SizedBox(width: 28, height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
