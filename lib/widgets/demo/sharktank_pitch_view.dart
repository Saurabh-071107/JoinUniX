import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

/// Dedicated Campus SharkTank screen.
///
/// Features:
/// - Campus Seed Pool Banner (₹25,00,000)
/// - Top Competing Student Startups
/// - Category pills, founder info, college, and summary
/// - Ask amount and valuation cards
/// - Real-time pledge voting with SnackBar feedback
class SharkTankPitchView extends StatefulWidget {
  final List<SharkTankPitchModel> initialPitches;

  const SharkTankPitchView({
    super.key,
    this.initialPitches = sampleSharkTankPitches,
  });

  @override
  State<SharkTankPitchView> createState() => _SharkTankPitchViewState();
}

class _SharkTankPitchViewState extends State<SharkTankPitchView> {
  late List<SharkTankPitchModel> _pitches;
  final Set<String> _votedTitles = {};

  @override
  void initState() {
    super.initState();
    _pitches = List.from(widget.initialPitches);
  }

  void _votePitch(int index) {
    final pitch = _pitches[index];
    if (_votedTitles.contains(pitch.title)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have already pledged votes to ${pitch.title}!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _votedTitles.add(pitch.title);
      _pitches[index] = SharkTankPitchModel(
        title: pitch.title,
        founder: pitch.founder,
        college: pitch.college,
        category: pitch.category,
        askAmount: pitch.askAmount,
        valuation: pitch.valuation,
        votes: pitch.votes + 1,
        summary: pitch.summary,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pledged 1 Investor Vote to ${pitch.title}!'),
        backgroundColor: const Color(0xFF0F62FE),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('sharktank_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Live Seed Pool Banner
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E2A54), Color(0xFF0F62FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F62FE).withValues(alpha: 0.25),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Campus Seed Pool: ₹25,00,000',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Angel judges evaluate the top 3 student startups on the live leaderboard weekly.',
                      style: TextStyle(color: Color(0xFFCCD9EB), fontSize: 11.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Section header
        const Text(
          'Top Competing Student Startups',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1B2A56),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Vote for high-potential ventures to advance them into the VC Pitch Arena',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF5D7196)),
        ),
        const SizedBox(height: 12),

        ...List.generate(_pitches.length, (idx) {
          final pitch = _pitches[idx];
          final hasVoted = _votedTitles.contains(pitch.title);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
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
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        pitch.category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F62FE),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${pitch.college} · ${pitch.founder}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A9FB4),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  pitch.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Color(0xFF1B2A56),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pitch.summary,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF5D7196),
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Ask', style: TextStyle(fontSize: 10.5, color: Color(0xFF8A9FB4))),
                          Text(
                            pitch.askAmount,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF1B2A56)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Valuation', style: TextStyle(fontSize: 10.5, color: Color(0xFF8A9FB4))),
                          Text(
                            pitch.valuation,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0xFF6F2CFF)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () => _votePitch(idx),
                        icon: Icon(hasVoted ? Icons.favorite_rounded : Icons.thumb_up_alt_rounded, size: 14),
                        label: Text('${pitch.votes} ${hasVoted ? "Voted" : "Vote"}'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasVoted ? const Color(0xFF00B894) : const Color(0xFF0F62FE),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
