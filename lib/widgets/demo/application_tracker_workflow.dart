import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Pixel-perfect Student Application Tracker & Vault workflow matching the provided design.
///
/// Features:
/// - Eyebrow label `ADMISSIONS TRACKER` in soft teal capsule
/// - Title `Student Application Tracker & Vault`
/// - Top-right subtle globe silhouette watermark + curved dashed flight path & airplane icon
/// - `Target Intake: Fall 2026` hero card featuring Neoclassical Domed Campus Building (`campus_header_dome.png`)
/// - Segmented sub-tab pill switcher (`Application Pipeline` vs `Document Vault`)
/// - Application Pipeline view: 5 connected numbered stages with status badges & active blue highlight
/// - Document Vault view: 5 connected numbered steps with dotted line, soft blue icon badges, verified status pills,
///   and dashed outline `Upload New Document to Vault` button with `[+]` icon
/// - Fully responsive across all devices
class ApplicationTrackerWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const ApplicationTrackerWorkflow({super.key, this.onCompleted});

  @override
  State<ApplicationTrackerWorkflow> createState() => _ApplicationTrackerWorkflowState();
}

class _ApplicationTrackerWorkflowState extends State<ApplicationTrackerWorkflow> {
  int _activeTab = 1; // Default to 1 (Document Vault) or allows toggling to 0 (Pipeline)

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header with Globe & Flight Path Artwork on Top-Right
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Flight path and airplane graphic
            Positioned(
              right: 0,
              top: -8,
              width: 170,
              height: 120,
              child: CustomPaint(
                painter: _FlightPathPainter(),
              ),
            ),

            // Typography column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Eyebrow: ADMISSIONS TRACKER
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFBF1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'ADMISSIONS TRACKER',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: Color(0xFF0F766E),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Title
                const Text(
                  'Student Application Tracker & Vault',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.7,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: 6),

