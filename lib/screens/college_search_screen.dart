import 'package:flutter/material.dart';
import '../core/responsive.dart';
import '../data/college_search_data.dart';
import '../widgets/colleges/college_card.dart';
import '../widgets/colleges/college_detail_bottom_sheet.dart';
import '../widgets/colleges/college_filter_modal.dart';
import '../widgets/colleges/college_filter_ribbon.dart';
import '../widgets/colleges/college_results_meta_bar.dart';
import '../widgets/colleges/college_search_header.dart';

class CollegeSearchScreen extends StatefulWidget {
  final String location;
  final VoidCallback? onBack;

  const CollegeSearchScreen({
    super.key,
    this.location = 'India',
    this.onBack,
  });

  @override
  State<CollegeSearchScreen> createState() => _CollegeSearchScreenState();
}

class _CollegeSearchScreenState extends State<CollegeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All Colleges';
  String _activeSort = 'NIRF Ranking';
  bool _isOnlyShortlisted = false;
  CollegeFilterCriteria _filterCriteria = const CollegeFilterCriteria();

  late List<CollegeItem> _colleges;

  @override
  void initState() {
    super.initState();
    _colleges = List.from(allCollegesList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  int get _savedCount => _colleges.where((c) => c.isFavorite).length;

  List<CollegeItem> get _filteredAndSortedColleges {
    var list = _colleges.where((college) {
      // 1. Search Query Filter
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.trim().toLowerCase();
        final matches = college.shortName.toLowerCase().contains(q) ||
            college.fullName.toLowerCase().contains(q) ||
            college.location.toLowerCase().contains(q) ||
            college.state.toLowerCase().contains(q) ||
            college.examAccepted.toLowerCase().contains(q) ||
            college.tags.any((t) => t.toLowerCase().contains(q));
        if (!matches) return false;
      }

      // 2. Shortlisted Filter
      if (_isOnlyShortlisted && !college.isFavorite) {
        return false;
      }

      // 3. Category Filter
      if (_selectedCategory == 'Premier IITs & NITs') {
        if (!college.tags.contains('IIT') && !college.tags.contains('NIT')) return false;
      } else if (_selectedCategory == 'Research & Science') {
        if (!college.tags.contains('Research') && !college.tags.contains('Science')) return false;
      } else if (_selectedCategory == 'Top Private') {
        if (!college.tags.contains('Private')) return false;
      } else if (_selectedCategory == 'High Placements') {
        if (!college.tags.contains('High Placements') &&
            (int.tryParse(college.placementRate.replaceAll('%', '')) ?? 0) < 92) {
          return false;
        }
      } else if (_selectedCategory == 'Study Abroad') {
        if (!college.tags.contains('Study Abroad') && !college.tags.contains('Global')) return false;
      }

      // 4. Modal Criteria Filters
      if (_filterCriteria.instituteType != 'All') {
        if (!college.type.toLowerCase().contains(_filterCriteria.instituteType.toLowerCase().split(' ')[0])) {
          return false;
        }
      }
      if (_filterCriteria.state != 'All') {
        if (college.state.toLowerCase() != _filterCriteria.state.toLowerCase()) {
          return false;
        }
      }
      if (_filterCriteria.minRating > 0.0) {
        if (college.rating < _filterCriteria.minRating) {
          return false;
        }
      }

      return true;
    }).toList();

    // 5. Sorting
    switch (_activeSort) {
      case 'NIRF Ranking':
        list.sort((a, b) {
          final rankA = int.tryParse(a.nirfRank.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          final rankB = int.tryParse(b.nirfRank.replaceAll(RegExp(r'[^0-9]'), '')) ?? 999;
          return rankA.compareTo(rankB);
        });
        break;
      case 'Highest Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Placement Rate':
        list.sort((a, b) {
          final pA = int.tryParse(a.placementRate.replaceAll('%', '')) ?? 0;
          final pB = int.tryParse(b.placementRate.replaceAll('%', '')) ?? 0;
          return pB.compareTo(pA);
        });
        break;
      case 'Lowest Fees':
        list.sort((a, b) => a.avgFees.compareTo(b.avgFees));
        break;
      case 'Average Package':
        list.sort((a, b) => b.avgPackage.compareTo(a.avgPackage));
        break;
    }

    return list;
  }

  void _openDetailSheet(CollegeItem college) {
    CollegeDetailScreen.push(
      context,
      college: college,
      onFavoriteToggle: (isFav) => _toggleFavorite(college, isFav),
      onApply: () => _showSnackBar('Opening application portal for ${college.shortName}'),
    );
  }

  void _toggleFavorite(CollegeItem college, bool isFav) {
    setState(() {
      final index = _colleges.indexWhere((c) => c.id == college.id);
      if (index != -1) {
        _colleges[index] = _colleges[index].copyWith(isFavorite: isFav);
      }
    });
    _showSnackBar(isFav ? 'Shortlisted ${college.shortName}' : 'Removed from shortlists');
  }

  @override
  Widget build(BuildContext context) {
    final colleges = _filteredAndSortedColleges;
    final isTabletOrWide = context.screenWidth >= 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // 1. Sleek Search Header (Navigation, Search Box, Shortlist Counter)
                SliverToBoxAdapter(
                  child: CollegeSearchHeader(
                    onBack: () {
                      if (widget.onBack != null) {
                        widget.onBack!();
                      } else {
                        Navigator.of(context).maybePop();
                      }
                    },
                    location: widget.location.isNotEmpty ? widget.location : 'India',
                    onLocationTap: () => _showSnackBar('Selected Region: ${widget.location}'),
                    savedCount: _savedCount,
                    onSavedTap: () {
                      setState(() => _isOnlyShortlisted = !_isOnlyShortlisted);
                      _showSnackBar(_isOnlyShortlisted
                          ? 'Showing shortlisted colleges'
                          : 'Showing all colleges');
                    },
                    searchController: _searchController,
                    onSearchChanged: (val) => setState(() => _searchQuery = val),
                    onClearSearch: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                    onMicTap: () => _showSnackBar('Voice search activated...'),
                  ),
                ),

                // 2. Modern Category Ribbon + Filter Drawer Trigger
                SliverToBoxAdapter(
                  child: CollegeFilterRibbon(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (cat) => setState(() => _selectedCategory = cat),
                    activeFilterCount: _filterCriteria.activeCount,
                    onFilterDrawerTap: () {
                      CollegeFilterModal.show(
                        context,
                        initialCriteria: _filterCriteria,
                        onApply: (newCriteria) => setState(() => _filterCriteria = newCriteria),
                      );
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 6)),

                // 3. Results Count, Sort By Sheet & Saved Toggle
                SliverToBoxAdapter(
                  child: CollegeResultsMetaBar(
                    count: colleges.length,
                    activeSort: _activeSort,
                    onSortChanged: (sort) {
                      setState(() => _activeSort = sort);
                      _showSnackBar('Sorted by $sort');
                    },
                    isOnlyShortlisted: _isOnlyShortlisted,
                    onToggleShortlisted: () {
                      setState(() => _isOnlyShortlisted = !_isOnlyShortlisted);
                    },
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 4)),

                // 4. College Cards Listing (Responsive List or Responsive Grid on Tablet)
                if (colleges.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEF2FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.search_off_rounded,
                              size: 32,
                              color: Color(0xFF4F46E5),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No matching colleges found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _searchQuery.isNotEmpty
                                ? 'No colleges matched "$_searchQuery". Try searching for another campus or state.'
                                : 'No colleges matched your active filters.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                                _selectedCategory = 'All Colleges';
                                _isOnlyShortlisted = false;
                                _filterCriteria = const CollegeFilterCriteria();
                              });
                            },
                            icon: const Icon(Icons.refresh_rounded, size: 16),
                            label: const Text('Reset All Filters'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (isTabletOrWide)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final college = colleges[index];
                          return CollegeCard(
                            college: college,
                            onTap: () => _openDetailSheet(college),
                            onFavoriteToggle: (isFav) => _toggleFavorite(college, isFav),
                          );
                        },
                        childCount: colleges.length,
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final college = colleges[index];
                        return CollegeCard(
                          college: college,
                          onTap: () => _openDetailSheet(college),
                          onFavoriteToggle: (isFav) => _toggleFavorite(college, isFav),
                        );
                      },
                      childCount: colleges.length,
                    ),
                  ),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
