import 'package:flutter/material.dart';
import 'workflow_shared_widgets.dart';

/// University badge item for partner institutions.
class UniversityBadge {
  final String label;
  final IconData? icon;
  final Color textColor;
  final Color? iconColor;

  const UniversityBadge({
    required this.label,
    this.icon,
    this.textColor = const Color(0xFF1E293B),
    this.iconColor,
  });
}

/// Data model representing an Education Fair or Webinar event.
class EventFairItem {
  final String title;
  final String attendingUnis;
  final String benefit;
  final IconData benefitIcon;
  final String date;
  final String time;
  final String description;
  final List<UniversityBadge> uniBadges;
  final String imageAsset;

  const EventFairItem({
    required this.title,
    required this.attendingUnis,
    required this.benefit,
    required this.benefitIcon,
    required this.date,
    required this.time,
    required this.description,
    this.uniBadges = const [],
    required this.imageAsset,
  });
}

/// Pixel-perfect Education Fairs & Events screen matching the user screenshot.
///
/// Features:
/// - Hero Header Banner:
///   - Eyebrow pill: EVENTS & WEBINARS badge
///   - Two-tone title: Global Education Fairs & Webinars (with gradient orange accent)
///   - Informative subtitle on fee waivers & university delegates
///   - 3D montage artwork (assets/images/abroad/events_hero_montage.png)
/// - Pixel-matched Event Cards:
///   - Multiple architectural vertical background lines (more than one!) so cards don't feel empty
///   - Badges row: Universities attending (orange) and Fee waiver benefits (mint green)
///   - Bold event title & clean date and time indicators
///   - Brief description of official consular/admission sessions
///   - University partner crest badges row (Toronto, Oxford, IMPERIAL, TUM)
///   - Appropriately large 3D illustrations (Cathedral/Fair, German Visa scene)
///   - Full-width blue action button: Register for Free RSVP Pass ->
/// - Interactive digital RSVP pass modal with QR pass preview
/// - Zero emojis and 100% responsive across all screen sizes
class EventsRsvpWorkflow extends StatefulWidget {
  final VoidCallback? onCompleted;

  const EventsRsvpWorkflow({super.key, this.onCompleted});

  @override
  State<EventsRsvpWorkflow> createState() => _EventsRsvpWorkflowState();
}

class _EventsRsvpWorkflowState extends State<EventsRsvpWorkflow> {
  final Set<String> _registeredEvents = {};

  static const List<EventFairItem> _allEvents = [
    EventFairItem(
      title: 'Global University Mega Fair 2026',
      attendingUnis: '65 Universities Attending',
      benefit: '\$150 / ₹12,500 App Fee Waiver',
      benefitIcon: Icons.card_giftcard_rounded,
      date: 'Saturday, March 28, 2026',
      time: '10:00 AM - 5:00 PM IST',
      description:
          'Meet official admissions delegates from University of Toronto, Oxford, Imperial, and TUM for direct on-the-spot profile evaluations.',
      uniBadges: [
        UniversityBadge(
          label: 'Toronto',
          icon: Icons.shield_outlined,
          iconColor: Color(0xFF1E3A8A),
        ),
        UniversityBadge(
          label: 'Oxford',
          icon: Icons.shield_outlined,
          iconColor: Color(0xFF1E293B),
        ),
        UniversityBadge(
          label: 'IMPERIAL',
          textColor: Color(0xFF1D4ED8),
        ),
        UniversityBadge(
          label: 'TUM',
          textColor: Color(0xFF0284C7),
          icon: Icons.view_column_rounded,
          iconColor: Color(0xFF0284C7),
        ),
      ],
      imageAsset: 'assets/images/abroad/event_mega_fair.png',
    ),
    EventFairItem(
      title: 'German Embassy National Visa & APS Masterclass',
      attendingUnis: '12 Universities Attending',
      benefit: 'Free APS Verification Guide',
      benefitIcon: Icons.description_rounded,
      date: 'Thursday, April 09, 2026',
      time: '6:30 PM - 8:00 PM IST',
      description:
          'Official session by German consular experts covering APS certificate expedites, €11,208 blocked accounts, and EU Blue Card pathways.',
      uniBadges: [],
      imageAsset: 'assets/images/abroad/event_german_visa.png',
    ),
    EventFairItem(
      title: 'UK Study Abroad Virtual Fair',
      attendingUnis: '18 Universities Attending',
      benefit: 'Free SOP Review Session',
      benefitIcon: Icons.stars_rounded,
      date: 'Saturday, May 16, 2026',
      time: '4:00 PM - 7:00 PM IST',
      description:
          'Interact directly with top Russell Group universities, admission deans, and Chevening scholars for fast-tracked 2026 fall intake.',
      uniBadges: [
        UniversityBadge(label: 'UCL', textColor: Color(0xFF4338CA)),
        UniversityBadge(label: 'Edinburgh', textColor: Color(0xFF047857)),
        UniversityBadge(label: 'Manchester', textColor: Color(0xFFB91C1C)),
      ],
      imageAsset: 'assets/images/abroad/event_uk_fair.png',
    ),
  ];

