import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/beta_demo_data.dart';
import 'ai_studio_ribbon.dart';
import 'country_flag_circle.dart';

/// ConsulAI Visa Interview Simulator View
class ConsulAiView extends StatefulWidget {
  final VoidCallback? onCompleted;
  final ValueChanged<int>? onRibbonTabChanged;
  final int activeRibbonTab;

  const ConsulAiView({
    super.key,
    this.onCompleted,
    this.onRibbonTabChanged,
    this.activeRibbonTab = 0,
  });

  @override
  State<ConsulAiView> createState() => _ConsulAiViewState();
}

class _ConsulAiViewState extends State<ConsulAiView> with TickerProviderStateMixin {
  int _currentStep = 0; // 0: Select Embassy, 1: Interview Speech Q&A, 2: Scorecard
  int _selectedEmbassyIndex = 0;
  int _currentQuestionIndex = 0;

  // Audio, Animation & Speech (TTS / STT) State
  bool _isSpeaking = false;
  bool _isRecording = false;
  String _selectedAnswer = '';
  final List<String> _recordedAnswers = [];
  Timer? _ttsTimer;
  Timer? _sttTimer;

  late final AnimationController _waveController;
  late final AnimationController _pulseController;
  late final AnimationController _scorecardController;
  late final Animation<double> _scoreAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scorecardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scoreAnimation = CurvedAnimation(
      parent: _scorecardController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _pulseController.dispose();
    _scorecardController.dispose();
    _ttsTimer?.cancel();
    _sttTimer?.cancel();
    super.dispose();
  }

  // --- AUDIO / TTS / STT LOGIC ---
  void _triggerTtsSpeaking(String text) {
    _ttsTimer?.cancel();
    setState(() => _isSpeaking = true);
    SystemSound.play(SystemSoundType.click);

    final durationMs = math.max(2500, math.min(4500, text.length * 50));
    _ttsTimer = Timer(Duration(milliseconds: durationMs), () {
      if (mounted) {
        setState(() => _isSpeaking = false);
      }
    });
  }

  void _toggleSttRecording() {
    SystemSound.play(SystemSoundType.click);
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    _ttsTimer?.cancel();
    setState(() {
      _isSpeaking = false;
      _isRecording = true;
    });

    final q = sampleVisaQuestions[_currentQuestionIndex];
    _sttTimer?.cancel();
    _sttTimer = Timer(const Duration(milliseconds: 2400), () {
      if (mounted && _isRecording) {
        setState(() {
          _isRecording = false;
          if (_selectedAnswer.isEmpty && q.quickAnswers.isNotEmpty) {
            _selectedAnswer = q.quickAnswers.first;
          }
        });
        SystemSound.play(SystemSoundType.click);
      }
    });
  }

  void _stopRecording() {
    _sttTimer?.cancel();
    setState(() => _isRecording = false);
    final q = sampleVisaQuestions[_currentQuestionIndex];
    if (_selectedAnswer.isEmpty && q.quickAnswers.isNotEmpty) {
      setState(() => _selectedAnswer = q.quickAnswers.first);
    }
  }

  void _nextQuestion() {
    SystemSound.play(SystemSoundType.click);
    _ttsTimer?.cancel();
    _sttTimer?.cancel();

    if (_selectedAnswer.isEmpty && sampleVisaQuestions[_currentQuestionIndex].quickAnswers.isNotEmpty) {
      _selectedAnswer = sampleVisaQuestions[_currentQuestionIndex].quickAnswers.first;
    }
    _recordedAnswers.add(_selectedAnswer);
    _selectedAnswer = '';
    _isRecording = false;
    _isSpeaking = false;

    if (_currentQuestionIndex < sampleVisaQuestions.length - 1) {
      setState(() => _currentQuestionIndex++);
      _triggerTtsSpeaking(sampleVisaQuestions[_currentQuestionIndex].officerQuestion);
    } else {
      setState(() => _currentStep = 2); // Go to scorecard
      _scorecardController.forward(from: 0.0);
    }
  }

