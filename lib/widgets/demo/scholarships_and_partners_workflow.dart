import 'package:flutter/material.dart';
import 'workflow_shared_widgets.dart';

/// Data model representing a Global Scholarship opportunity.
class ScholarshipItem {
  final String title;
  final String provider;
  final String type;
  final String country;
  final String deadline;
  final String amount;
  final String imageAsset;
  final String gpaRequirement;
  final String essayPrompt;

  const ScholarshipItem({
    required this.title,
    required this.provider,
    required this.type,
    required this.country,
    required this.deadline,
    required this.amount,
    required this.imageAsset,
    required this.gpaRequirement,
    required this.essayPrompt,
  });
}

/// Pixel-perfect Global Scholarships screen matching the provided design.
///
/// Features:
/// - Eyebrow badge: `SCHOLARSHIPS` in soft blue pill
/// - High-impact title: `Global Scholarships` & descriptive subtitle
/// - Interactive filter pills row (`All`, `Merit-based`, `Full funding`, and filter icon)
/// - Rich cards with:
///   - Multiple architectural vertical lines in the background stack (more than one!)
///   - Large campus landmark artwork on the right with smooth gradient fade
///   - Type badge (`Merit-based` / `Full funding`), country pill & deadline display
///   - Award box with document icon & bold blue funding amount
///   - `View Eligibility & Application Essays >` action button
/// - Interactive bottom sheet modal for essay prompts & eligibility criteria
/// - Zero emojis and 100% responsive layout across all screen sizes
class ScholarshipsAndPartnersWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const ScholarshipsAndPartnersWorkflow({super.key, this.onCompleted});

  @override
  State<ScholarshipsAndPartnersWorkflow> createState() =>
      _ScholarshipsAndPartnersWorkflowState();
}

