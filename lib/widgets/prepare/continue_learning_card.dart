import 'package:flutter/material.dart';

class ContinueLearningCard extends StatelessWidget {
  final VoidCallback? onContinue;

  const ContinueLearningCard({
    super.key,
    this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 380;
          final isWide = constraints.maxWidth >= 540;

          // Compact fixed height with comfortable breathing room (no overflow)
          final cardHeight = isCompact ? 138.0 : (isWide ? 148.0 : 142.0);
          final whiteBoxWidth = constraints.maxWidth * (isCompact ? 0.54 : (isWide ? 0.50 : 0.53));
          final bookWidth = constraints.maxWidth * (isCompact ? 0.50 : (isWide ? 0.46 : 0.48));

          return Container(
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFEFF5FE),
                  Color(0xFFF4F0FE),
                  Color(0xFFFDF2F8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.07),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(21),
              child: Stack(
                children: [
                  // 1. 3D Book Illustration on the Right
                  Positioned(
                    right: -2,
                    top: 6,
                    bottom: 6,
                    width: bookWidth,
                    child: Image.asset(
                      'assets/images/dashboard/prepare_continue_book.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.centerRight,
                      errorBuilder: (_, _, _) => const SizedBox(),
                    ),
                  ),

                  // 2. Left Content: Header + White Topic Box (Top-anchored, natural sizing)
                  Positioned(
                    left: isCompact ? 12 : 14,
                    top: isCompact ? 9 : 11,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header Row
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: isCompact ? 26 : 30,
                              height: isCompact ? 26 : 30,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEEF2FF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.gps_fixed_rounded,
                                size: isCompact ? 14 : 16,
                                color: const Color(0xFF4F46E5),
                              ),
                            ),
                            SizedBox(width: isCompact ? 6 : 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Continue Learning',
                                  style: TextStyle(
                                    fontSize: isCompact ? 13.5 : (isWide ? 15.5 : 14.5),
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF0F172A),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                Text(
                                  'Current Topic • Class 12 • JEE Main',
                                  style: TextStyle(
                                    fontSize: isCompact ? 9.5 : (isWide ? 11.5 : 10.5),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: isCompact ? 7 : 9),

                        // White Topic Box ("Rotational Motion")
                        Container(
                          width: whiteBoxWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: isCompact ? 10 : 12,
                            vertical: isCompact ? 6.5 : 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Rotational Motion',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: isCompact ? 12.0 : (isWide ? 14.0 : 13.0),
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF0F172A),
                                  letterSpacing: -0.2,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Physics • Chapter 4',
                                style: TextStyle(
                                  fontSize: isCompact ? 9.5 : (isWide ? 11.0 : 10.0),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF64748B),
                                  height: 1.15,
                                ),
                              ),
                              SizedBox(height: isCompact ? 5 : 6),
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: LinearProgressIndicator(
                                        value: 0.60,
                                        minHeight: isCompact ? 4.0 : 5.0,
                                        backgroundColor: const Color(0xFFF1F5F9),
                                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: isCompact ? 5 : 7),
                                  Text(
                                    '60%',
                                    style: TextStyle(
                                      fontSize: isCompact ? 10.0 : (isWide ? 11.5 : 11.0),
                                      fontWeight: FontWeight.w800,
                                      color: const Color(0xFF3B82F6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. Continue Button Overlapping Bottom-Right of Book Image
                  Positioned(
                    right: isCompact ? 10 : 14,
                    bottom: isCompact ? 10 : 12,
                    child: GestureDetector(
                      onTap: onContinue,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isCompact ? 12 : 15,
                          vertical: isCompact ? 6.5 : 7.5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4F46E5),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: isCompact ? 11.5 : (isWide ? 13.0 : 12.0),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.1,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: isCompact ? 13 : 15,
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
          );
        },
      ),
    );
  }
}