  void _showRsvpDialog(EventFairItem event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
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
              // Handle bar
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

              // Title row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.confirmation_number_outlined,
                      color: Color(0xFF1D61E7),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Confirm Free RSVP Pass',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded,
                        color: Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Digital Pass Ticket Container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1D61E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.qr_code_2_rounded,
                          color: Colors.white,
                          size: 52,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'OFFICIAL ENTRY PASS',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Pass ID: #JX-FAIR-9824',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${event.date} · Free RSVP',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.card_giftcard_rounded,
                              color: Color(0xFF6EE7B7), size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Includes: ${event.benefit}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Action button
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() => _registeredEvents.add(event.title));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'RSVP Confirmed! Digital QR pass for "${event.title}" saved.'),
                        backgroundColor: const Color(0xFF1D61E7),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D61E7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Download & Save Digital QR Pass →',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Hero Header Card matching screenshot
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.fromLTRB(18, 16, 12, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFFFFBEB),
                const Color(0xFFE0F2FE).withValues(alpha: 0.65),
                const Color(0xFFF0F9FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
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
              // Typography Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Eyebrow pill: EVENTS & WEBINARS
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'EVENTS & WEBINARS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: Color(0xFFD97706),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title: Global Education
                    const Text(
                      'Global Education',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                        height: 1.15,
                      ),
                    ),
                    // Title: Fairs & Webinars
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Fairs & ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.5,
                            height: 1.15,
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFFEA580C), Color(0xFFF97316)],
                          ).createShader(bounds),
                          child: const Text(
                            'Webinars',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    const Text(
                      'Meet university delegates in-person & virtually. Unlock \$150 fee waivers.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // 3D University Montage Artwork on Right (Enlarged)
              SizedBox(
                width: 154,
                height: 136,
                child: Image.asset(
                  'assets/images/abroad/events_hero_montage.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.centerRight,
                  errorBuilder: (_, _, _) => Image.asset(
                    'assets/images/abroad/abroad_events.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.centerRight,
                    errorBuilder: (_, _, _) => const SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Event Cards matching screenshot
        ..._allEvents.map((item) => _buildEventCard(item)),
      ],
    );
  }

  Widget _buildEventCard(EventFairItem item) {
    final isRegistered = _registeredEvents.contains(item.title);

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.fromLTRB(14, 15, 10, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: const LinearGradient(
          colors: [Colors.white, Color(0xFFFBFDFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
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
          // Multiple architectural vertical background lines so card doesn't feel empty
          const CardVerticalAccents(borderRadius: 22),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Badges Row matching screenshot
              Wrap(
                spacing: 8,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.people_alt_rounded,
                          size: 13.5,
                          color: Color(0xFFEA580C),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.attendingUnis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFEA580C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.benefitIcon,
                          size: 13.5,
                          color: const Color(0xFF059669),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.benefit,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF059669),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Middle Row: Left Details + Right 3D Artwork (Enlarged)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Content Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Title
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Date and Time (Responsive Wrap)
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 13,
                                  color: Color(0xFF64748B),
                                ),
                                const SizedBox(width: 4.5),
                                Text(
                                  item.date,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                  size: 13,
                                  color: Color(0xFF64748B),
                                ),
                                const SizedBox(width: 4.5),
                                Text(
                                  item.time,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Description
                        Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF475569),
                            height: 1.35,
                          ),
                        ),

                        // Partner University Badges Row (if any)
                        if (item.uniBadges.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: item.uniBadges.map((badge) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (badge.icon != null) ...[
                                      Icon(
                                        badge.icon,
                                        size: 12,
                                        color: badge.iconColor ??
                                            badge.textColor,
                                      ),
                                      const SizedBox(width: 4),
                                    ],
                                    Text(
                                      badge.label,
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w700,
                                        color: badge.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Right Column: Appropriately large 3D campus/visa photo (Enlarged)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: 154,
                      height: 154,
                      child: Image.asset(
                        item.imageAsset,
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight,
                        errorBuilder: (_, _, _) => Image.asset(
                          'assets/images/abroad/abroad_events.png',
                          fit: BoxFit.contain,
                          alignment: Alignment.centerRight,
                          errorBuilder: (_, _, _) => Container(
                            color: const Color(0xFFEFF6FF),
                            child: const Center(
                              child: Icon(
                                Icons.event_seat_rounded,
                                color: Color(0xFF1D61E7),
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Full-Width Register Action Button
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => _showRsvpDialog(item),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isRegistered
                        ? const Color(0xFF059669)
                        : const Color(0xFF1D61E7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isRegistered
                            ? 'RSVP Confirmed (QR Pass Issued)'
                            : 'Register for Free RSVP Pass',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        isRegistered
                            ? Icons.check_circle_rounded
                            : Icons.arrow_forward_rounded,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
