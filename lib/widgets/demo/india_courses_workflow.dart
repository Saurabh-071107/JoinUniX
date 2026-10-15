import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';
import '../../data/college_search_data.dart';
import '../../screens/college_detail_screen.dart';

class IndiaCoursesWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const IndiaCoursesWorkflow({super.key, this.onCompleted});

  @override
  State<IndiaCoursesWorkflow> createState() => _IndiaCoursesWorkflowState();
}

class _IndiaCoursesWorkflowState extends State<IndiaCoursesWorkflow> {
  String _selectedCategory = 'All';
  final Set<String> _bookmarkedColleges = {'IIT Madras', 'IIT Bombay'};

  List<NirfCollegeModel> get _filteredColleges {
    if (_selectedCategory == 'All') return sampleNirfColleges;
    return sampleNirfColleges.where((c) => c.category.toLowerCase().contains(_selectedCategory.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Header Container matching screenshot
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFF0F9FF), Color(0xFFF8FAFC), Color(0xFFFFFBEB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1D61E7).withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Subtle background horizon contour
              Positioned(
                right: -20,
                bottom: -20,
                width: 180,
                height: 180,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFED7AA).withValues(alpha: 0.25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'NIRF TOP COLLEGES',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1D61E7),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'All-India NIRF Colleges & Cutoffs',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.4,
                              height: 1.18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Official National Institutional Ranking Framework (NIRF) rankings, JEE/NEET cutoffs & placement data',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Grand Domed Colonial Building Asset
                    SizedBox(
                      width: 136,
                      height: 122,
                      child: Image.asset(
                        'assets/images/dashboard/nirf_banner_building.png',
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.account_balance_rounded,
                          size: 48,
                          color: Color(0xFF1D61E7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Category Filter Pills Row matching screenshot
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: ['All', 'Engineering', 'Medical', 'Management'].map((cat) {
              final isSelected = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => setState(() => _selectedCategory = cat),
                    borderRadius: BorderRadius.circular(20),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.5),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1D61E7) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1D61E7) : const Color(0xFFE2E8F0),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF1D61E7).withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const Icon(Icons.check_rounded, size: 16, color: Colors.white),
                            const SizedBox(width: 5),
                          ],
                          Text(
                            cat,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // NIRF College Cards
        ..._filteredColleges.map((college) {
          final isBookmarked = _bookmarkedColleges.contains(college.name);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.fromLTRB(16, 16, 14, 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final match = allCollegesList.where((c) =>
                      c.shortName.toLowerCase().contains(college.name.toLowerCase()) ||
                      college.name.toLowerCase().contains(c.shortName.toLowerCase())).firstOrNull;
                  if (match != null) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CollegeDetailScreen(college: match)));
                  } else if (college.name.contains('Bombay')) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CollegeDetailScreen(college: allCollegesList.first)));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Opening ${college.name} cutoff and placement analysis'),
                        backgroundColor: const Color(0xFF1D61E7),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Info on left, Organic Arch Campus Photo on right
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badges Row
                              Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1D61E7),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      'NIRF #${college.rank}',
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      college.category,
                                      style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w700, fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                college.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 19,
                                  color: Color(0xFF0F172A),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFF64748B)),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      college.location,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
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
                        const SizedBox(width: 10),
                        // Right Image with Organic Arch & Bookmark
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Warm ambient contour backdrop behind image
                            Positioned(
                              left: -6,
                              bottom: -6,
                              width: 48,
                              height: 48,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFED7AA),
                                ),
                              ),
                            ),
                            // Organic Arch Campus Photo
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(52),
                                bottomLeft: Radius.circular(22),
                                topRight: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                              child: SizedBox(
                                width: 146,
                                height: 100,
                                child: Image.asset(
                                  college.imageAsset,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => Container(
                                    color: const Color(0xFFEFF6FF),
                                    child: const Center(
                                      child: Icon(Icons.account_balance_rounded, size: 36, color: Color(0xFF1D61E7)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Top-right Bookmark Button
                            Positioned(
                              top: -6,
                              right: -4,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isBookmarked) {
                                      _bookmarkedColleges.remove(college.name);
                                    } else {
                                      _bookmarkedColleges.add(college.name);
                                    }
                                  });
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.08),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                    size: 17,
                                    color: isBookmarked ? const Color(0xFF1D61E7) : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Middle Stats Container matching mockup
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          // Left Stat: Cutoff Trend
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.bar_chart_rounded, size: 20, color: Color(0xFFF97316)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Cutoff Trend',
                                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),
                                      ),
                                      Text(
                                        college.cutoff,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, color: Color(0xFF1D61E7)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 28,
                            color: const Color(0xFFE2E8F0),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          // Right Stat: Median CTC Package
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.work_rounded, size: 18, color: Color(0xFF059669)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Median CTC Package',
                                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),
                                      ),
                                      Text(
                                        college.medianPkg,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12.5, color: Color(0xFF059669)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bottom Row: Annual Fees & Brochure Button
                    Row(
                      children: [
                        const Icon(Icons.school_rounded, size: 18, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 12.0, color: Color(0xFF64748B)),
                            children: [
                              const TextSpan(text: 'Annual Fees: '),
                              TextSpan(
                                text: college.annualFee,
                                style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Downloading brochure for ${college.name}'),
                                  backgroundColor: const Color(0xFF1D61E7),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Brochure',
                                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF1D61E7)),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF1D61E7)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
