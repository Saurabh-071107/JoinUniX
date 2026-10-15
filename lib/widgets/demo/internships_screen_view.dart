import 'package:flutter/material.dart';
import 'workflow_shared_widgets.dart';

class TechInternshipItem {
  final String title;
  final String organization;
  final String location;
  final String stipend;
  final String duration;
  final String workType;
  final List<String> requiredSkills;
  final String imageAsset;
  final String category;

  const TechInternshipItem({
    required this.title,
    required this.organization,
    required this.location,
    required this.stipend,
    required this.duration,
    required this.workType,
    required this.requiredSkills,
    required this.imageAsset,
    required this.category,
  });
}

const List<TechInternshipItem> defaultInternships = [
  TechInternshipItem(
    title: 'AI & Data Science Research Intern',
    organization: 'JoinUniX AI Labs',
    location: 'Remote / Bangalore Hub',
    stipend: '₹35,000 / month',
    duration: '3 Months',
    workType: 'Remote',
    requiredSkills: ['Python', 'PyTorch / TensorFlow', 'LLM Engineering', 'Git'],
    imageAsset: 'assets/images/opportunities/internship_ai_robot.png',
    category: 'AI/ML',
  ),
  TechInternshipItem(
    title: 'Mobile App Developer Intern (Flutter)',
    organization: 'EdTech Venture Labs',
    location: 'Remote / Hyderabad',
    stipend: '₹30,000 / month',
    duration: '3 to 6 Months',
    workType: 'Remote',
    requiredSkills: ['Flutter / Dart', 'REST APIs', 'State Management', 'UI/UX'],
    imageAsset: 'assets/images/opportunities/internship_flutter_mobile.png',
    category: 'Mobile Dev',
  ),
  TechInternshipItem(
    title: 'Product Design Intern',
    organization: 'Studio Nova',
    location: 'Mumbai',
    stipend: '₹18,000 / month',
    duration: '3 Months',
    workType: 'Hybrid',
    requiredSkills: ['Figma', 'Prototyping', 'Design Systems'],
    imageAsset: 'assets/images/opportunities/internship_design_tools.png',
    category: 'Design',
  ),
  TechInternshipItem(
    title: 'Web3 & Smart Contract Intern',
    organization: 'ZeroX Protocol',
    location: 'Bangalore Hub',
    stipend: '₹40,000 / month',
    duration: '6 Months',
    workType: 'In-Office',
    requiredSkills: ['Solidity', 'Rust', 'EVM Security', 'Ethers.js'],
    imageAsset: 'assets/images/opportunities/internship_ai_robot.png',
    category: 'Web3',
  ),
];

/// Dedicated, pixel-perfect Internships Screen View.
class InternshipsScreenView extends StatefulWidget {
  final VoidCallback? onCompleted;

  const InternshipsScreenView({super.key, this.onCompleted});

  @override
  State<InternshipsScreenView> createState() => _InternshipsScreenViewState();
}

class _InternshipsScreenViewState extends State<InternshipsScreenView> {
  String _activeFilter = 'All';
  final Set<String> _appliedInternships = {};

  List<TechInternshipItem> get _filteredInternships {
    if (_activeFilter == 'All') return defaultInternships;
    return defaultInternships
        .where((job) => job.category == _activeFilter || job.requiredSkills.contains(_activeFilter))
        .toList();
  }

  void _showApplyModal(BuildContext context, TechInternshipItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        bool autoResume = true;
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.verified_user_rounded, color: Color(0xFF059669), size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('1-Click Internship Application', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF0F172A))),
                            Text('${item.title} · ${item.organization}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: const Icon(Icons.close_rounded, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.payments_rounded, size: 16, color: Color(0xFF059669)),
                            const SizedBox(width: 6),
                            Text('Stipend: ${item.stipend}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF059669))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.place_rounded, size: 15, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text('${item.location} · ${item.duration} · ${item.workType}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Checkbox(
                        value: autoResume,
                        activeColor: const Color(0xFF1D61E7),
                        onChanged: (val) => setModalState(() => autoResume = val ?? true),
                      ),
                      const Expanded(
                        child: Text(
                          'Attach verified JoinUniX dynamic profile & projects portfolio',
                          style: TextStyle(fontSize: 12, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _appliedInternships.add(item.title));
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Profile sent to recruiters at ${item.organization}!'),
                            backgroundColor: const Color(0xFF059669),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1D61E7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text('Submit Application with Profile →', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 10, 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF7ED), Color(0xFFEFF6FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1D61E7).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CAREERS & INNOVATION',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800, letterSpacing: 0.8, color: Color(0xFF2563EB)),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Find Your Next',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5, height: 1.1),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFEA580C), Color(0xFFF97316)],
                      ).createShader(bounds),
                      child: const Text(
                        'Opportunity',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5, height: 1.1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Build skills, gain experience, and launch your career',
                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Color(0xFF64748B), height: 1.35),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 154,
                height: 136,
                child: Image.asset(
                  'assets/images/opportunities/internship_hero_launch.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  errorBuilder: (_, _, _) => const SizedBox(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Filter Pills Row
        WorkflowFilterPills(
          options: const ['All', 'AI/ML', 'Mobile Dev', 'Web3', 'Design'],
          selectedOption: _activeFilter,
          onSelected: (val) => setState(() => _activeFilter = val),
          onSettingsTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('All verified internships & stipends active'),
                backgroundColor: Color(0xFF1D61E7),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Cards List
        ..._filteredInternships.map((job) {
          final isApplied = _appliedInternships.contains(job.title);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(14),
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
            child: Stack(
              children: [
                const CardVerticalAccents(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Title + Stipend Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            job.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            job.stipend,
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF059669)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Middle Row: Left Details + Right 3D Artwork
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.organization,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14.5, color: Color(0xFF1D61E7), fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${job.location} · ${job.duration} · ${job.workType}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Color(0xFF64748B), height: 1.3),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: job.requiredSkills.map((s) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F5F9),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Text(
                                      s,
                                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: 140,
                            height: 144,
                            child: Image.asset(
                              job.imageAsset,
                              fit: BoxFit.contain,
                              alignment: Alignment.centerRight,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFFEFF6FF),
                                child: const Center(
                                  child: Icon(Icons.work_rounded, color: Color(0xFF1D61E7), size: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Bottom Action Button: Apply with Profile
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () => _showApplyModal(context, job),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isApplied ? const Color(0xFF059669) : const Color(0xFF1D61E7),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isApplied ? 'Application Submitted' : 'Apply with Profile',
                              style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(width: 8),
                            Icon(isApplied ? Icons.check_circle_rounded : Icons.arrow_forward_rounded, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
