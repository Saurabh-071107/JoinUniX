import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/features.dart';
import '../../screens/feature_screen.dart';
import 'ai_studio_ribbon.dart';

/// Redesigned UniQuest Ivy Scorecard & Audit workflow matching the inspiration design.
class UniQuestWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final VoidCallback? onSwitchToConsulAi;
  final VoidCallback? onSwitchToUniFinance;
  final ValueChanged<int>? onRibbonTabChanged;
  final int activeRibbonTab;

  const UniQuestWorkflow({
    super.key,
    this.onCompleted,
    this.onSwitchToConsulAi,
    this.onSwitchToUniFinance,
    this.onRibbonTabChanged,
    this.activeRibbonTab = 1,
  });

  @override
  State<UniQuestWorkflow> createState() => _UniQuestWorkflowState();
}

class _UniQuestWorkflowState extends State<UniQuestWorkflow>
    with SingleTickerProviderStateMixin {
  // Input form state
  int _selectedStreamIndex = 0;
  double _gpa = 8.6;
  int _greScore = 322;
  double _ieltsScore = 7.5;
  int _researchPapers = 2;
  int _workExpYears = 1;
  bool _hasCalculated = false;

  // Ambient background animation
  late AnimationController _ambientController;
  late Animation<double> _ambientAnimation;

  final List<String> _academicStreams = const [
    'Computer Science & AI',
    'Data Science & Analytics',
    'Global MBA & Finance',
    'Mechanical & Robotics',
    'Public Health & BioTech',
  ];

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _ambientAnimation = CurvedAnimation(
      parent: _ambientController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _ambientController.dispose();
    super.dispose();
  }

  void _calculateOdds() {
    setState(() => _hasCalculated = true);
  }

  void _resetToInput() {
    setState(() => _hasCalculated = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: _hasCalculated
              ? _buildResultOddsView()
              : _buildInputScorecardView(),
        ),
      ),
    );
  }

  // =========================================================================
  // INPUT VIEW (MATCHING THE INSPIRATION IMAGE EXACTLY)
  // =========================================================================
  Widget _buildInputScorecardView() {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final safeBottomPadding = math.max(16.0, bottomInset + 12.0);

    return Stack(
      key: const ValueKey('uniquest_input_view'),
      children: [
        // 1. Ambient Animated Background (eliminates plain white/empty feel)
        _buildAmbientBackground(),

        // 2. Campus Hero Illustration at Upper-Right
        Positioned(
          top: -6,
          right: -10,
          width: 240,
          height: 155,
          child: IgnorePointer(
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.0, 0.25, 1.0],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                'assets/images/uniquest/uniquest_campus_hero.png',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
          ),
        ),

        // 3. Main Content Area
        Column(
          children: [
            // Top Bar
            _buildTopBar(),

            // Workflow Ribbon Tabs (ConsulAI Mock | UniQuest Audit | UniFinance Loan)
            _buildWorkflowTabsRibbon(),

            // Vertically Scrollable Content Area with bottom sticky action
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 88 + safeBottomPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title & Subtitle Header
                        _buildMainHeader(),
                        const SizedBox(height: 16),

                        // Card 1: Target Academic Stream
                        _buildTargetAcademicStreamCard(),
                        const SizedBox(height: 12),

                        // Card 2: Undergraduate GPA / CGPA Slider
                        _buildGpaSliderCard(),
                        const SizedBox(height: 12),

                        // Card 3: GRE General Score Slider
                        _buildGreSliderCard(),
                        const SizedBox(height: 12),

                        // Card 4: IELTS Band Score Slider
                        _buildIeltsSliderCard(),
                        const SizedBox(height: 12),

                        // Card 5: Side-by-side Counters (Research Papers & Work Exp)
                        _buildSideBySideCounters(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Sticky Bottom Gradient Button: [ Calculate My Admission Odds ]
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, safeBottomPadding),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF8FAFC).withValues(alpha: 0.0),
                            const Color(0xFFF8FAFC).withValues(alpha: 0.95),
                            const Color(0xFFF8FAFC),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.45, 1.0],
                        ),
                      ),
                      child: _buildCalculateOddsButton(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =========================================================================
  // ATMOSPHERIC BACKGROUND & AMBIENT ANIMATIONS
  // =========================================================================
  Widget _buildAmbientBackground() {
    return AnimatedBuilder(
      animation: _ambientAnimation,
      builder: (context, _) {
        final anim = _ambientAnimation.value;
        return Stack(
          children: [
            // Soft atmospheric sky gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEAF3FF),
                      Color(0xFFF2F7FE),
                      Color(0xFFF8FAFC),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.28, 1.0],
                  ),
                ),
              ),
            ),

            // Top-left glowing cyan-blue orb
            Positioned(
              top: -60,
              left: -50,
              width: 240,
              height: 240,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF38BDF8).withValues(alpha: 0.18 + 0.06 * anim),
                      const Color(0xFF38BDF8).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // Mid-right lavender-purple ambient glow
            Positioned(
              top: 220 + 20 * anim,
              right: -80,
              width: 260,
              height: 260,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF818CF8).withValues(alpha: 0.12 + 0.05 * (1 - anim)),
                      const Color(0xFF818CF8).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom-left subtle emerald glow
            Positioned(
              bottom: 100,
              left: -70,
              width: 220,
              height: 220,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF34D399).withValues(alpha: 0.08 + 0.04 * anim),
                      const Color(0xFF34D399).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================================
  // TOP BAR
  // =========================================================================
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular back button
          InkWell(
            onTap: () {
              if (widget.onCompleted != null) {
                widget.onCompleted!();
              } else if (Navigator.canPop(context)) {
                Navigator.maybePop(context);
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF0F172A),
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Title & Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'UniQuest',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Admission Odds',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // WORKFLOW TABS RIBBON (WITH SMOOTH IN-PLACE SWITCHING)
  // =========================================================================
  Widget _buildWorkflowTabsRibbon() {
    return AiStudioRibbon(
      activeTab: widget.activeRibbonTab,
      onTabSelected: (tab) {
        if (tab == 0) {
          if (widget.onSwitchToConsulAi != null) {
            widget.onSwitchToConsulAi!();
          } else if (widget.onRibbonTabChanged != null) {
            widget.onRibbonTabChanged!(0);
          } else {
            openFeature(context, Feature.consulAi);
          }
        } else if (tab == 2) {
          if (widget.onSwitchToUniFinance != null) {
            widget.onSwitchToUniFinance!();
          } else if (widget.onRibbonTabChanged != null) {
            widget.onRibbonTabChanged!(2);
          } else {
            openFeature(context, Feature.uniFinance);
          }
        } else if (widget.onRibbonTabChanged != null) {
          widget.onRibbonTabChanged!(tab);
        }
      },
    );
  }

  // =========================================================================
  // MAIN HEADER TITLE & SUBTITLE
  // =========================================================================
  Widget _buildMainHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
              letterSpacing: -0.6,
              height: 1.15,
            ),
            children: [
              TextSpan(text: 'UniQuest™ Ivy Scorecard\n'),
              TextSpan(text: '& Audit'),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Calculate your global university admission odds and unlock 1,000 XP milestones',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // CARD 1: TARGET ACADEMIC STREAM
  // =========================================================================
  Widget _buildTargetAcademicStreamCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Target Academic Stream',
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Row 1: Computer Science & AI | Data Science & Analytics
          Row(
            children: [
              Expanded(
                child: _buildStreamPill(
                  index: 0,
                  label: _academicStreams[0],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStreamPill(
                  index: 1,
                  label: _academicStreams[1],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: Global MBA & Finance | Mechanical & Robotics
          Row(
            children: [
              Expanded(
                child: _buildStreamPill(
                  index: 2,
                  label: _academicStreams[2],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildStreamPill(
                  index: 3,
                  label: _academicStreams[3],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 3: Public Health & BioTech (half width, left aligned)
          Row(
            children: [
              Expanded(
                child: _buildStreamPill(
                  index: 4,
                  label: _academicStreams[4],
                ),
              ),
              const SizedBox(width: 10),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreamPill({required int index, required String label}) {
    final isSelected = _selectedStreamIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedStreamIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0066FF) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066FF) : const Color(0xFFE2E8F0),
            width: isSelected ? 1.4 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF0066FF).withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF1E293B),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // CARD 2: GPA SLIDER (BLUE)
  // =========================================================================
  Widget _buildGpaSliderCard() {
    final usEquivalent = (3.0 + (_gpa - 6.0) * 0.25).clamp(3.0, 4.0).toStringAsFixed(2);

    return _buildCustomSliderCard(
      title: 'Undergraduate GPA / CGPA',
      subtitle: 'Equivalent to $usEquivalent / 4.0 US Scale',
      badgeText: '${_gpa.toStringAsFixed(1)} / 10.0',
      badgeBgColor: const Color(0xFFEFF6FF),
      badgeBorderColor: const Color(0xFFDBEAFE),
      badgeTextColor: const Color(0xFF1D4ED8),
      value: _gpa,
      min: 0.0,
      max: 10.0,
      divisions: 100,
      activeColor: const Color(0xFF0066FF),
      minLabel: '0',
      maxLabel: '10',
      tickCount: 5,
      onChanged: (v) => setState(() => _gpa = (v * 10).round() / 10),
    );
  }

  // =========================================================================
  // CARD 3: GRE SLIDER (PURPLE)
  // =========================================================================
  Widget _buildGreSliderCard() {
    final quant = 140 + ((_greScore * 0.49).toInt()).clamp(130, 170);
    final verbal = 130 + ((_greScore * 0.47).toInt()).clamp(130, 170);

    return _buildCustomSliderCard(
      title: 'GRE General Score',
      subtitle: 'Quant ~$quant · Verbal ~$verbal',
      badgeText: '$_greScore / 340',
      badgeBgColor: const Color(0xFFF3E8FF),
      badgeBorderColor: const Color(0xFFE9D5FF),
      badgeTextColor: const Color(0xFF7C3AED),
      value: _greScore.toDouble(),
      min: 0.0,
      max: 340.0,
      divisions: 340,
      activeColor: const Color(0xFF7C3AED),
      minLabel: '0',
      maxLabel: '340',
      tickCount: 5,
      onChanged: (v) => setState(() => _greScore = v.toInt()),
    );
  }

  // =========================================================================
  // CARD 4: IELTS SLIDER (TEAL)
  // =========================================================================
  Widget _buildIeltsSliderCard() {
    return _buildCustomSliderCard(
      title: 'IELTS Band Score',
      subtitle: 'Meets minimum threshold for top 50 global universities',
      badgeText: '${_ieltsScore.toStringAsFixed(1)} Band',
      badgeBgColor: const Color(0xFFCCFBF1),
      badgeBorderColor: const Color(0xFF99F6E4),
      badgeTextColor: const Color(0xFF0D9488),
      value: _ieltsScore,
      min: 0.0,
      max: 9.0,
      divisions: 18,
      activeColor: const Color(0xFF0D9488),
      minLabel: '0',
      maxLabel: '9',
      tickCount: 5,
      onChanged: (v) => setState(() => _ieltsScore = (v * 2).round() / 2),
    );
  }

  // =========================================================================
  // REUSABLE CUSTOM SLIDER CARD (ZERO REPEATED CODE - LAZY & DRY)
  // =========================================================================
  Widget _buildCustomSliderCard({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeBorderColor,
    required Color badgeTextColor,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color activeColor,
    required String minLabel,
    required String maxLabel,
    required int tickCount,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title & Subtitle on left, Badge on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Pill Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: badgeBorderColor),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: badgeTextColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Custom Slider with discrete dot ticks on track
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              activeTrackColor: activeColor,
              inactiveTrackColor: const Color(0xFFE2E8F0),
              thumbColor: activeColor,
              overlayColor: activeColor.withValues(alpha: 0.15),
              thumbShape: _GlowRoundSliderThumbShape(
                enabledThumbRadius: 9,
                glowColor: activeColor.withValues(alpha: 0.3),
              ),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),

          // Min and Max Labels underneath
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  minLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                Text(
                  maxLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // CARD 5: SIDE-BY-SIDE COUNTERS (RESEARCH PAPERS & WORK EXP)
  // =========================================================================
  Widget _buildSideBySideCounters() {
    return Row(
      children: [
        // Left Counter Card: Research Papers
        Expanded(
          child: _buildCounterCard(
            title: 'Research Papers',
            subtitle: 'Published / In Progress',
            count: _researchPapers,
            onDecrement: () {
              if (_researchPapers > 0) {
                setState(() => _researchPapers--);
              }
            },
            onIncrement: () => setState(() => _researchPapers++),
          ),
        ),
        const SizedBox(width: 12),

        // Right Counter Card: Years Work Exp.
        Expanded(
          child: _buildCounterCard(
            title: 'Years Work Exp.',
            subtitle: 'Full-time (if any)',
            count: _workExpYears,
            onDecrement: () {
              if (_workExpYears > 0) {
                setState(() => _workExpYears--);
              }
            },
            onIncrement: () => setState(() => _workExpYears++),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterCard({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),

          // Right Counter Pill: [ - ]  N  [ + ]
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: onDecrement,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(10)),
                  child: Container(
                    width: 32,
                    alignment: Alignment.center,
                    child: const Icon(Icons.remove_rounded, size: 16, color: Color(0xFF475569)),
                  ),
                ),
                Container(
                  width: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border.symmetric(
                      vertical: BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onIncrement,
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(10)),
                  child: Container(
                    width: 32,
                    alignment: Alignment.center,
                    child: const Icon(Icons.add_rounded, size: 16, color: Color(0xFF475569)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // STICKY BOTTOM BUTTON: [ CALCULATE MY ADMISSION ODDS ]
  // =========================================================================
  Widget _buildCalculateOddsButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F62FE), Color(0xFF8A2BE2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F62FE).withValues(alpha: 0.36),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _calculateOdds,
          borderRadius: BorderRadius.circular(26),
          child: const Center(
            child: Text(
              'Calculate My Admission Odds',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // RESULT VIEW: ADMISSION ODDS BREAKDOWN & UNIVERSITY BUCKETS
  // =========================================================================
  Widget _buildResultOddsView() {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final safeBottomPadding = math.max(16.0, bottomInset + 12.0);

    // Compute Ivy Odds Score
    final ivyScore = (48 +
            (_gpa * 3.2) +
            ((_greScore / 340) * 16) +
            ((_ieltsScore / 9.0) * 6) +
            (_researchPapers * 2.5) +
            (_workExpYears * 1.5))
        .clamp(40, 96)
        .toInt();

    final streamName = _academicStreams[_selectedStreamIndex];

    return Stack(
      key: const ValueKey('uniquest_result_view'),
      children: [
        _buildAmbientBackground(),

        Column(
          children: [
            _buildTopBar(),
            _buildWorkflowTabsRibbon(),

            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 88 + safeBottomPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Ivy Scorecard
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1B64F8), Color(0xFF6F2CFF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF1B64F8).withValues(alpha: 0.35),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.22),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      'IVY TIER CANDIDATE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.check_circle_rounded, size: 12, color: Colors.white),
                                        SizedBox(width: 4),
                                        Text(
                                          'Verified Audit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '$ivyScore%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 52,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1.2,
                                      height: 1.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Global Admit Probability',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Based on your $streamName profile · GPA $_gpa · GRE $_greScore · IELTS $_ieltsScore',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.88),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Section 2: University Category Buckets
                        const Text(
                          'Admissions Probability Buckets',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Targeted university matches based on 15,000+ historical admissions',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Ambitious Bucket
                        _buildBucketCard(
                          title: 'Ambitious (Reach) · 45-60% Odds',
                          badge: 'High Competition',
                          badgeColor: const Color(0xFFEF4444),
                          badgeBg: const Color(0xFFFEE2E2),
                          universities: const [
                            'Stanford University (USA)',
                            'Massachusetts Institute of Technology (MIT)',
                            'Carnegie Mellon University (CMU)',
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Target Bucket
                        _buildBucketCard(
                          title: 'Target (Solid Match) · 75-85% Odds',
                          badge: 'Strong Admit Odds',
                          badgeColor: const Color(0xFF15803D),
                          badgeBg: const Color(0xFFDCFCE7),
                          universities: const [
                            'Georgia Institute of Technology',
                            'Purdue University West Lafayette',
                            'Technical University of Munich (TUM)',
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Safe Bucket
                        _buildBucketCard(
                          title: 'Safe (Backup) · 92%+ Odds',
                          badge: 'Near Guaranteed',
                          badgeColor: const Color(0xFF0284C7),
                          badgeBg: const Color(0xFFE0F2FE),
                          universities: const [
                            'University of Texas at Dallas',
                            'Arizona State University (ASU)',
                            'University of Alberta (Canada)',
                          ],
                        ),
                        const SizedBox(height: 18),

                        // 1,000 XP Action Plan Card
                        _buildXpActionPlanCard(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Bottom Sticky Buttons: [ Adjust Profile ] [ Done & Return ]
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, safeBottomPadding),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF8FAFC).withValues(alpha: 0.0),
                            const Color(0xFFF8FAFC).withValues(alpha: 0.96),
                            const Color(0xFFF8FAFC),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 0.45, 1.0],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: OutlinedButton(
                                onPressed: _resetToInput,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Color(0xFFBFDBFE), width: 1.4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                ),
                                child: const Text(
                                  'Adjust Profile',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F62FE),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF0F62FE), Color(0xFF8A2BE2)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F62FE).withValues(alpha: 0.35),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (widget.onCompleted != null) {
                                      widget.onCompleted!();
                                    } else if (Navigator.canPop(context)) {
                                      Navigator.maybePop(context);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(26),
                                  child: const Center(
                                    child: Text(
                                      'Done & Return →',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBucketCard({
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeBg,
    required List<String> universities,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: badgeColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...universities.map(
            (uni) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.school_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      uni,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXpActionPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFA7F3D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.military_tech_rounded, color: Color(0xFF059669), size: 20),
              SizedBox(width: 6),
              Text(
                '1,000 XP Action Plan to Boost Odds',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF065F46),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildXpTaskItem('+350 XP', 'Publish or upload conference pre-print in arXiv / IEEE', true),
          _buildXpTaskItem('+250 XP', 'Draft quantified Statement of Purpose targeting research labs', false),
          _buildXpTaskItem('+200 XP', 'Target 325+ benchmark threshold in upcoming GRE retake', false),
          _buildXpTaskItem('+200 XP', 'Acquire academic LOR from department head / HOD', false),
        ],
      ),
    );
  }

  Widget _buildXpTaskItem(String xp, String task, bool isDone) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF10B981) : const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              xp,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: isDone ? Colors.white : const Color(0xFF475569),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              task,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDone ? const Color(0xFF065F46) : const Color(0xFF334155),
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Glow Thumb for Sliders
class _GlowRoundSliderThumbShape extends RoundSliderThumbShape {
  final Color glowColor;

  const _GlowRoundSliderThumbShape({
    super.enabledThumbRadius = 10.0,
    required this.glowColor,
  });

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Outer glow
    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(center, enabledThumbRadius + 3, glowPaint);

    // Inner thumb
    super.paint(
      context,
      center,
      activationAnimation: activationAnimation,
      enableAnimation: enableAnimation,
      isDiscrete: isDiscrete,
      labelPainter: labelPainter,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      textDirection: textDirection,
      value: value,
      textScaleFactor: textScaleFactor,
      sizeWithOverflow: sizeWithOverflow,
    );
  }
}
