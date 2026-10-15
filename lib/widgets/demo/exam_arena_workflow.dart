import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

class ExamArenaWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const ExamArenaWorkflow({super.key, this.onCompleted});

  @override
  State<ExamArenaWorkflow> createState() => _ExamArenaWorkflowState();
}

class _ExamArenaWorkflowState extends State<ExamArenaWorkflow> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _selectedAnswers = {}; // questionIndex -> optionIndex
  bool _isSubmitted = false;

  void _submitTest() {
    setState(() => _isSubmitted = true);
  }

  void _resetTest() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedAnswers.clear();
      _isSubmitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isSubmitted ? _buildScorecardView() : _buildCbtSimulatorView(),
    );
  }

  // --- CBT SIMULATOR VIEW ---
  Widget _buildCbtSimulatorView() {
    final q = sampleCbtQuestions[_currentQuestionIndex];
    final selectedOpt = _selectedAnswers[_currentQuestionIndex];

    return Column(
      key: const ValueKey('cbt_active'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'NEET & JEE AI Mock Arena',
          subtitle: 'Official NTA Computer-Based Test (CBT) simulator with real-time AIR percentile prediction',
          badge: 'CBT TEST SIMULATOR',
          badgeColor: const Color(0xFF0F62FE),
        ),
        const SizedBox(height: 14),

        // Live CBT Header Bar with Timer & Status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2A54),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.amberAccent, size: 18),
              const SizedBox(width: 6),
              const Text(
                '02:44:18 Left',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${q.subject} · ${q.topic}',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Question Palette Indicator Chips
        Row(
          children: List.generate(sampleCbtQuestions.length, (idx) {
            final isAnswered = _selectedAnswers.containsKey(idx);
            final isCurrent = _currentQuestionIndex == idx;

            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: idx < sampleCbtQuestions.length - 1 ? 6 : 0),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? const Color(0xFF0F62FE)
                      : (isAnswered ? const Color(0xFF00B894) : const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Q${idx + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isCurrent || isAnswered ? Colors.white : const Color(0xFF5D7196),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 14),

        // Question Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
              Text(
                'Question ${_currentQuestionIndex + 1} (+4, -1 Mark Scheme):',
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF8A9FB4)),
              ),
              const SizedBox(height: 8),
              Text(
                q.question,
                style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: Color(0xFF1B2A56), height: 1.35),
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 10),

              // Multiple Choice Options
              ...List.generate(q.options.length, (optIdx) {
                final isSelected = selectedOpt == optIdx;
                final optLetter = String.fromCharCode(65 + optIdx); // A, B, C, D

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      setState(() => _selectedAnswers[_currentQuestionIndex] = optIdx);
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFF0F5FF) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF0F62FE) : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF0F62FE) : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: isSelected ? const Color(0xFF0F62FE) : const Color(0xFFCBD5E1)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              optLetter,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: isSelected ? Colors.white : const Color(0xFF5D7196),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              q.options[optIdx],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: const Color(0xFF1B2A56),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Navigation Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _currentQuestionIndex > 0
                    ? () => setState(() => _currentQuestionIndex--)
                    : null,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Previous'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: _currentQuestionIndex < sampleCbtQuestions.length - 1
                    ? () => setState(() => _currentQuestionIndex++)
                    : _submitTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _currentQuestionIndex < sampleCbtQuestions.length - 1 ? const Color(0xFF0F62FE) : const Color(0xFF00B894),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  _currentQuestionIndex < sampleCbtQuestions.length - 1 ? 'Save & Next →' : 'Submit Test 🏆',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- SCORECARD & AIR PREDICTOR VIEW ---
  Widget _buildScorecardView() {
    int correctCount = 0;
    _selectedAnswers.forEach((qIdx, optIdx) {
      if (optIdx == sampleCbtQuestions[qIdx].correctIndex) correctCount++;
    });

    final score = correctCount * 4 - (_selectedAnswers.length - correctCount);

    return Column(
      key: const ValueKey('cbt_scorecard'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trophy AIR Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00B894), Color(0xFF0F62FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00B894).withValues(alpha: 0.3),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'AI PREDICTED ALL-INDIA RANK',
                  style: TextStyle(color: Colors.white, fontSize: 10.5, fontWeight: FontWeight.w800, letterSpacing: 1),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'AIR 3,840',
                style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w900),
              ),
              const Text(
                'Percentile: 99.24% · 99.6% Accuracy in Physics',
                style: TextStyle(color: Colors.white70, fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionHeader(
          title: 'Score Analysis & College Predictor',
          subtitle: 'Based on NTA percentile normalization algorithms',
        ),
        const SizedBox(height: 12),

        _buildScoreMetricRow('Total Score', '$score / 12 Marks', const Color(0xFF0F62FE)),
        _buildScoreMetricRow('Accuracy', '${((correctCount / sampleCbtQuestions.length) * 100).toInt()}%', const Color(0xFF00B894)),
        _buildScoreMetricRow('Eligible Seats', 'Top NITs (Trichy, Surathkal) & IITs qualifier', const Color(0xFF6F2CFF)),

        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _resetTest,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Retake CBT Mock'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onCompleted ?? _resetTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F62FE),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Done & Return', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScoreMetricRow(String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1B2A56))),
          Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    String? badge,
    Color? badgeColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (badge != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: (badgeColor ?? const Color(0xFF0F62FE)).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badge,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: badgeColor ?? const Color(0xFF0F62FE),
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 6),
        ],
        Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: Color(0xFF1B2A56), letterSpacing: -0.3)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF5D7196), height: 1.3)),
      ],
    );
  }
}