  void _prevQuestion() {
    SystemSound.play(SystemSoundType.click);
    _ttsTimer?.cancel();
    _sttTimer?.cancel();
    _isRecording = false;
    _isSpeaking = false;

    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _selectedAnswer = _recordedAnswers.isNotEmpty ? _recordedAnswers.removeLast() : '';
      });
      _triggerTtsSpeaking(sampleVisaQuestions[_currentQuestionIndex].officerQuestion);
    } else {
      setState(() => _currentStep = 0); // Return to embassy selection
    }
  }

  void _resetInterview() {
    _ttsTimer?.cancel();
    _sttTimer?.cancel();
    _scorecardController.reset();
    setState(() {
      _currentStep = 0;
      _currentQuestionIndex = 0;
      _isRecording = false;
      _isSpeaking = false;
      _selectedAnswer = '';
      _recordedAnswers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: switch (_currentStep) {
        0 => _buildEmbassySelectionStep(),
        1 => _buildInterviewStep(),
        2 => _buildScorecardStep(),
        _ => _buildEmbassySelectionStep(),
      },
    );
  }

  // =========================================================================
  // TOP BAR (NO BETA STUDIO, NO LIVE DEMO)
  // =========================================================================
  Widget _buildTopBar({VoidCallback? onBack, Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular back button
          InkWell(
            onTap: onBack ??
                () {
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
                Icons.chevron_left_rounded,
                color: Color(0xFF0F172A),
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Logo and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'JoinUni',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.4,
                        ),
                      ),
                      TextSpan(
                        text: 'X',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF6F2CFF),
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'End-to-end interactive workflows from joinunix.com/beta',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // Trailing widget (e.g. Floating Graduation Cap on Result Page)
          if (trailing != null) ...[
            const SizedBox(width: 8),
            trailing,
          ],
        ],
      ),
    );
  }

  Widget _buildWorkflowTabsRibbon() {
    return AiStudioRibbon(
      activeTab: widget.activeRibbonTab,
      onTabSelected: (tab) => widget.onRibbonTabChanged?.call(tab),
    );
  }

  // =========================================================================
  // STEP 0: EMBASSY SELECTION
  // =========================================================================
  Widget _buildEmbassySelectionStep() {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      key: const ValueKey('step0_embassy_selection'),
      children: [
        // Atmospheric artwork anchored at the bottom of the screen behind and around the button
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 360,
          child: IgnorePointer(
            child: Image.asset(
              'assets/images/consulai/consulai_screen_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),

        // Foreground content
        Column(
          children: [
            _buildTopBar(),
            _buildWorkflowTabsRibbon(),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 96 + bottomInset),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeroBanner(),
                        const SizedBox(height: 16),
                        for (int i = 0; i < visaEmbassyOptions.length; i++)
                          _buildCountryCard(visaEmbassyOptions[i], i),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, math.max(16.0, bottomInset + 10)),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFF8FAFC).withValues(alpha: 0.0),
                            const Color(0xFFF8FAFC).withValues(alpha: 0.25),
                            const Color(0xFFF8FAFC).withValues(alpha: 0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: _buildStartButton(),
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

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 420;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isCompact ? 13 : 11,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'ADAPTIVE VOICE AI',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6F2CFF),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                          letterSpacing: -0.8,
                          height: 1.15,
                        ),
                        children: [
                          TextSpan(text: 'ConsulAI Studio™\n'),
                          TextSpan(text: 'Interview '),
                          TextSpan(
                            text: 'Simulator',
                            style: TextStyle(color: Color(0xFF5E43F3)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose target consular jurisdiction & visa class to begin simulation',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: isCompact ? 9 : 9,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 165),
                  child: Image.asset(
                    'assets/images/consulai/consulai_hero_robot.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCountryCard(VisaEmbassyOption opt, int index) {
    final isSelected = _selectedEmbassyIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => setState(() => _selectedEmbassyIndex = index),
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 98,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFF1F6FE) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: isSelected ? const Color(0xFF1D61F2) : const Color(0xFFE2E8F0),
              width: isSelected ? 1.8 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF1D61F2).withValues(alpha: 0.12)
                    : const Color(0xFF0F172A).withValues(alpha: 0.04),
                blurRadius: isSelected ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Smaller landmark illustration positioned neatly to the right without overlapping text
              if (opt.landmarkAsset.isNotEmpty)
                Positioned(
                  right: 48,
                  bottom: 0,
                  height: 64,
                  width: 135,
                  child: Opacity(
                    opacity: 0.85,
                    child: Image.asset(
                      opt.landmarkAsset,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ),

              // Foreground Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    CountryFlagCircle(
                      country: opt.country,
                      width: 44,
                      height: 30,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(width: 12),

                    // Information details - leaves space on right so text never touches landmark or arrow button
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 64),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              opt.country,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              opt.visaType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1D61F2),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded, size: 12.5, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    opt.typicalDuration,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Centered circular action button (admit percent removed per user request)
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? const Color(0xFF1D61F2) : const Color(0xFFE2E8F0),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF1D61F2).withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F62FE), Color(0xFF8A2BE2)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F62FE).withValues(alpha: 0.38),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _currentStep = 1;
              _currentQuestionIndex = 0;
            });
            _triggerTtsSpeaking(sampleVisaQuestions[0].officerQuestion);
          },
          borderRadius: BorderRadius.circular(28),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mic_rounded, color: Colors.white, size: 22),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Start Voice Mock Interview (3 Questions)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // STEP 1: SPEECH PAGE
  // =========================================================================
  Widget _buildInterviewStep() {
    final q = sampleVisaQuestions[_currentQuestionIndex];
    final selectedEmbassy = visaEmbassyOptions[_selectedEmbassyIndex];
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final safeBottomPadding = math.max(16.0, bottomInset + 12.0);

    return Column(
      key: ValueKey('step1_speech_screen_q$_currentQuestionIndex'),
      children: [
        _buildTopBar(onBack: _prevQuestion),
        _buildWorkflowTabsRibbon(),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16, 4, 16, 100 + safeBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCountryHeaderBar(selectedEmbassy),
                    const SizedBox(height: 14),
                    _buildOfficerCard(selectedEmbassy, q),
                    const SizedBox(height: 18),
                    _buildYourAnswerHeader(),
                    const SizedBox(height: 12),
                    _buildVoiceMicSection(),
                    const SizedBox(height: 16),
                    _buildBenchmarkAnswerCards(q),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottomPadding),
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
                  child: _buildBottomActions(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountryHeaderBar(VisaEmbassyOption embassy) {
    return Column(
      children: [
        Row(
          children: [
            CountryFlagCircle(
              country: embassy.country,
              width: 32,
              height: 21,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(width: 10),
            Text(
              embassy.country,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                letterSpacing: -0.4,
              ),
            ),
            const Spacer(),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${sampleVisaQuestions.length}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F62FE),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 5,
            width: double.infinity,
            color: const Color(0xFFE2E8F0),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentQuestionIndex + 1) / sampleVisaQuestions.length,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F62FE),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfficerCard(VisaEmbassyOption embassy, VisaQuestionModel q) {
    final landmarkImg = embassy.landmarkAsset;
    final officerImg = embassy.officerAsset.isNotEmpty ? embassy.officerAsset : 'assets/images/consulai/consulai_officer_us.png';

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEBF5FF), Color(0xFFF3E8FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFBFDBFE), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F62FE).withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 1. Country landmark scenery in the background behind both the officer & question
          if (landmarkImg.isNotEmpty)
            Positioned.fill(
              child: Opacity(
                opacity: 0.38,
                child: Image.asset(
                  landmarkImg,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),

          // 2. Soft white gradient overlay across the landmark to guarantee pristine text contrast
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.90),
                    Colors.white.withValues(alpha: 0.55),
                    Colors.white.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // 3. Consular Officer character standing in foreground on the right
          if (officerImg.isNotEmpty)
            Positioned(
              right: -6,
              bottom: 0,
              top: 18,
              width: 180,
              child: Opacity(
                opacity: 0.98,
                child: Image.asset(
                  officerImg,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),

          // 4. Foreground details (Title, question, and lightbulb icon note)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F62FE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shield_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            embassy.officerTitle,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          Text(
                            embassy.legalIntent,
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => _triggerTtsSpeaking(q.officerQuestion),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF86EFAC)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _waveController,
                              builder: (context, _) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(3, (i) {
                                    final h = _isSpeaking
                                        ? 6.0 + 8.0 * (0.5 + 0.5 * math.sin((_waveController.value * 2 * math.pi) + (i * 1.5)))
                                        : 8.0;
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 1),
                                      width: 2.2,
                                      height: h,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF16A34A),
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    );
                                  }),
                                );
                              },
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _isSpeaking ? 'Speaking' : 'Speak',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FractionallySizedBox(
                  widthFactor: 0.72,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '“${q.officerQuestion}”',
                    style: const TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.4,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.90),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 15,
                        color: Color(0xFFD97706),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Officer note: ${q.officerPersonaNote}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourAnswerHeader() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 14.5, color: Color(0xFF0F172A)),
        children: [
          TextSpan(
            text: 'Your Answer ',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: '(Speak into microphone or select sample response):',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMicSection() {
    return Column(
      children: [
        SizedBox(
          height: 96,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildAnimatedSoundwave(
                  isLeft: true,
                  color: const Color(0xFF38BDF8),
                  activeColor: const Color(0xFF0284C7),
                ),
              ),
              GestureDetector(
                onTap: _toggleSttRecording,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final pulse = _isRecording ? _pulseController.value : 0.0;
                    return Container(
                      width: 76 + (pulse * 8),
                      height: 76 + (pulse * 8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0F62FE).withValues(alpha: 0.12),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: _isRecording
                                ? [const Color(0xFFFF4757), const Color(0xFFFF6B81)]
                                : [const Color(0xFF0F62FE), const Color(0xFF7C3AED)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (_isRecording ? const Color(0xFFFF4757) : const Color(0xFF0F62FE))
                                  .withValues(alpha: 0.38),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: _buildAnimatedSoundwave(
                  isLeft: false,
                  color: const Color(0xFFA855F7),
                  activeColor: const Color(0xFF7E22CE),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _isRecording ? 'Listening... Speak your response clearly now' : 'Tap mic to speak voice answer',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: _isRecording ? FontWeight.w700 : FontWeight.w500,
            color: _isRecording ? const Color(0xFFEF4444) : const Color(0xFF64748B),
          ),
        ),
        if (_selectedAnswer.isNotEmpty && _isRecording == false)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Captured: "$_selectedAnswer"',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF15803D),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAnimatedSoundwave({
    required bool isLeft,
    required Color color,
    required Color activeColor,
  }) {
    const barCount = 10;
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        final t = _waveController.value * 2 * math.pi;
        return Row(
          mainAxisAlignment: isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: List.generate(barCount, (i) {
            final phase = (isLeft ? (barCount - 1 - i) : i) * 0.45;
            final baseH = 8.0 + (i % 4) * 6.0;
            final multiplier = _isRecording ? 1.8 : (_isSpeaking ? 1.4 : 0.6);
            final wave = math.max(6.0, baseH + 16.0 * math.sin(t + phase).abs() * multiplier);

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.2),
              width: 3.2,
              height: math.min(50.0, wave),
              decoration: BoxDecoration(
                color: _isRecording ? activeColor : color.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildBenchmarkAnswerCards(VisaQuestionModel q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Or select benchmark answer response:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        for (int i = 0; i < q.quickAnswers.length; i++)
          _buildSingleBenchmarkCard(
            text: q.quickAnswers[i],
            isRobotic: i == 0,
            isSelected: _selectedAnswer == q.quickAnswers[i],
            onTap: () {
              SystemSound.play(SystemSoundType.click);
              setState(() => _selectedAnswer = q.quickAnswers[i]);
            },
          ),
      ],
    );
  }

  Widget _buildSingleBenchmarkCard({
    required String text,
    required bool isRobotic,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? const Color(0xFF0F62FE) : const Color(0xFFE2E8F0),
              width: isSelected ? 1.8 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF0F62FE).withValues(alpha: 0.08)
                    : const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0F62FE) : const Color(0xFFCBD5E1),
                    width: isSelected ? 6.5 : 1.8,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFDBEAFE), width: 1.2),
                ),
                alignment: Alignment.center,
                child: isRobotic
                    ? const Icon(
                        Icons.precision_manufacturing_rounded,
                        color: Color(0xFF2563EB),
                        size: 28,
                      )
                    : const Icon(
                        Icons.school_rounded,
                        color: Color(0xFF2563EB),
                        size: 28,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      children: [
        SizedBox(
          width: 110,
          height: 52,
          child: OutlinedButton(
            onPressed: _prevQuestion,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
              padding: EdgeInsets.zero,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_rounded, size: 18, color: Color(0xFF0F172A)),
                SizedBox(width: 6),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
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
                onTap: _nextQuestion,
                borderRadius: BorderRadius.circular(26),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit & Next Question',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // STEP 2: RESULT / SCORECARD PAGE (MATCHING THE THIRD SCREENSHOT EXACTLY)
  // =========================================================================
  Widget _buildScorecardStep() {
    final selectedEmbassy = visaEmbassyOptions[_selectedEmbassyIndex];
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final safeBottomPadding = math.max(16.0, bottomInset + 12.0);

    return Column(
      key: const ValueKey('step2_scorecard'),
      children: [
        // Top Bar (with 3D Graduation Cap on right)
        _buildTopBar(
          onBack: _resetInterview,
          trailing: Image.asset(
            'assets/images/consulai/consulai_grad_cap.png',
            height: 44,
            fit: BoxFit.contain,
          ),
        ),

        // Workflow Ribbon
        _buildWorkflowTabsRibbon(),

        // Vertically Scrollable Content Area with bottom sticky buttons
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16, 4, 16, 100 + safeBottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. High Approval Probability Hero Banner
                    _buildResultHeroBanner(selectedEmbassy),
                    const SizedBox(height: 18),

                    // 2. Official Metric Evaluation Header
                    _buildMetricEvaluationHeader(),
                    const SizedBox(height: 12),

                    // 3. Four Color-Coded Metric Cards
                    _buildMetricCard(
                      icon: Icons.school_rounded,
                      iconColor: const Color(0xFF0D9488),
                      iconBg: const Color(0xFFE6F4EA),
                      title: 'Academic Intent & Course Justification',
                      badgeLabel: 'Strong',
                      badgeColor: const Color(0xFF15803D),
                      badgeBg: const Color(0xFFDCFCE7),
                      progressValue: 0.94,
                      progressColor: const Color(0xFF00B894),
                    ),
                    const SizedBox(height: 10),

                    _buildMetricCard(
                      icon: Icons.savings_rounded,
                      iconColor: const Color(0xFF0284C7),
                      iconBg: const Color(0xFFEFF6FF),
                      title: 'Financial Solvency & Liquid Savings',
                      badgeLabel: 'Satisfied',
                      badgeColor: const Color(0xFF0369A1),
                      badgeBg: const Color(0xFFE0F2FE),
                      progressValue: 0.88,
                      progressColor: const Color(0xFF0284C7),
                    ),
                    const SizedBox(height: 10),

                    _buildMetricCard(
                      icon: Icons.home_rounded,
                      iconColor: const Color(0xFF7C3AED),
                      iconBg: const Color(0xFFF3E8FF),
                      title: selectedEmbassy.tiesLabel,
                      badgeLabel: 'Clear Plan',
                      badgeColor: const Color(0xFF6D28D9),
                      badgeBg: const Color(0xFFF3E8FF),
                      progressValue: 0.90,
                      progressColor: const Color(0xFF7C3AED),
                    ),
                    const SizedBox(height: 10),

                    _buildMetricCard(
                      icon: Icons.mic_rounded,
                      iconColor: const Color(0xFFD97706),
                      iconBg: const Color(0xFFFEF3C7),
                      title: 'Delivery Fluency & Hesitation Check',
                      badgeLabel: 'Natural',
                      badgeColor: const Color(0xFFB45309),
                      badgeBg: const Color(0xFFFEF3C7),
                      progressValue: 0.85,
                      progressColor: const Color(0xFFF59E0B),
                    ),
                    const SizedBox(height: 16),

                    // 4. Consular Officer Feedback Summary Card (with 3D document asset)
                    _buildOfficerFeedbackSummaryCard(selectedEmbassy),
                  ],
                ),
              ),

              // Bottom Sticky Action Buttons: [ Re-take Mock ]  [ Done & Return → ]
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottomPadding),
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
                  child: _buildScorecardBottomActions(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultHeroBanner(VisaEmbassyOption embassy) {
    final landmark = embassy.landmarkAsset.isNotEmpty ? embassy.landmarkAsset : embassy.officerAsset;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8FAF4), Color(0xFFE0F2FE), Color(0xFFF0FDF4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00B894).withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background right: Landmark illustration
          if (landmark.isNotEmpty)
            Positioned(
              right: -10,
              bottom: 0,
              top: 10,
              width: 190,
              child: Opacity(
                opacity: 0.95,
                child: Image.asset(
                  landmark,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),

          // Content on left
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: 3D Green Rosette Badge on the left, Header + Giant Score on the right
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/consulai/consulai_verified_badge.png',
                      width: 56,
                      height: 56,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'HIGH APPROVAL PROBABILITY',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF059669),
                              letterSpacing: 1.0,
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _scoreAnimation,
                            builder: (context, _) {
                              final score = (91 * _scoreAnimation.value).toInt();
                              return Text(
                                '$score%',
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF047857),
                                  letterSpacing: -1.0,
                                  height: 1.05,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Country Visa Pill Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.90),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountryFlagCircle(
                        country: embassy.country,
                        width: 20,
                        height: 13,
                        borderRadius: BorderRadius.circular(2),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${embassy.country} (${embassy.visaType})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricEvaluationHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.bar_chart_rounded,
                color: Color(0xFF7C3AED),
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Official Metric Evaluation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        const Text(
          'Granular AI breakdown based on your responses',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String badgeLabel,
    required Color badgeColor,
    required Color badgeBg,
    required double progressValue,
    required Color progressColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bar_chart_rounded, size: 13, color: badgeColor),
                    const SizedBox(width: 3),
                    Text(
                      badgeLabel,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: badgeColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 6,
              width: double.infinity,
              color: const Color(0xFFE2E8F0),
              child: AnimatedBuilder(
                animation: _scoreAnimation,
                builder: (context, _) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressValue * _scoreAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: progressColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficerFeedbackSummaryCard(VisaEmbassyOption embassy) {
    const feedbackText =
        'Your explanation of loan sanction letters from HDFC Credila combined with parents\' liquid mutual funds satisfies standard solvency probing. Always carry original fixed deposit receipts and Form 16/ITR acknowledgments on interview day.';

    return InkWell(
      onTap: () => _triggerTtsSpeaking(feedbackText),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                  const Row(
                    children: [
                      Icon(Icons.push_pin_rounded, size: 16, color: Color(0xFFEF4444)),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Consular Officer Feedback Summary',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    feedbackText,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 76,
              height: 84,
              child: Image.asset(
                'assets/images/consulai/consulai_eval_document.png',
                fit: BoxFit.contain,
                alignment: Alignment.centerRight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScorecardBottomActions() {
    return Row(
      children: [
        SizedBox(
          width: 140,
          height: 52,
          child: OutlinedButton(
            onPressed: _resetInterview,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFBFDBFE), width: 1.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
              padding: EdgeInsets.zero,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.refresh_rounded, size: 18, color: Color(0xFF0F62FE)),
                SizedBox(width: 6),
                Text(
                  'Re-take Mock',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F62FE),
                  ),
                ),
              ],
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Done & Return',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
