import 'package:flutter/material.dart';
import '../../data/opportunities_data.dart';

class RecommendedOpportunitiesSection extends StatefulWidget {
  final VoidCallback? onViewAll;
  final ValueChanged<RecommendedOpportunityItem>? onItemTap;

  const RecommendedOpportunitiesSection({
    super.key,
    this.onViewAll,
    this.onItemTap,
  });

  @override
  State<RecommendedOpportunitiesSection> createState() =>
      _RecommendedOpportunitiesSectionState();
}

class _RecommendedOpportunitiesSectionState
    extends State<RecommendedOpportunitiesSection> {
  late List<RecommendedOpportunityItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(recommendedOpportunitiesList);
  }

  void _toggleBookmark(int index) {
    setState(() {
      final current = _items[index];
      _items[index] = current.copyWith(isBookmarked: !current.isBookmarked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for You',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
              ),
              InkWell(
                onTap: widget.onViewAll,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFF4F46E5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Vertical List of Opportunity Cards
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = _items[index];
            return _buildOpportunityCard(item, index);
          },
        ),
      ],
    );
  }

  Widget _buildOpportunityCard(RecommendedOpportunityItem item, int index) {
    return GestureDetector(
      onTap: () => widget.onItemTap?.call(item),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Logo (Enlarged)
            Container(
              width: 58,
              height: 58,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Image.asset(
                item.logoPath,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.business_rounded,
                  color: Color(0xFF6366F1),
                  size: 30,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Opportunity Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Bookmark row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            height: 1.2,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleBookmark(index),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            item.isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 24,
                            color: item.isBookmarked
                                ? const Color(0xFF6366F1)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),

                  // Subtitle (Org • Program)
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Metadata Badges with Horizontal Scroll
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildMetaTag(
                          icon: Icons.place_outlined,
                          label: item.location,
                        ),
                        const SizedBox(width: 6),
                        _buildMetaTag(
                          icon: Icons.work_outline_rounded,
                          label: item.type,
                        ),
                        const SizedBox(width: 6),
                        _buildMetaTag(
                          icon: Icons.calendar_today_outlined,
                          label: item.duration,
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
    );
  }

  Widget _buildMetaTag({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4.5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.5,
            color: const Color(0xFF64748B),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
