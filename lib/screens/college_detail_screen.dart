import 'package:flutter/material.dart';
import '../data/college_search_data.dart';

/// Full-screen pixel-perfect College Detail Screen matching user design reference.
class CollegeDetailScreen extends StatefulWidget {
  final CollegeItem college;
  final ValueChanged<bool>? onFavoriteToggle;
  final VoidCallback? onApply;

  const CollegeDetailScreen({
    super.key,
    required this.college,
    this.onFavoriteToggle,
    this.onApply,
  });

  static Future<void> push(
    BuildContext context, {
    required CollegeItem college,
    ValueChanged<bool>? onFavoriteToggle,
    VoidCallback? onApply,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CollegeDetailScreen(
          college: college,
          onFavoriteToggle: onFavoriteToggle,
          onApply: onApply,
        ),
      ),
    );
  }

  @override
  State<CollegeDetailScreen> createState() => _CollegeDetailScreenState();
}

class _CollegeDetailScreenState extends State<CollegeDetailScreen> {
  late bool _isFavorite;
  int _activeHeroIndex = 0;
  late final PageController _pageController;

  late final List<String> _galleryList;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.college.isFavorite;
    _pageController = PageController();

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleFavoriteToggle() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    widget.onFavoriteToggle?.call(_isFavorite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? 'Saved ${widget.college.shortName} to your shortlist'
              : 'Removed ${widget.college.shortName} from shortlist',
        ),
        backgroundColor: const Color(0xFF0F62FE),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  void _handleShare() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${widget.college.fullName} link & brochure...'),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  void _handleApply() {
    if (widget.onApply != null) {
      widget.onApply!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Opening Cutoffs & Application portal for ${widget.college.shortName}...',
          ),
          backgroundColor: const Color(0xFF0F62FE),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final college = widget.college;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Navigation Bar (Circular Back, Bookmark & Share buttons)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _buildCircularIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => Navigator.of(context).pop(),
                    iconSize: 26,
                  ),
                  const Spacer(),
                  _buildCircularIconButton(
                    icon: _isFavorite
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    iconColor: _isFavorite
                        ? const Color(0xFF0F62FE)
                        : const Color(0xFF0F172A),
                    onTap: _handleFavoriteToggle,
                  ),
                  const SizedBox(width: 10),
                  _buildCircularIconButton(
                    icon: Icons.share_outlined,
                    onTap: _handleShare,
                  ),
                ],
              ),
            ),

            // 2. Scrollable Body Content
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                children: [
                  // Hero Campus Image Box
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      height: 220,
                      width: double.infinity,
                      color: const Color(0xFFF1F5F9),
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: _galleryList.length,
                            onPageChanged: (i) =>
                                setState(() => _activeHeroIndex = i),
                            itemBuilder: (context, index) {
                              return Image.asset(
                                _galleryList[index],
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  color: const Color(0xFFEFF6FF),
                                  child: const Center(
                                    child: Icon(
                                      Icons.apartment_rounded,
                                      size: 54,
                                      color: Color(0xFF0F62FE),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Top-Left Badge: 🏆 NIRF #3 Engineering
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF6F2CFF),
                                    Color(0xFF0F62FE),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F62FE)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.emoji_events_rounded,
                                    color: Colors.amber,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    college.badgeText.isNotEmpty
                                        ? college.badgeText
                                        : 'NIRF #3 Engineering',
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Bottom-Right Pagination Badge: 1/12
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 4.5),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${_activeHeroIndex + 1}/${_galleryList.length > 3 ? _galleryList.length : 12}',
                                style: const TextStyle(
                                  fontSize: 11.5,
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

                  // 3. College Emblem, Title, Location & Star Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // College Emblem / Crest Logo
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: college.logoPath != null
                              ? Image.asset(
                                  college.logoPath!,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.school_rounded,
                                    size: 28,
                                    color: Color(0xFF0F62FE),
                                  ),
                                )
                              : Image.asset(
                                  'assets/images/dashboard/iit_bombay_logo.jpg',
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.school_rounded,
                                    size: 28,
                                    color: Color(0xFF0F62FE),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Title & Subtitle & Location
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
                                      fontSize: 22,
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
                                    size: 19,
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
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  size: 14.5,
                                  color: Color(0xFF6F2CFF),
                                ),
                                const SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    '${college.location}  •  ${college.type}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
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

                      // Star Rating Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 17,
                              color: Color(0xFFF59E0B),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${college.rating}',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF92400E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // 4. 2x2 Key Stats Grid (Individual Aesthetic Cards)
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.payments_outlined,
                          iconBg: const Color(0xFFEEF2FF),
                          iconColor: const Color(0xFF4F46E5),
                          value: college.avgFees,
                          label: 'Annual Fees',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.trending_up_rounded,
                          iconBg: const Color(0xFFECFDF5),
                          iconColor: const Color(0xFF059669),
                          value: college.avgPackage,
                          label: 'Average Package',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.shield_outlined,
                          iconBg: const Color(0xFFEFF6FF),
                          iconColor: const Color(0xFF0284C7),
                          value: college.placementRate,
                          label: 'Placement Rate',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          icon: Icons.assignment_ind_outlined,
                          iconBg: const Color(0xFFF5F3FF),
                          iconColor: const Color(0xFF7C3AED),
                          value: college.examAccepted,
                          label: 'Accepted Exam',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 5. Campus Focus & Highlights Section
                  Row(
                    children: [
                      const Icon(
                        Icons.bar_chart_rounded,
                        size: 20,
                        color: Color(0xFF0F62FE),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Campus Focus & Highlights',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 15,
                          color: Color(0xFF0F62FE),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Highlights Pastel Tags Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildTagPill('IIT', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                      _buildTagPill('Engineering', const Color(0xFFF3E8FF), const Color(0xFF7C3AED)),
                      _buildTagPill('Govt', const Color(0xFFDCFCE7), const Color(0xFF16A34A)),
                      _buildTagPill('Research', const Color(0xFFFFEDD5), const Color(0xFFEA580C)),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // 6. Campus Photo Gallery Thumbnails
                  SizedBox(
                    height: 96,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _galleryList.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final isSelected = _activeHeroIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _activeHeroIndex = index);
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCubic,
                            );
                          },
                          child: Container(
                            width: 124,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF0F62FE)
                                    : const Color(0xFFE2E8F0),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                _galleryList[index],
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  color: const Color(0xFFF1F5F9),
                                  child: const Icon(Icons.image_outlined, color: Color(0xFF94A3B8)),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 7. Sticky Bottom Action Bar matching user screenshot
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(
                  top: BorderSide(color: Color(0xFFF1F5F9), width: 1.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
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
                      width: 58,
                      height: 52,
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
                            size: 20,
                            color: _isFavorite
                                ? const Color(0xFF0F62FE)
                                : const Color(0xFF0F172A),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 10,
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
                  const SizedBox(width: 12),

                  // Apply / View Cutoffs Primary Blue Button
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _handleApply,
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
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 18),
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
      ),
    );
  }

  Widget _buildCircularIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
    double iconSize = 20,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor ?? const Color(0xFF0F172A),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
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

  Widget _buildTagPill(String title, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
