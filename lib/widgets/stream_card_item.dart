import 'package:flutter/material.dart';

/// Reusable card widget for stream selection grid items.
class StreamCardItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String imagePath;
  final Color bgColor;
  final Color borderColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const StreamCardItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.imagePath,
    required this.bgColor,
    required this.borderColor,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected ? const Color(0xFF6F2CFF) : borderColor,
              width: isSelected ? 2.0 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: (isSelected ? const Color(0xFF6F2CFF) : borderColor)
                    .withValues(alpha: isSelected ? 0.22 : 0.12),
                blurRadius: isSelected ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 3D Illustration Icon (Enlarged)
              SizedBox(
                width: 66,
                height: 66,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),

              // Title (Enlarged)
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1B2A56),
                  letterSpacing: -0.2,
                ),
              ),

              // Optional Subtitle (Enlarged)
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(
                  subtitle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5D7196),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
