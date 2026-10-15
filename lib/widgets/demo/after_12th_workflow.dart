import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

class After12thWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const After12thWorkflow({super.key, this.onCompleted});

  @override
  State<After12thWorkflow> createState() => _After12thWorkflowState();
}

class _After12thWorkflowState extends State<After12thWorkflow> {
  String _selectedStream = 'All Streams';

  List<After12thPathwayModel> get _filteredPathways {
    if (_selectedStream == 'All Streams') return sample12thPathways;
    return sample12thPathways.where((p) => p.stream.toLowerCase() == _selectedStream.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroBanner(),
        const SizedBox(height: 14),

        // Stream Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: ['All Streams', 'Medical', 'Paramedical', 'Engineering'].map((stream) {
              final isSelected = _selectedStream == stream;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(stream),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedStream = stream),
                  selectedColor: const Color(0xFFFF6B6B),
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF1B2A56),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),

        // Pathway Cards
        ..._filteredPathways.map((pathway) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
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
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1F2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(pathway.icon, style: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(pathway.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Color(0xFF1B2A56))),
                          Text('Duration: ${pathway.duration} · ${pathway.stream}', style: const TextStyle(fontSize: 11.5, color: Color(0xFF5D7196))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Cost', style: TextStyle(fontSize: 10.5, color: Color(0xFF8A9FB4))),
                          Text(pathway.totalCost, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF0F62FE))),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Recognition', style: TextStyle(fontSize: 10.5, color: Color(0xFF8A9FB4))),
                          Text(pathway.recognition, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11.5, color: Color(0xFF00B894))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                const Text('Key Career Benefits:', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1B2A56))),
                const SizedBox(height: 6),
                ...pathway.benefits.map((b) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF00B894), size: 14),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(b, style: const TextStyle(fontSize: 11.5, color: Color(0xFF5D7196))),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Consultation requested for ${pathway.title}')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text('View Colleges & Eligibility Criteria', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
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
            color: const Color(0xFFF97316).withValues(alpha: 0.06),
            blurRadius: 12,
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEA580C).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '10+2 CAREER BLUEPRINT',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFEA580C),
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'After 12th Career Guide',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.4,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Compare NMC MBBS Abroad, UK NHS Paramedical & Germany €0 Engineering.',
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
          SizedBox(
            width: 120,
            height: 110,
            child: Image.asset(
              'assets/images/home/box_after_12th.png',
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              errorBuilder: (_, _, _) => const Icon(
                Icons.menu_book_rounded,
                size: 44,
                color: Color(0xFFF97316),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
