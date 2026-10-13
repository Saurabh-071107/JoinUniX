import 'package:flutter/material.dart';

/// Reusable card widget for stream selection grid items.
class StreamCardItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imagePath;
  final IconData? icon;
  final Color bgColor;
  final Color borderColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const StreamCardItem({
    super.key,
    required this.title,
    this.subtitle,
    this.imagePath,
    this.icon,
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardW = constraints.maxWidth;
              final cardH = constraints.maxHeight;

              final iconSize = (cardH * 0.46).clamp(76.0, 96.0);
              final titleSize = (cardW * 0.125).clamp(20.0, 23.0);
              final subtitleSize = (cardW * 0.10).clamp(15.5, 17.5);
              final spacing = (cardH * 0.04).clamp(6.0, 10.0);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 3D Illustration Icon (Enlarged)
                  SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: imagePath != null
                        ? Image.asset(imagePath!, fit: BoxFit.contain)
                        : Icon(icon, size: iconSize * 0.62, color: const Color(0xFF6F2CFF)),
                  ),
                  SizedBox(height: spacing),

                  // Title (Enlarged)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1B2A56),
                      letterSpacing: -0.3,
                      height: 1.15,
                    ),
                  ),

                  // Optional Subtitle (Enlarged)
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF5D7196),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
