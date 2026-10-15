import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

/// Dedicated 4-Way University Comparison Matrix screen.
///
/// Features:
/// - Horizontal scrollable comparison cards
/// - Side-by-side QS Global Rank, Tuition, Living Cost, Work Permit (PSWV), Acceptance Rate, IELTS
/// - Direct shortlist action button with SnackBar feedback
class UniversityCompareView extends StatelessWidget {
  final List<CompareUniversityModel> universities;

  const UniversityCompareView({
    super.key,
    this.universities = compareUniverseList,
  });

  Widget _buildComparisonRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.5,
              color: Color(0xFF8A9FB4),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('compare_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: universities.map((uni) {
              return Container(
                width: 240,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(uni.flag, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            uni.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13.5,
                              color: Color(0xFF1B2A56),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      uni.location,
                      style: const TextStyle(fontSize: 11, color: Color(0xFF5D7196)),
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    const SizedBox(height: 10),

                    _buildComparisonRow('QS Global Rank', uni.qsRank, const Color(0xFF0F62FE)),
                    _buildComparisonRow('Annual Tuition', uni.annualTuition, const Color(0xFF1B2A56)),
                    _buildComparisonRow('Living Cost', uni.livingExpense, const Color(0xFF5D7196)),
                    _buildComparisonRow('Work Permit (PSWV)', uni.postStudyWork, const Color(0xFF00B894)),
                    _buildComparisonRow('Acceptance Rate', uni.acceptanceRate, const Color(0xFF6F2CFF)),
                    _buildComparisonRow('Minimum English', uni.minIelts, const Color(0xFFFFA502)),

                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Added ${uni.name} to application shortlist'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Shortlist',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
