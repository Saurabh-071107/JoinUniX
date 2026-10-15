import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

/// Dedicated Courses & Intakes Screen View.
class CoursesIntakesView extends StatefulWidget {
  final VoidCallback? onCompleted;

  const CoursesIntakesView({super.key, this.onCompleted});

  @override
  State<CoursesIntakesView> createState() => _CoursesIntakesViewState();
}

class _CoursesIntakesViewState extends State<CoursesIntakesView> {
  String _selectedDegree = 'All';
  String _searchQuery = '';
  final Set<String> _bookmarkedCourses = {};

  List<CourseIntakeModel> get _filteredCourses {
    return sampleCoursesList.where((c) {
      final matchesDegree = _selectedDegree == 'All' ||
          c.degree.toLowerCase().contains(_selectedDegree.toLowerCase());
      final matchesQuery = _searchQuery.isEmpty ||
          c.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.university.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesDegree && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search and Filter Bar
        Row(
          children: [
            Expanded(
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Color(0xFF64748B), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => _searchQuery = val.trim()),
                        style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A)),
                        decoration: const InputDecoration(
                          hintText: 'Search universities, courses or keywords...',
                          hintStyle: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Filter presets: Fall 2026, STEM Designated, Tuition < \$60k'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                customBorder: const CircleBorder(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.tune_rounded, size: 19, color: Color(0xFF0F172A)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Degree Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: ['All', 'Masters', 'Bachelors', 'MBA', 'PhD', 'More'].map((deg) {
              final isMore = deg == 'More';
              final isSelected = _selectedDegree == deg;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (!isMore) setState(() => _selectedDegree = deg);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0F62FE) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0F62FE) : const Color(0xFFCBD5E1),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0F62FE).withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            deg,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                              color: isSelected ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          if (isMore) ...[
                            const SizedBox(width: 3),
                            const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF0F172A)),
                          ],
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

        if (_filteredCourses.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(Icons.search_off_rounded, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text(
                    'No courses found matching your criteria',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          )
        else
          ..._filteredCourses.map((course) {
            final isBookmarked = _bookmarkedCourses.contains(course.title);

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 3.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: course.brandColor,
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildUniversityLogoBadge(course),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.university,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 13.5,
                                        color: Color(0xFF0F172A),
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      course.location,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64748B),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F2FE),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  course.degree,
                                  style: const TextStyle(
                                    color: Color(0xFF0284C7),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isBookmarked) {
                                      _bookmarkedCourses.remove(course.title);
                                    } else {
                                      _bookmarkedCourses.add(course.title);
                                    }
                                  });
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Icon(
                                    isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                    size: 21,
                                    color: isBookmarked ? const Color(0xFF0F62FE) : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            course.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15.5,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Duration: ${course.duration} · Annual Tuition: ${course.tuitionAnnual}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE2E8F0)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.calendar_today_rounded, size: 13, color: Color(0xFF64748B)),
                                                SizedBox(width: 4),
                                                Text('Fall 2026 Intake', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              course.deadlineFall,
                                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF2563EB)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 32,
                                        width: 1,
                                        color: const Color(0xFFE2E8F0),
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Icon(Icons.bar_chart_rounded, size: 15, color: Color(0xFF64748B)),
                                                SizedBox(width: 3),
                                                Text('Minimum GPA', style: TextStyle(fontSize: 10.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              course.minGpa,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 86,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.10),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(course.campusPhoto, fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.description_outlined, size: 14, color: Color(0xFF64748B)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  course.minIelts,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 11.5, color: Color(0xFF475569), fontWeight: FontWeight.w600),
                                ),
                              ),
                              Material(
                                color: const Color(0xFF0F62FE),
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Shortlisted ${course.title}!'),
                                        backgroundColor: const Color(0xFF0F62FE),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Shortlist Course', style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700)),
                                        SizedBox(width: 4),
                                        Icon(Icons.chevron_right_rounded, color: Colors.white, size: 16),
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
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildUniversityLogoBadge(CourseIntakeModel course) {
    if (course.university.contains('Massachusetts') || course.university.contains('MIT')) {
      return Container(
        width: 38,
        height: 38,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFFFEE2E2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFA31F34).withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: const Color(0xFFA31F34)),
            Container(width: 4, color: const Color(0xFFA31F34)),
            Container(width: 4, color: const Color(0xFFA31F34)),
          ],
        ),
      );
    } else if (course.university.contains('Munich') || course.university.contains('TUM')) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: const Color(0xFF0065BD), borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: const Text('TUM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
      );
    } else if (course.university.contains('Stanford')) {
      return Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: const Color(0xFF8C1515), borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: const Text('S', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'serif')),
      );
    }

    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: course.brandColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: course.brandColor.withValues(alpha: 0.25)),
      ),
      alignment: Alignment.center,
      child: Text(
        course.logoInitials,
        style: TextStyle(color: course.brandColor, fontSize: 12, fontWeight: FontWeight.w800),
      ),
    );
  }
}