class _ScholarshipsAndPartnersWorkflowState
    extends State<ScholarshipsAndPartnersWorkflow> {
  String _activeFilter = 'All';

  static const List<ScholarshipItem> _allScholarships = [
    ScholarshipItem(
      title: 'Dean’s International Merit Fellowship',
      provider: 'Global University Consortium',
      type: 'Merit-based',
      country: 'United States',
      deadline: '15 Apr 2026',
      amount: 'Up to \$25,000 tuition waiver',
      imageAsset: 'assets/images/abroad/scholarship_us_mit.png',
      gpaRequirement: 'Minimum 3.6 / 4.0 or equivalent 85%+',
      essayPrompt:
          '500-word statement on academic leadership and proposed contribution to campus diversity.',
    ),
    ScholarshipItem(
      title: 'DAAD Helmut-Schmidt Masters Grant',
      provider: 'German Academic Exchange Service',
      type: 'Full funding',
      country: 'Germany',
      deadline: '31 Jul 2026',
      amount: '100% tuition + €934/month living allowance',
      imageAsset: 'assets/images/abroad/scholarship_germany_reichstag.png',
      gpaRequirement: 'Top 15% of graduating class, German or English B2/C1',
      essayPrompt:
          'Motivation letter outlining future socio-political impact in your home country.',
    ),
    ScholarshipItem(
      title: 'British Council Great Scholarship',
      provider: 'UK Government & Universities',
      type: 'Merit-based',
      country: 'United Kingdom',
      deadline: '30 May 2026',
      amount: '£10,000 tuition credit',
      imageAsset: 'assets/images/abroad/scholarship_uk_oxford.png',
      gpaRequirement: 'First-class undergraduate degree or GPA 3.5+',
      essayPrompt:
          '750-word essay explaining how UK postgraduate study aligns with your global career goals.',
    ),
  ];

  List<ScholarshipItem> get _filteredScholarships {
    if (_activeFilter == 'All') return _allScholarships;
    return _allScholarships
        .where((s) => s.type.toLowerCase() == _activeFilter.toLowerCase())
        .toList();
  }

  void _showEssayModal(BuildContext context, ScholarshipItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Modal drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Color(0xFF1D61E7),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15.5,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          '${item.provider} · ${item.country}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Award highlight
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFBBF7D0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.verified_rounded,
                        size: 16, color: Color(0xFF16A34A)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Benefit: ${item.amount}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF15803D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Eligibility Criteria
              const Text(
                'Eligibility Criteria:',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildChecklistRow(item.gpaRequirement),
                    const SizedBox(height: 6),
                    _buildChecklistRow(
                        'English Proficiency (IELTS 7.0+ or TOEFL iBT 100+)'),
                    const SizedBox(height: 6),
                    _buildChecklistRow(
                        'Verified admission letter from an accredited university'),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Essay Prompt
              const Text(
                'Application Essay Prompt:',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFFDE68A)),
                ),
                child: Text(
                  item.essayPrompt,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF92400E),
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Action button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Draft started for ${item.title}! Document templates and guidelines sent to your email.'),
                        backgroundColor: const Color(0xFF1D61E7),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D61E7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Start Application Draft',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChecklistRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_rounded,
            size: 15, color: Color(0xFF16A34A)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header Section matching screenshot
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Eyebrow badge: SCHOLARSHIPS
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'SCHOLARSHIPS',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: Color(0xFF2563EB),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title: Global Scholarships
            const Text(
              'Global Scholarships',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
                letterSpacing: -0.5,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 6),

            // Subtitle
            const Text(
              'Explore merit awards and university funding worldwide',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
                height: 1.35,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 2. Filter Pills Row matching screenshot
        Row(
          children: [
            _buildFilterPill('All', isSelected: _activeFilter == 'All'),
            const SizedBox(width: 8),
            _buildFilterPill('Merit-based',
                isSelected: _activeFilter == 'Merit-based'),
            const SizedBox(width: 8),
            _buildFilterPill('Full funding',
                isSelected: _activeFilter == 'Full funding'),
            const Spacer(),

            // Filter icon button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Filter presets: All countries & intakes active'),
                      backgroundColor: Color(0xFF1D61E7),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.tune_rounded,
                    size: 18,
                    color: Color(0xFF334155),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 3. Scholarship Cards List
        ..._filteredScholarships.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
                  color: const Color(0xFF1D61E7).withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Multiple architectural vertical background lines
                  const CardVerticalAccents(),

                  // Right-aligned campus photo with smooth gradient fade
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    width: 175,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Colors.white,
                            Colors.white,
                          ],
                          stops: [0.0, 0.40, 1.0],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        item.imageAsset,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFF1F5F9),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.apartment_rounded,
                              size: 40,
                              color: Color(0xFFCBD5E1),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Foreground content column
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Badges & Deadline
                        Row(
                          children: [
                            // Type badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.type,
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF059669),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),

                            // Country badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.country,
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF334155),
                                ),
                              ),
                            ),
                            const Spacer(),

                            // Deadline display with calendar icon
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 14,
                                  color: Color(0xFF64748B),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Deadline',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF64748B),
                                        height: 1.1,
                                      ),
                                    ),
                                    Text(
                                      item.deadline,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFE11D48),
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Title: Dean’s International Merit Fellowship
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 240),
                          child: Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),

                        // Provider subtitle
                        Text(
                          item.provider,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Funding Award Container
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.description_outlined,
                                  color: Color(0xFF1D61E7),
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item.amount,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1D61E7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Action button: View Eligibility & Application Essays >
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 250),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _showEssayModal(context, item),
                              borderRadius: BorderRadius.circular(10),
                              child: Ink(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 9.5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1D61E7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'View Eligibility & Application Essays',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
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
        }),
      ],
    );
  }

  Widget _buildFilterPill(String title, {required bool isSelected}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _activeFilter = title),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 22 : 16, vertical: 8.5),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1D61E7) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF1D61E7)
                  : const Color(0xFFE2E8F0),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF1D61E7).withValues(alpha: 0.22),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF334155),
            ),
          ),
        ),
      ),
    );
  }
}
