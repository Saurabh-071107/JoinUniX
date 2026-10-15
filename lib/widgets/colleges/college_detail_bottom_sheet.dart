import 'package:flutter/material.dart';
import '../../data/college_search_data.dart';
import '../../screens/college_detail_screen.dart';

export '../../screens/college_detail_screen.dart';

/// Redesigned College Detail Bottom Sheet / Modal View
/// Matching the user's reference design with authentic imagery and responsive layout.
class CollegeDetailBottomSheet extends StatefulWidget {
  final CollegeItem college;
  final ValueChanged<bool>? onFavoriteToggle;
  final VoidCallback onApply;

  const CollegeDetailBottomSheet({
    super.key,
    required this.college,
    this.onFavoriteToggle,
    required this.onApply,
  });

  static void show(
    BuildContext context, {
    required CollegeItem college,
    ValueChanged<bool>? onFavoriteToggle,
    required VoidCallback onApply,
  }) {
    CollegeDetailScreen.push(
      context,
      college: college,
      onFavoriteToggle: onFavoriteToggle,
      onApply: onApply,
    );
  }

  @override
  State<CollegeDetailBottomSheet> createState() =>
      _CollegeDetailBottomSheetState();
}

class _CollegeDetailBottomSheetState extends State<CollegeDetailBottomSheet> {
  late bool _isFavorite;
  int _activeHeroIndex = 0;
  late final List<String> _galleryList;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.college.isFavorite;
    if (widget.college.galleryImages.isNotEmpty) {
      _galleryList = widget.college.galleryImages;
    } else {
      _galleryList = [
        widget.college.imagePath,
        'assets/images/dashboard/iit_bombay_academic.jpg',
        'assets/images/dashboard/iit_bombay_lake.jpg',
      ];
    }
  }

  void _handleFavoriteToggle() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteToggle?.call(_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final college = widget.college;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 6),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Scrollable content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: const BouncingScrollPhysics(),
              children: [
                // 1. Campus Hero Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            _galleryList[_activeHeroIndex],
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFFEFF6FF),
                              child: const Center(
                                child: Icon(
                                  Icons.school_rounded,
                                  size: 48,
                                  color: Color(0xFF0F62FE),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Top-Left Badge: 🏆 NIRF #3 Engineering
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6F2CFF), Color(0xFF0F62FE)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.emoji_events_rounded,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  college.badgeText.isNotEmpty
                                      ? college.badgeText
                                      : 'NIRF #3 Engineering',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Bottom-Right Pagination: 1/12
                        Positioned(
                          bottom: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${_activeHeroIndex + 1}/12',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 2. Titles & Accreditation Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Official Logo Emblem
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          college.logoPath ??
                              'assets/images/dashboard/iit_bombay_logo.jpg',
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.school_rounded,
                            size: 26,
                            color: Color(0xFF0F62FE),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  college.shortName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ),
                              if (college.isVerified) ...[
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.verified_rounded,
                                  size: 18,
                                  color: Color(0xFF1D61E7),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            college.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 14,
                                color: Color(0xFF6F2CFF),
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                  '${college.location}  •  ${college.type}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF475569),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Rating Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${college.rating}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF92400E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 3. 2x2 Key Stats Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricBox(
                        icon: Icons.payments_outlined,
                        iconBg: const Color(0xFFEEF2FF),
                        iconColor: const Color(0xFF4F46E5),
                        value: college.avgFees,
                        label: 'Annual Fees',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricBox(
                        icon: Icons.trending_up_rounded,
                        iconBg: const Color(0xFFECFDF5),
                        iconColor: const Color(0xFF059669),
                        value: college.avgPackage,
                        label: 'Average Package',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricBox(
                        icon: Icons.shield_outlined,
                        iconBg: const Color(0xFFEFF6FF),
                        iconColor: const Color(0xFF0284C7),
                        value: college.placementRate,
                        label: 'Placement Rate',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildMetricBox(
                        icon: Icons.assignment_ind_outlined,
                        iconBg: const Color(0xFFF5F3FF),
                        iconColor: const Color(0xFF7C3AED),
                        value: college.examAccepted,
                        label: 'Accepted Exam',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // 4. Specialization Tags
                Row(
                  children: [
                    const Icon(
                      Icons.bar_chart_rounded,
                      size: 18,
                      color: Color(0xFF0F62FE),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Campus Focus & Highlights',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 13,
                        color: Color(0xFF0F62FE),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildPill('IIT', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                    _buildPill('Engineering', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
                    _buildPill('Govt', const Color(0xFFDCFCE7), const Color(0xFF16A34A)),
                    _buildPill('Research', const Color(0xFFFFEDD5), const Color(0xFFEA580C)),
                  ],
                ),
                const SizedBox(height: 16),

                // 5. Gallery Thumbnails
                SizedBox(
                  height: 84,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _galleryList.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = _activeHeroIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _activeHeroIndex = index),
                        child: Container(
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF0F62FE)
                                  : const Color(0xFFE2E8F0),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              _galleryList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // 6. Sticky Bottom CTA Row
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(top: BorderSide(color: Color(0xFFE2E8F0))),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Bookmark "Save" button
                InkWell(
                  onTap: _handleFavoriteToggle,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    width: 54,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isFavorite
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_outline_rounded,
                          size: 18,
                          color: _isFavorite
                              ? const Color(0xFF0F62FE)
                              : const Color(0xFF0F172A),
                        ),
                        Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: _isFavorite
                                ? const Color(0xFF0F62FE)
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Apply / View Cutoffs Button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onApply();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F62FE),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Apply / View Cutoffs',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward_rounded, size: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBox({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(String title, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
