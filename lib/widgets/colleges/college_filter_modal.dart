import 'package:flutter/material.dart';

class CollegeFilterCriteria {
  final String instituteType;
  final String feeRange;
  final double minRating;
  final String state;

  const CollegeFilterCriteria({
    this.instituteType = 'All',
    this.feeRange = 'All',
    this.minRating = 0.0,
    this.state = 'All',
  });

  bool get isDefault =>
      instituteType == 'All' && feeRange == 'All' && minRating == 0.0 && state == 'All';

  int get activeCount {
    int count = 0;
    if (instituteType != 'All') count++;
    if (feeRange != 'All') count++;
    if (minRating > 0) count++;
    if (state != 'All') count++;
    return count;
  }

  CollegeFilterCriteria copyWith({
    String? instituteType,
    String? feeRange,
    double? minRating,
    String? state,
  }) {
    return CollegeFilterCriteria(
      instituteType: instituteType ?? this.instituteType,
      feeRange: feeRange ?? this.feeRange,
      minRating: minRating ?? this.minRating,
      state: state ?? this.state,
    );
  }
}

class CollegeFilterModal extends StatefulWidget {
  final CollegeFilterCriteria initialCriteria;
  final ValueChanged<CollegeFilterCriteria> onApply;

  const CollegeFilterModal({
    super.key,
    required this.initialCriteria,
    required this.onApply,
  });

  static void show(
    BuildContext context, {
    required CollegeFilterCriteria initialCriteria,
    required ValueChanged<CollegeFilterCriteria> onApply,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CollegeFilterModal(
        initialCriteria: initialCriteria,
        onApply: onApply,
      ),
    );
  }

  @override
  State<CollegeFilterModal> createState() => _CollegeFilterModalState();
}

class _CollegeFilterModalState extends State<CollegeFilterModal> {
  late CollegeFilterCriteria _criteria;

  @override
  void initState() {
    super.initState();
    _criteria = widget.initialCriteria;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Colleges',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _criteria = const CollegeFilterCriteria();
                    });
                  },
                  child: const Text(
                    'Reset All',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Scrollable filter categories
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSectionHeader('Institute Type'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['All', 'Government / INI', 'Private Deemed', 'International'].map((t) {
                    final isSelected = _criteria.instituteType == t;
                    return _buildChoiceChip(
                      label: t,
                      isSelected: isSelected,
                      onTap: () => setState(() => _criteria = _criteria.copyWith(instituteType: t)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                _buildSectionHeader('Annual Fee Range'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['All', '< ₹1 Lakh', '₹1L - ₹3 Lakh', '₹3L - ₹6 Lakh', '> ₹6 Lakh'].map((f) {
                    final isSelected = _criteria.feeRange == f;
                    return _buildChoiceChip(
                      label: f,
                      isSelected: isSelected,
                      onTap: () => setState(() => _criteria = _criteria.copyWith(feeRange: f)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                _buildSectionHeader('Minimum Rating'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [0.0, 4.5, 4.7, 4.8].map((r) {
                    final isSelected = _criteria.minRating == r;
                    final label = r == 0.0 ? 'Any Rating' : '$r+ Stars';
                    return _buildChoiceChip(
                      label: label,
                      isSelected: isSelected,
                      onTap: () => setState(() => _criteria = _criteria.copyWith(minRating: r)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                _buildSectionHeader('State / Region'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['All', 'Delhi', 'Maharashtra', 'Karnataka', 'Rajasthan', 'Tamil Nadu', 'International'].map((s) {
                    final isSelected = _criteria.state == s;
                    return _buildChoiceChip(
                      label: s,
                      isSelected: isSelected,
                      onTap: () => setState(() => _criteria = _criteria.copyWith(state: s)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Apply Footer Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_criteria);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                _criteria.activeCount > 0
                    ? 'Apply ${_criteria.activeCount} Filters'
                    : 'Show All Results',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0F172A),
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF475569),
          ),
        ),
      ),
    );
  }
}