                // Subtitle
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 290),
                  child: const Text(
                    'Live real-time admissions pipeline from university submissions to visa stamping',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 2. Hero Card: Target Intake: Fall 2026 with Neoclassical Campus Dome
        Container(
          width: double.infinity,
          height: 104,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E3A8A),
                Color(0xFF2563EB),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF60A5FA).withValues(alpha: 0.30),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.16),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Neoclassical Domed Campus Building Cutout on Right
                Positioned(
                  right: -10,
                  top: -6,
                  bottom: -6,
                  width: 185,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.transparent, Colors.white, Colors.white],
                        stops: [0.0, 0.40, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/abroad/campus_header_dome.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),

                // Foreground Details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      // Graduation Cap Circular Badge
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A).withValues(alpha: 0.55),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1.2,
                          ),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Text column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Target Intake: Fall 2026',
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '142 Days Remaining until Priority Visa Deadline',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFCBD5E1),
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
          ),
        ),
        const SizedBox(height: 16),

        // 3. Segmented Sub-Tab Switcher
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildSubTab(
                  title: 'Application Pipeline',
                  icon: Icons.push_pin_rounded,
                  isSelected: _activeTab == 0,
                  onTap: () => setState(() => _activeTab = 0),
                ),
              ),
              Expanded(
                child: _buildSubTab(
                  title: 'Document Vault',
                  icon: Icons.description_rounded,
                  isSelected: _activeTab == 1,
                  onTap: () => setState(() => _activeTab = 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 4. Tab Content: Pipeline vs Vault
        _activeTab == 0 ? _buildTimelinePipelineView() : _buildDocumentVaultView(),
      ],
    );
  }

  /// Segmented sub-tab button
  Widget _buildSubTab({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F62FE) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF0F62FE).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF64748B),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 5. Vertical Connected Timeline Pipeline View
  Widget _buildTimelinePipelineView() {
    final milestones = [
      _MilestoneData(
        step: 1,
        title: 'Profile Evaluation & Shortlisting',
        subtitle: 'Selected MIT, Stanford, TUM & Oxford based on GPA and test scores.',
        status: 'Completed',
        statusColor: const Color(0xFF059669),
        statusBg: const Color(0xFFECFDF5),
        date: 'Jan 15, 2026',
        icon: Icons.description_outlined,
        iconColor: const Color(0xFF059669),
        iconBg: const Color(0xFFECFDF5),
        circleColor: const Color(0xFF059669),
        connectorType: _ConnectorType.solidTeal,
      ),
      _MilestoneData(
        step: 2,
        title: 'AI Document Studio (SOP & LORs)',
        subtitle: 'Statement of Purpose drafted with 0% plagiarism & 3 academic LORs secured.',
        status: 'Completed',
        statusColor: const Color(0xFF059669),
        statusBg: const Color(0xFFECFDF5),
        date: 'Feb 02, 2026',
        icon: Icons.description_outlined,
        iconColor: const Color(0xFF059669),
        iconBg: const Color(0xFFECFDF5),
        circleColor: const Color(0xFF059669),
        connectorType: _ConnectorType.solidTeal,
      ),
      _MilestoneData(
        step: 3,
        title: 'Official University Submissions',
        subtitle: 'Application portals submitted with fee waiver codes applied.',
        status: 'Submitted',
        statusColor: const Color(0xFF0D9488),
        statusBg: const Color(0xFFF0FDFA),
        date: 'Feb 18, 2026',
        icon: Icons.send_rounded,
        iconColor: const Color(0xFF0D9488),
        iconBg: const Color(0xFFF0FDFA),
        circleColor: const Color(0xFF0D9488),
        connectorType: _ConnectorType.dashedTeal,
      ),
      _MilestoneData(
        step: 4,
        title: 'Offer Letter & I-20 / CAS Issuance',
        subtitle: 'Admit packet received from TUM! Awaiting Stanford official decision.',
        status: 'In Progress',
        statusColor: const Color(0xFF1D4ED8),
        statusBg: const Color(0xFFDBEAFE),
        date: 'Mar 25, 2026',
        datePrefix: 'Expected',
        icon: Icons.description_rounded,
        iconColor: const Color(0xFF2563EB),
        iconBg: const Color(0xFFEFF6FF),
        circleColor: const Color(0xFF0F62FE),
        isActive: true,
        connectorType: _ConnectorType.dottedGrey,
      ),
      _MilestoneData(
        step: 5,
        title: 'Consular Visa Mock & Embassy Filing',
        subtitle: 'ConsuAI adaptive voice interview prep & DS-160 form submission.',
        status: 'Upcoming',
        statusColor: const Color(0xFF64748B),
        statusBg: const Color(0xFFF1F5F9),
        date: 'May 10, 2026',
        icon: Icons.badge_outlined,
        iconColor: const Color(0xFF64748B),
        iconBg: const Color(0xFFF1F5F9),
        circleColor: const Color(0xFFCBD5E1),
        connectorType: _ConnectorType.none,
      ),
    ];

    return Column(
      children: List.generate(milestones.length, (index) {
        final m = milestones[index];
        final isLast = index == milestones.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Column: Step Circle + Connecting Line
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    // Numbered Circle
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: m.circleColor,
                        shape: BoxShape.circle,
                        boxShadow: m.isActive
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0F62FE).withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${m.step}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    // Connector Line down to next circle
                    if (!isLast)
                      Expanded(
                        child: CustomPaint(
                          painter: _TimelineConnectorPainter(type: m.connectorType),
                          size: const Size(2, double.infinity),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Right Column: Milestone Card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: m.isActive ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
                        width: m.isActive ? 1.6 : 1.0,
                      ),
                      gradient: m.isActive
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: m.isActive
                              ? const Color(0xFF2563EB).withValues(alpha: 0.12)
                              : Colors.black.withValues(alpha: 0.03),
                          blurRadius: m.isActive ? 12 : 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Milestone Icon in Rounded Square
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: m.iconBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            m.icon,
                            color: m.iconColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                m.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                  color: Color(0xFF0F172A),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                m.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF64748B),
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Right Badges: Status Pill + Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: m.statusBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                m.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: m.statusColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (m.datePrefix != null) ...[
                              Text(
                                m.datePrefix!,
                                style: const TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 1),
                            ],
                            Text(
                              m.date,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: m.isActive ? FontWeight.w700 : FontWeight.w500,
                                color: m.isActive ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),

                        // Chevron
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: m.isActive ? const Color(0xFF2563EB) : const Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// 6. Document Vault View Matching Image 1 Pixel-for-Pixel
  Widget _buildDocumentVaultView() {
    final docs = [
      _VaultDocData(
        step: 1,
        title: 'Undergraduate Transcripts',
        subtitle: 'PDF · 4.2 MB',
        status: 'Verified',
        statusColor: const Color(0xFF059669),
        statusBg: const Color(0xFFECFDF5),
        icon: Icons.description_rounded,
        circleColor: const Color(0xFF059669),
      ),
      _VaultDocData(
        step: 2,
        title: 'Valid International Passport',
        subtitle: 'PDF · 2.1 MB',
        status: 'Verified',
        statusColor: const Color(0xFF059669),
        statusBg: const Color(0xFFECFDF5),
        icon: Icons.badge_rounded,
        circleColor: const Color(0xFF059669),
      ),
      _VaultDocData(
        step: 3,
        title: 'Bank Solvency Letter (₹45L)',
        subtitle: 'PDF · 1.8 MB',
        status: 'Under Review',
        statusColor: const Color(0xFFD97706),
        statusBg: const Color(0xFFFEF3C7),
        icon: Icons.receipt_long_rounded,
        circleColor: const Color(0xFFF59E0B),
      ),
      _VaultDocData(
        step: 4,
        title: 'SOP (Statement of Purpose)',
        subtitle: 'DOCX · 850 Words',
        status: 'Draft Ready',
        statusColor: const Color(0xFF1D4ED8),
        statusBg: const Color(0xFFDBEAFE),
        icon: Icons.article_rounded,
        circleColor: const Color(0xFF2563EB),
      ),
      _VaultDocData(
        step: 5,
        title: 'Official GRE & IELTS Scorecards',
        subtitle: 'ETS / IDP Direct',
        status: 'Delivered',
        statusColor: const Color(0xFF059669),
        statusBg: const Color(0xFFECFDF5),
        icon: Icons.bar_chart_rounded,
        circleColor: const Color(0xFF059669),
      ),
    ];

    return Column(
      children: [
        // Connected Stepper List
        ...List.generate(docs.length, (index) {
          final doc = docs[index];
          final isLast = index == docs.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left Column: Step Circle + Dotted Line
                SizedBox(
                  width: 32,
                  child: Column(
                    children: [
                      // Numbered Circle
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: doc.circleColor,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${doc.step}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      // Dotted connecting line down to next circle
                      if (!isLast)
                        Expanded(
                          child: CustomPaint(
                            painter: _TimelineConnectorPainter(type: _ConnectorType.dottedGrey),
                            size: const Size(2, double.infinity),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                // Right Column: Document Card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(14, 13, 12, 13),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Soft Light Blue Rounded Square Badge with Blue Icon
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              doc.icon,
                              color: const Color(0xFF2563EB),
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Document Title & File Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  doc.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13.5,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  doc.subtitle,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF64748B),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Status Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: doc.statusBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              doc.status,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: doc.statusColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),

                          // Chevron
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 19,
                            color: Color(0xFF94A3B8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: 8),

        // Dashed Outline Upload Button matching Image 1
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening secure document upload dialog...'),
                  backgroundColor: Color(0xFF2563EB),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: CustomPaint(
              painter: _DashedBorderPainter(
                color: const Color(0xFF3B82F6),
                strokeWidth: 1.4,
                radius: 16,
                dashLength: 5,
                spaceLength: 3.5,
              ),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Upload New Document to Vault',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2563EB),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

enum _ConnectorType { solidTeal, dashedTeal, dottedGrey, none }

class _MilestoneData {
  final int step;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final String date;
  final String? datePrefix;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color circleColor;
  final bool isActive;
  final _ConnectorType connectorType;

  _MilestoneData({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.date,
    this.datePrefix,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.circleColor,
    this.isActive = false,
    required this.connectorType,
  });
}

class _VaultDocData {
  final int step;
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final IconData icon;
  final Color circleColor;

  const _VaultDocData({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.icon,
    required this.circleColor,
  });
}

/// Custom painter for vertical connector lines between timeline circles
class _TimelineConnectorPainter extends CustomPainter {
  final _ConnectorType type;

  _TimelineConnectorPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    if (type == _ConnectorType.none) return;

    final x = size.width / 2;
    final paint = Paint()
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    if (type == _ConnectorType.solidTeal) {
      paint.color = const Color(0xFF059669);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    } else if (type == _ConnectorType.dashedTeal) {
      paint.color = const Color(0xFF0D9488);
      _drawDashedLine(canvas, Offset(x, 0), Offset(x, size.height), paint, dashLength: 4, spaceLength: 3);
    } else if (type == _ConnectorType.dottedGrey) {
      paint.color = const Color(0xFFCBD5E1);
      _drawDashedLine(canvas, Offset(x, 0), Offset(x, size.height), paint, dashLength: 3, spaceLength: 3);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint, {required double dashLength, required double spaceLength}) {
    double currentY = p1.dy;
    while (currentY < p2.dy) {
      final nextY = math.min(currentY + dashLength, p2.dy);
      canvas.drawLine(Offset(p1.dx, currentY), Offset(p1.dx, nextY), paint);
      currentY += dashLength + spaceLength;
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineConnectorPainter oldDelegate) => oldDelegate.type != type;
}

/// Custom painter for rounded rectangular dashed border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashLength;
  final double spaceLength;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.4,
    this.radius = 16,
    this.dashLength = 5,
    this.spaceLength = 3.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extract = metric.extractPath(distance, distance + dashLength);
        canvas.drawPath(extract, paint);
        distance += dashLength + spaceLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) => false;
}

/// Custom painter for top-right globe and airplane dashed trajectory
class _FlightPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Subtle globe silhouette rings
    final globeCenter = Offset(size.width - 25, 45);
    final globeRadius = 55.0;

    final globePaint = Paint()
      ..color = const Color(0xFF38BDF8).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(globeCenter, globeRadius, globePaint);

    final linePaint = Paint()
      ..color = const Color(0xFF0284C7).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Latitude & longitude arcs
    canvas.drawArc(
      Rect.fromCircle(center: globeCenter, radius: globeRadius),
      0,
      math.pi * 2,
      false,
      linePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: globeCenter, width: globeRadius * 1.2, height: globeRadius * 0.7),
      linePaint,
    );

    // 2. Curved dashed flight path
    final path = Path();
    path.moveTo(size.width - 80, size.height - 10);
    path.quadraticBezierTo(
      size.width - 10,
      size.height - 25,
      size.width - 15,
      25,
    );

    final dashPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extract = metric.extractPath(distance, distance + 4);
        canvas.drawPath(extract, dashPaint);
        distance += 8;
      }
    }

    // 3. Airplane icon at the end of the trajectory
    final planeCenter = Offset(size.width - 15, 25);
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '✈',
        style: TextStyle(
          color: Color(0xFF0F62FE),
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(planeCenter.dx, planeCenter.dy);
    canvas.rotate(0.2); // angled along flight path
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
