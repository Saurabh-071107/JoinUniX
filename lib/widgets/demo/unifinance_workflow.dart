import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/features.dart';
import '../../screens/feature_screen.dart';
import 'ai_studio_ribbon.dart';

/// Redesigned UniFinance Loan & EMI Studio workflow matching the inspiration design.
class UniFinanceWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;
  final VoidCallback? onSwitchToConsulAi;
  final VoidCallback? onSwitchToUniQuest;
  final ValueChanged<int>? onRibbonTabChanged;
  final int activeRibbonTab;

  const UniFinanceWorkflow({
    super.key,
    this.onCompleted,
    this.onSwitchToConsulAi,
    this.onSwitchToUniQuest,
    this.onRibbonTabChanged,
    this.activeRibbonTab = 2,
  });

  @override
  State<UniFinanceWorkflow> createState() => _UniFinanceWorkflowState();
}

class _UniFinanceWorkflowState extends State<UniFinanceWorkflow>
    with SingleTickerProviderStateMixin {
  // Financial State
  double _loanAmountLakhs = 45.0; // ₹45 Lakhs
  int _tenureYears = 10; // 10 Years
  double _interestRate = 10.5; // 10.5% p.a.
  bool _isNonCollateral = true;

  // Ambient Animation Controller
  late AnimationController _ambientController;
  late Animation<double> _ambientAnimation;

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

  // Live Loan Computations
  double get _principal => _loanAmountLakhs * 100000;

  double get _monthlyEmi {
    final r = (_interestRate / 12) / 100;
    final n = _tenureYears * 12;
    if (r == 0) return _principal / n;
    return (_principal * r * math.pow(1 + r, n)) / (math.pow(1 + r, n) - 1);
  }

  double get _totalRepayment => _monthlyEmi * (_tenureYears * 12);
  double get _totalInterest => _totalRepayment - _principal;

  String _formatIndianCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    String lastThree = str.substring(str.length - 3);
    String remaining = str.substring(0, str.length - 3);
    final buffer = StringBuffer();
    while (remaining.length > 2) {
      buffer.write(',${remaining.substring(remaining.length - 2)}');
      remaining = remaining.substring(0, remaining.length - 2);
    }
    return '$remaining$buffer,$lastThree';
  }

  void _showPreApprovalSuccess() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.check_circle_rounded, color: Color(0xFF15803D), size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instant Pre-Approval Issued! 🎉',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pre-qualified for up to ₹65.0 Lakhs non-collateral loan',
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
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    _buildModalDetailRow('Sanction Amount', '₹${_loanAmountLakhs.toStringAsFixed(0)} Lakhs'),
                    const Divider(height: 18, color: Color(0xFFE2E8F0)),
                    _buildModalDetailRow('Monthly EMI', '₹${_formatIndianCurrency(_monthlyEmi.round())} / mo'),
                    const Divider(height: 18, color: Color(0xFFE2E8F0)),
                    _buildModalDetailRow('Preferred Lenders', 'HDFC Credila & Avanse'),
                    const Divider(height: 18, color: Color(0xFFE2E8F0)),
                    _buildModalDetailRow('Turnaround Time', '48 Hours to Official Letter'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Download Pre-Sanction Letter 📄',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModalDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final safeBottomPadding = math.max(16.0, bottomInset + 12.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Stack(
          key: const ValueKey('unifinance_studio_view'),
          children: [
            // 1. Ambient Background Glows
            _buildAmbientBackground(),

            // 2. Student Hero Illustration at Upper-Right Header
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
                    'assets/images/unifinance/unifinance_student_hero.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.topRight,
                  ),
                ),
              ),
            ),

            // 3. Foreground Content
            Column(
              children: [
                // Top Bar
                _buildTopBar(),

                // Workflow Tabs Ribbon (Seamless In-Place Switcher)
                _buildWorkflowTabsRibbon(),

                // Scrollable Content
                Expanded(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(16, 4, 16, 88 + safeBottomPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Title & Subtitle
                            _buildMainHeader(),
                            const SizedBox(height: 16),

                            // Hero Live EMI Card with 3D Books & Graduation Cap
                            _buildLiveEmiHeroCard(),
                            const SizedBox(height: 14),

                            // Loan Type Toggle: Non-Collateral vs Collateral
                            _buildLoanTypeToggle(),
                            const SizedBox(height: 14),

                            // Slider 1: Required Loan Sanction Amount
                            _buildLoanAmountSliderCard(),
                            const SizedBox(height: 12),

                            // Slider 2: Repayment Tenure (Years)
                            _buildTenureSliderCard(),
                            const SizedBox(height: 12),

                            // Slider 3: Estimated Annual Interest Rate (%)
                            _buildInterestRateSliderCard(),
                            const SizedBox(height: 18),

                            // Section: Partner Financial Institutions
                            _buildPartnerInstitutionsSection(),
                            const SizedBox(height: 14),

                            // Germany Blocked Account Callout Box
                            _buildGermanyBlockedAccountBox(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),

                      // Sticky Bottom Action Button
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
                          child: _buildCheckEligibilityButton(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                      const Color(0xFF0066FF).withValues(alpha: 0.16 + 0.05 * anim),
                      const Color(0xFF0066FF).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),

            // Mid-right lavender-purple ambient glow
            Positioned(
              top: 240 + 20 * anim,
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
              bottom: 120,
              left: -70,
              width: 220,
              height: 220,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00B894).withValues(alpha: 0.09 + 0.04 * anim),
                      const Color(0xFF00B894).withValues(alpha: 0.0),
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
          const SizedBox(width: 12),

          // Green Wallet / Loan Icon Container
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4EA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFA7F3D0)),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Color(0xFF00A884),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),

          // Title
          const Text(
            'UniFinance Loans',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // WORKFLOW TABS RIBBON (WITH 3-WAY IN-PLACE SWITCHING)
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
        } else if (tab == 1) {
          if (widget.onSwitchToUniQuest != null) {
            widget.onSwitchToUniQuest!();
          } else if (widget.onRibbonTabChanged != null) {
            widget.onRibbonTabChanged!(1);
          } else {
            openFeature(context, Feature.uniQuest);
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
        const Text(
          'UniFinance™ Loan & EMI Studio',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.6,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Calculate instant non-collateral loan EMIs and check pre-approved lender sanctions',
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
  // HERO LIVE EMI CARD (WITH 3D BOOKS & GRADUATION CAP ASSET)
  // =========================================================================
  Widget _buildLiveEmiHeroCard() {
    final emiRounded = _monthlyEmi.round();
    final totalInterestLakhs = (_totalInterest / 100000).clamp(0.0, 999.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF38BDF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF93C5FD).withValues(alpha: 0.4), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // 3D Graduation Cap on Glowing Books Asset (Upper Right of Card)
          Positioned(
            top: 2,
            right: 2,
            width: 145,
            height: 115,
            child: IgnorePointer(
              child: Image.asset(
                'assets/images/unifinance/unifinance_books_cap.png',
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
          ),

          // Content Area
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Label
                Text(
                  'Estimated Monthly EMI',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.88),
                  ),
                ),
                const SizedBox(height: 6),

                // Giant EMI Value: ₹60,721 / month
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '₹${_formatIndianCurrency(emiRounded)}',
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.6,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '/ month',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.88),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Bottom Stats Row in Translucent Pill Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHeroStatColumn('Principal', '₹${_loanAmountLakhs.toStringAsFixed(1)} Lakhs'),
                      Container(width: 1, height: 28, color: Colors.white.withValues(alpha: 0.22)),
                      _buildHeroStatColumn('Total Interest', '₹${totalInterestLakhs.toStringAsFixed(1)} Lakhs'),
                      Container(width: 1, height: 28, color: Colors.white.withValues(alpha: 0.22)),
                      _buildHeroStatColumn('Tenure', '$_tenureYears Years'),
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

  Widget _buildHeroStatColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // LOAN TYPE TOGGLE: Non-Collateral vs Collateral
  // =========================================================================
  Widget _buildLoanTypeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isNonCollateral = true),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _isNonCollateral ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: _isNonCollateral
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Non-Collateral (Unsecured)',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _isNonCollateral ? const Color(0xFF0066FF) : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isNonCollateral = false),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !_isNonCollateral ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: !_isNonCollateral
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Collateral (Secured)',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: !_isNonCollateral ? const Color(0xFF0066FF) : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // SLIDER 1: REQUIRED LOAN SANCTION AMOUNT
  // =========================================================================
  Widget _buildLoanAmountSliderCard() {
    return _buildCustomSliderCard(
      title: 'Required Loan Sanction Amount',
      badgeText: '₹${_loanAmountLakhs.toInt()} Lakhs',
      value: _loanAmountLakhs,
      min: 0.0,
      max: 75.0,
      divisions: 75,
      activeColor: const Color(0xFF0066FF),
      minLabel: '0',
      maxLabel: '75',
      note: 'Max non-collateral limit is up to ₹75 Lakhs without co-borrower property',
      onChanged: (v) => setState(() => _loanAmountLakhs = v.roundToDouble()),
    );
  }

  // =========================================================================
  // SLIDER 2: REPAYMENT TENURE (YEARS)
  // =========================================================================
  Widget _buildTenureSliderCard() {
    return _buildCustomSliderCard(
      title: 'Repayment Tenure (Years)',
      badgeText: '$_tenureYears Years (${_tenureYears * 12} Months)',
      value: _tenureYears.toDouble(),
      min: 1.0,
      max: 20.0,
      divisions: 19,
      activeColor: const Color(0xFF0066FF),
      minLabel: '1',
      maxLabel: '20',
      note: 'Includes typical 6 to 12 months course grace period moratorium',
      onChanged: (v) => setState(() => _tenureYears = v.toInt()),
    );
  }

  // =========================================================================
  // SLIDER 3: ESTIMATED ANNUAL INTEREST RATE (%)
  // =========================================================================
  Widget _buildInterestRateSliderCard() {
    return _buildCustomSliderCard(
      title: 'Estimated Annual Interest Rate (%)',
      badgeText: '${_interestRate.toStringAsFixed(1)}% p.a.',
      value: _interestRate,
      min: 8.0,
      max: 14.0,
      divisions: 60,
      activeColor: const Color(0xFF0066FF),
      minLabel: '8',
      maxLabel: '14',
      note: 'Public banks ~9.2% · NBFCs ~10.5% · International lenders (USD) ~11.5%',
      onChanged: (v) => setState(() => _interestRate = (v * 10).round() / 10),
    );
  }

  // =========================================================================
  // REUSABLE SLIDER CARD WITH DOT MARKERS & GLOW THUMB (DRY CODE)
  // =========================================================================
  Widget _buildCustomSliderCard({
    required String title,
    required String badgeText,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Color activeColor,
    required String minLabel,
    required String maxLabel,
    required String note,
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
          // Header Row: Title on left, Badge on right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Custom Slider with Glow Thumb
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
              trackShape: const _DottedSliderTrackShape(),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),

          // Min and Max Labels Underneath
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
          const SizedBox(height: 4),

          // Footer Note
          Text(
            note,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // PARTNER FINANCIAL INSTITUTIONS SECTION
  // =========================================================================
  Widget _buildPartnerInstitutionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Partner Financial Institutions',
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Direct digital tie-ups for fast 48-hour sanction letter issuance',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 12),

        // 1. HDFC Credila
        _buildLenderCard(
          name: 'HDFC Credila',
          subtitle: 'Dedicated Education NBFC',
          maxLimit: 'Up to ₹75 Lakhs',
          limitType: 'Unsecured',
          rate: 'From 9.90% p.a.',
          iconBg: const Color(0xFFEFF6FF),
          iconColor: const Color(0xFF0066FF),
        ),
        const SizedBox(height: 10),

        // 2. Prodigy Finance
        _buildLenderCard(
          name: 'Prodigy Finance',
          subtitle: 'No Co-signer USD Loan',
          maxLimit: 'Up to \$100,000',
          limitType: 'Without Co-borrower',
          rate: 'From 11.20% p.a.',
          iconBg: const Color(0xFFF3E8FF),
          iconColor: const Color(0xFF7C3AED),
        ),
        const SizedBox(height: 10),

        // 3. Avanse Financial
        _buildLenderCard(
          name: 'Avanse Financial',
          subtitle: '100% Tuition & Living Coverage',
          maxLimit: 'Up to ₹60 Lakhs',
          limitType: 'Non-Collateral',
          rate: 'From 10.25% p.a.',
          iconBg: const Color(0xFFCCFBF1),
          iconColor: const Color(0xFF0D9488),
        ),
      ],
    );
  }

  Widget _buildLenderCard({
    required String name,
    required String subtitle,
    required String maxLimit,
    required String limitType,
    required String rate,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
      child: Row(
        children: [
          // Bank Icon Box
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.account_balance_rounded, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          // Institution Name & Subtitle
          Expanded(
            flex: 11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
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
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Limit Info
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  maxLimit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  limitType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Rate (Green Text)
          Text(
            rate,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Color(0xFF059669),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // GERMANY BLOCKED ACCOUNT CALLOUT BOX
  // =========================================================================
  Widget _buildGermanyBlockedAccountBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Germany Blocked Account (Sperrkonto)',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF92400E),
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Official mandatory living amount for 2026: €11,208 (~₹10.2 Lakhs) with instant digital opening.',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF92400E),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // STICKY BOTTOM BUTTON: [ Check Instant Pre-Approval Eligibility (Free) → ]
  // =========================================================================
  Widget _buildCheckEligibilityButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: const Color(0xFF0066FF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0066FF).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showPreApprovalSuccess,
          borderRadius: BorderRadius.circular(26),
          child: const Center(
            child: Text(
              'Check Instant Pre-Approval Eligibility (Free) →',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
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

/// Custom Dotted Track Shape for Sliders matching the inspiration design
class _DottedSliderTrackShape extends RoundedRectSliderTrackShape {
  static const int dotCount = 10;

  const _DottedSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      secondaryOffset: secondaryOffset,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final dotPaint = Paint()..color = const Color(0xFF0066FF).withValues(alpha: 0.7);
    final inactiveDotPaint = Paint()..color = const Color(0xFF93C5FD).withValues(alpha: 0.65);

    for (int i = 0; i <= dotCount; i++) {
      final dx = trackRect.left + (trackRect.width / dotCount) * i;
      final dy = trackRect.center.dy;
      if ((dx - thumbCenter.dx).abs() > 10) {
        final isPassed = dx <= thumbCenter.dx;
        context.canvas.drawCircle(
          Offset(dx, dy),
          2.0,
          isPassed ? dotPaint : inactiveDotPaint,
        );
      }
    }
  }
}
