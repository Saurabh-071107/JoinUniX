import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';
import 'workflow_shared_widgets.dart';

/// Dedicated Campus Decks & 360° Virtual Tours Screen View.
class CampusDeckView extends StatelessWidget {
  final VoidCallback? onCompleted;

  const CampusDeckView({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sampleCampusDecks.map((deck) {
        final isMit = deck.university.contains('Massachusetts') || deck.university.contains('MIT');
        final isTum = deck.university.contains('Munich') || deck.university.contains('TUM');
        final campusPhoto = isMit
            ? 'assets/images/abroad/mit_campus_deck.png'
            : isTum
                ? 'assets/images/abroad/tum_campus_deck.png'
                : 'assets/images/abroad/campus_header_dome.png';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFFBFDFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              const CardVerticalAccents(tintColor: Color(0xFF2563EB)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header: Logo, University Name & Location, Ranking Pill
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUniversityDeckLogo(deck.university),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deck.university,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.2,
                                height: 1.18,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              deck.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          deck.qsRank,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1D4ED8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 2. Middle Row: Details & Labs on Left, Tall Campus Photo on Right
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deck.overview,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF475569),
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Prominent Research Laboratories:',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            ...deck.topResearchLabs.map((lab) => Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.account_balance_rounded,
                                        size: 13,
                                        color: Color(0xFF334155),
                                      ),
                                      const SizedBox(width: 7),
                                      Expanded(
                                        child: Text(
                                          lab,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 108,
                        height: 196,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            campusPhoto,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // 3. Bottom Row: Student Ratio on Left, 360° Tour Button on Right
                  Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.groups_rounded, size: 18, color: Color(0xFF059669)),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                'Student-Faculty ~ 3:1 Ultra-low ratio',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF059669),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(height: 18, width: 1, color: const Color(0xFFE2E8F0)),
                      const SizedBox(width: 8),
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Launching 360° Virtual Tour of ${deck.university}...'),
                                backgroundColor: const Color(0xFF2563EB),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFF2563EB), width: 1.2),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.explore_rounded, size: 15, color: Color(0xFF2563EB)),
                                SizedBox(width: 5),
                                Text(
                                  '360° Tour',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2563EB),
                                  ),
                                ),
                                SizedBox(width: 3),
                                Icon(Icons.chevron_right_rounded, size: 15, color: Color(0xFF2563EB)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUniversityDeckLogo(String university) {
    if (university.contains('Massachusetts') || university.contains('MIT')) {
      return Container(
        width: 44,
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: const Color(0xFFA31F34)),
            Container(width: 4, color: const Color(0xFFA31F34)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 4, height: 4, color: const Color(0xFFA31F34)),
                Container(width: 4, height: 16, color: const Color(0xFFA31F34)),
              ],
            ),
            Container(width: 4, color: const Color(0xFFA31F34)),
            Container(width: 4, color: const Color(0xFFA31F34)),
          ],
        ),
      );
    } else if (university.contains('Munich') || university.contains('TUM')) {
      return Container(
        width: 46,
        height: 34,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 12, height: 3.5, color: const Color(0xFF0065BD)),
                Container(width: 3.5, height: 19, color: const Color(0xFF0065BD)),
              ],
            ),
            const SizedBox(width: 3),
            Container(
              width: 12,
              height: 22.5,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: Color(0xFF0065BD), width: 3.2),
                  right: BorderSide(color: Color(0xFF0065BD), width: 3.2),
                  bottom: BorderSide(color: Color(0xFF0065BD), width: 3.2),
                ),
              ),
            ),
            const SizedBox(width: 3),
            SizedBox(
              width: 13,
              height: 22.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 3.2, color: const Color(0xFF0065BD)),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(width: 3.0, height: 13, color: const Color(0xFF0065BD)),
                  ),
                  Container(width: 3.2, color: const Color(0xFF0065BD)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0xFF0F62FE).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.school_rounded, color: Color(0xFF0F62FE), size: 22),
    );
  }
}
