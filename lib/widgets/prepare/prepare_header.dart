import 'package:flutter/material.dart';

class PrepareHeader extends StatelessWidget {
  final String stage;
  final String exam;
  final VoidCallback? onTap;

  const PrepareHeader({
    super.key,
    this.stage = 'Class 12',
    this.exam = 'JEE Main',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.10),
                blurRadius: 18,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: AspectRatio(
              aspectRatio: 978 / 252,
              child: Image.asset(
                'assets/images/dashboard/prepare_header_banner.png',
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFE8F1FD),
                        Color(0xFFF1EEFD),
                        Color(0xFFFDF2F7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
