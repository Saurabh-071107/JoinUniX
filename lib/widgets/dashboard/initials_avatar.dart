import 'package:flutter/material.dart';

/// Reusable avatar displaying the user's name initials with a sleek gradient.
class InitialsAvatar extends StatelessWidget {
  final String name;
  final double size;
  final double fontSize;
  final bool showOnlineBadge;
  final VoidCallback? onTap;

  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 48,
    this.fontSize = 18,
    this.showOnlineBadge = false,
    this.onTap,
  });

  String get initials {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'U';
    final parts = trimmed.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1,
              letterSpacing: 0.5,
            ),
          ),
        ),
        if (showOnlineBadge)
          Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              width: size > 50 ? 14 : 11,
              height: size > 50 ? 14 : 11,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }
    return avatar;
  }
}
