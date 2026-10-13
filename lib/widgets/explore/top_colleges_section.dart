import 'package:flutter/material.dart';
import '../../data/explore_data.dart';

class TopCollegesSection extends StatefulWidget {
  final ValueChanged<CollegeCardItem>? onCollegeTap;

  const TopCollegesSection({
    super.key,
    this.onCollegeTap,
  });

  @override
  State<TopCollegesSection> createState() => _TopCollegesSectionState();
}

class _TopCollegesSectionState extends State<TopCollegesSection> {
  final Set<String> _favorites = {'IIT Bombay', 'IIT Delhi'};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            children: [
              const Icon(
                Icons.account_balance_rounded,
                size: 20,
                color: Color(0xFFE11D48),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Top Colleges for You',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.onCollegeTap != null && topCollegeItems.isNotEmpty) {
                    widget.onCollegeTap!(topCollegeItems.first);
                  }
                },
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 13,
                        color: Color(0xFF4F46E5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal List of College Cards
        SizedBox(
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: topCollegeItems.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final college = topCollegeItems[index];
              return _buildCollegeCard(college);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeCard(CollegeCardItem college) {
    final isFav = _favorites.contains(college.name);

    return GestureDetector(
      onTap: () => widget.onCollegeTap?.call(college),
      child: Container(
        width: 176,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campus Image with Favorite Heart
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    college.imagePath,
                    height: 94,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 94,
                      color: const Color(0xFFF1F5F9),
                      child: const Center(
                        child: Icon(Icons.school_rounded, color: Color(0xFF6366F1), size: 36),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isFav) {
                          _favorites.remove(college.name);
                        } else {
                          _favorites.add(college.name);
                        }
                      });
                    },
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        size: 15,
                        color: isFav ? const Color(0xFFEF4444) : const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // College Name
            Text(
              college.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 3),

            // Location with Pin Icon
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 13,
                  color: Color(0xFF64748B),
                ),
                const SizedBox(width: 3),
                Expanded(
                  child: Text(
                    college.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
