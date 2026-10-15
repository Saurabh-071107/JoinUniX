import 'package:flutter/material.dart';
import 'workflow_shared_widgets.dart';

class HackathonSprintItem {
  final String title;
  final String organizer;
  final String format;
  final String prizePool;
  final String deadline;
  final String teamSize;
  final String theme;
  final List<String> tags;
  final String imageAsset;
  final String category;

  const HackathonSprintItem({
    required this.title,
    required this.organizer,
    required this.format,
    required this.prizePool,
    required this.deadline,
    required this.teamSize,
    required this.theme,
    required this.tags,
    required this.imageAsset,
    required this.category,
  });
}

const List<HackathonSprintItem> defaultHackathons = [
  HackathonSprintItem(
    title: 'JoinUniX Global AI Agent Sprint 2026',
    organizer: 'JoinUniX & Global Tech Partners',
    format: '48-Hour Virtual Sprint',
    prizePool: '₹5,00,000 + \$25k Cloud Credits',
    deadline: 'April 20, 2026',
    teamSize: '2 to 4 Members',
    theme: 'Autonomous Multi-Agent Systems in Education & FinTech',
    tags: ['AI/ML', 'Education', 'FinTech', 'Multi-Agent Systems'],
    imageAsset: 'assets/images/opportunities/hackathon_ai_robot.png',
    category: 'AI/ML',
  ),
  HackathonSprintItem(
    title: 'CleanTech Campus Innovation Cup',
    organizer: 'TUM Venture Labs & IIT Bombay',
    format: 'Hybrid (Online + Finale in Munich)',
    prizePool: '₹10,000 Seed Grant + Incubation',
    deadline: 'May 12, 2026',
    teamSize: '1 to 5 Members',
    theme: 'Circular Economy, Battery Storage & Bio-Materials',
    tags: ['Sustainability', 'CleanTech', 'Battery Storage', 'Bio-Materials'],
    imageAsset: 'assets/images/opportunities/hackathon_cleantech_globe.png',
    category: 'Sustainability',
  ),
];

/// Dedicated, pixel-perfect Hackathons Screen View.
class HackathonsScreenView extends StatefulWidget {
  final VoidCallback? onCompleted;

  const HackathonsScreenView({super.key, this.onCompleted});

  @override
  State<HackathonsScreenView> createState() => _HackathonsScreenViewState();
}

class _HackathonsScreenViewState extends State<HackathonsScreenView> {
  String _activeFilter = 'All';
  final Set<String> _registeredTeams = {};

  List<HackathonSprintItem> get _filteredHackathons {
    if (_activeFilter == 'All') return defaultHackathons;
    return defaultHackathons
        .where((h) => h.category == _activeFilter || h.tags.contains(_activeFilter))
        .toList();
  }

  void _showRegisterModal(BuildContext context, HackathonSprintItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        String selectedMembers = '3 Members';
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
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.code_rounded, color: Color(0xFF1D61E7), size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Register Hackathon Team',
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF0F172A)),
                            ),
                            Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B))),
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
                            const Icon(Icons.emoji_events_rounded, size: 16, color: Color(0xFF059669)),
                            const SizedBox(width: 6),
                            Text('Prize Pool: ${item.prizePool}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF059669))),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, size: 15, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text('Format: ${item.format} · Deadline: ${item.deadline}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text('Select Team Size:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: Color(0xFF0F172A))),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Solo Developer', '2 Members', '3 Members', '4 Members'].map((count) {
                      final isSelected = selectedMembers == count;
                      return InkWell(
                        onTap: () => setModalState(() => selectedMembers = count),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF1D61E7) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(count, style: TextStyle(fontSize: 12, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Colors.white : const Color(0xFF334155))),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => _registeredTeams.add(item.title));
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Registered "${item.title}" with $selectedMembers!'),
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
                      child: const Text('Confirm Team Registration →', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800)),
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
                      'Hackathons &',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5, height: 1.1),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFEA580C), Color(0xFFF97316)],
                      ).createShader(bounds),
                      child: const Text(
                        'Careers',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5, height: 1.1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Student innovation sprints and verified tech internships',
                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500, color: Color(0xFF64748B), height: 1.35),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 168,
                height: 144,
                child: Image.asset(
                  'assets/images/opportunities/hackathon_hero_launch.png',
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
          options: const ['All', 'AI/ML', 'Web3', 'Sustainability', 'Hardware'],
          selectedOption: _activeFilter,
          onSelected: (val) => setState(() => _activeFilter = val),
          onSettingsTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('All student hackathons and tracks active'),
                backgroundColor: Color(0xFF1D61E7),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const SizedBox(height: 16),

        // Cards List
        ..._filteredHackathons.map((h) {
          final isRegistered = _registeredTeams.contains(h.title);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.fromLTRB(14, 15, 10, 15),
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
                    // Top Badges (Wrap for responsive badge layout)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECFDF5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.emoji_events_rounded, size: 15, color: Color(0xFF059669)),
                              const SizedBox(width: 5),
                              Text(h.prizePool, style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800, color: Color(0xFF059669))),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today_outlined, size: 13, color: Color(0xFFDC2626)),
                              const SizedBox(width: 5),
                              Text('Deadline: ${h.deadline}', style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFFDC2626))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Middle Row: Left Details + Right 3D Artwork
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                h.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.3, height: 1.2),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${h.organizer} · ${h.format}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),
                              ),
                              const SizedBox(height: 8),
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  style: const TextStyle(fontSize: 12.5, color: Color(0xFF475569), height: 1.35),
                                  children: [
                                    const TextSpan(text: 'Theme: ', style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0F172A))),
                                    TextSpan(text: h.theme),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: h.tags.map((tag) => _buildTagChip(tag)).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: 160,
                            height: 148,
                            child: Image.asset(
                              h.imageAsset,
                              fit: BoxFit.contain,
                              alignment: Alignment.centerRight,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFFEFF6FF),
                                child: const Center(
                                  child: Icon(Icons.rocket_launch_rounded, color: Color(0xFF1D61E7), size: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Bottom Row: Team Size + Action Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.people_alt_outlined, size: 24, color: Color(0xFF64748B)),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Team Size', style: TextStyle(fontSize: 11, color: Color(0xFF64748B), height: 1.1)),
                                Text(h.teamSize, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), height: 1.2)),
                              ],
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _showRegisterModal(context, h),
                            borderRadius: BorderRadius.circular(10),
                            child: Ink(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10.5),
                              decoration: BoxDecoration(
                                color: isRegistered ? const Color(0xFF059669) : const Color(0xFF1D61E7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isRegistered ? 'Registered' : 'Register Team',
                                    style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    isRegistered ? Icons.check_circle_rounded : Icons.arrow_forward_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildTagChip(String tag) {
    Color bg;
    Color fg;
    switch (tag.toLowerCase()) {
      case 'ai/ml':
        bg = const Color(0xFFEFF6FF);
        fg = const Color(0xFF2563EB);
        break;
      case 'education':
        bg = const Color(0xFFF3E8FF);
        fg = const Color(0xFF7C3AED);
        break;
      case 'fintech':
        bg = const Color(0xFFFFFBEB);
        fg = const Color(0xFFD97706);
        break;
      case 'sustainability':
      case 'cleantech':
        bg = const Color(0xFFECFDF5);
        fg = const Color(0xFF059669);
        break;
      case 'battery storage':
        bg = const Color(0xFFFFF7ED);
        fg = const Color(0xFFEA580C);
        break;
      case 'bio-materials':
        bg = const Color(0xFFF5F3FF);
        fg = const Color(0xFF6D28D9);
        break;
      default:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(tag, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
