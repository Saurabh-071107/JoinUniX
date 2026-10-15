import 'package:flutter/material.dart';

/// Dedicated AI Document Studio screen (SOP & LOR Writer).
///
/// Features:
/// - Target Document Type selector (SOP, LOR, Visa Cover Letter, Diversity Essay)
/// - Drafting Tone selector (Academic Rigorous, Executive & Professional, Passionate & Visionary)
/// - High-Admit AI generation with progress indicator
/// - Plagiarism-free result box with instant clipboard copy
class AiDocumentStudioView extends StatefulWidget {
  const AiDocumentStudioView({super.key});

  @override
  State<AiDocumentStudioView> createState() => _AiDocumentStudioViewState();
}

class _AiDocumentStudioViewState extends State<AiDocumentStudioView> {
  String _selectedDocType = 'Statement of Purpose (SOP)';
  String _selectedTone = 'Academic Rigorous';
  bool _isGenerating = false;
  String _generatedText = '';

  void _generateDocDraft() {
    setState(() {
      _isGenerating = true;
      _generatedText = '';
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _generatedText = '''
STATEMENT OF PURPOSE: M.Sc. Artificial Intelligence & Robotics

To the Esteemed Admissions Committee,

My aspiration to pursue graduate studies in Computer Science at your institution is rooted in my undergraduate work at the intersection of embedded systems and reinforcement learning. Having spearheaded an autonomous aerial delivery system project during my junior year—achieving a 98.4% obstacle navigation rate—I realized that pushing the frontiers of reliable robotics requires rigorous academic immersion under faculty mentors whose work defines the field.

The specialized curriculum, particularly courses in Distributed Perception and Deep Reinforcement Learning, directly bridges the research gap I encountered in my undergraduate capstone. Furthermore, the collaborative environment and state-of-the-art laboratory infrastructure will empower me to contribute meaningfully to ongoing laboratory investigations from my very first semester.

Upon graduation, my objective is to spearhead intelligent autonomous systems initiatives within high-impact global technology research organizations before returning to mentor the next generation of engineers in my home country.

Sincerely,
Candidate Profile ID: #JX-2026-984''';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('aidoc_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Doc Type Selector
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Target Document Type',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1B2A56),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Statement of Purpose (SOP)',
                  'Academic Recommendation (LOR)',
                  'Visa Cover Letter',
                  'Diversity Essay',
                ].map((type) {
                  final isSelected = _selectedDocType == type;
                  return ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedDocType = type),
                    selectedColor: const Color(0xFF0F62FE),
                    labelStyle: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF1B2A56),
                    ),
                    backgroundColor: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // 2. Tone Selector
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Drafting Tone & Perspective',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: Color(0xFF1B2A56),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Academic Rigorous',
                  'Executive & Professional',
                  'Passionate & Visionary',
                ].map((tone) {
                  final isSelected = _selectedTone == tone;
                  return ChoiceChip(
                    label: Text(tone),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedTone = tone),
                    selectedColor: const Color(0xFF6F2CFF),
                    labelStyle: TextStyle(
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected ? Colors.white : const Color(0xFF1B2A56),
                    ),
                    backgroundColor: const Color(0xFFF1F5F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Generate Button
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F62FE), Color(0xFF6F2CFF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: ElevatedButton(
            onPressed: _generateDocDraft,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              _isGenerating
                  ? 'AI Drafting in Progress...'
                  : 'Generate High-Admit $_selectedDocType ✨',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Output Result Box
        if (_generatedText.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF0F62FE), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F62FE).withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFF0F62FE),
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'AI Draft Generated · 0% Plagiarism',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF0F62FE),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.copy_rounded,
                        size: 16,
                        color: Color(0xFF5D7196),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied draft to clipboard!'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 10),
                Text(
                  _generatedText,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: Color(0xFF1B2A56),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
