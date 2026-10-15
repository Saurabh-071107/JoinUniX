import 'package:flutter/material.dart';
import '../widgets/demo/after_12th_workflow.dart';
import '../widgets/demo/application_tracker_workflow.dart';
import '../widgets/demo/compare_and_docs_workflow.dart';
import '../widgets/demo/consul_ai_workflow.dart';
import '../widgets/demo/consultancies_workflow.dart';
import '../widgets/demo/country_guides_workflow.dart';
import '../widgets/demo/courses_and_campus_deck_workflow.dart';
import '../widgets/demo/events_rsvp_workflow.dart';
import '../widgets/demo/exam_arena_workflow.dart';
import '../widgets/demo/hackathons_and_jobs_workflow.dart';
import '../widgets/demo/india_courses_workflow.dart';
import '../widgets/demo/scholarships_and_partners_workflow.dart';
import '../widgets/demo/sharktank_and_stock_workflow.dart';
import '../widgets/demo/unistay_and_mentors_workflow.dart';

/// User type derived from the onboarding Academic Stage.
enum Persona {
  school, senior, ug, pg, pro, gap;

  static Persona of(String stage) => switch (stage) {
        'Class 11 - 12' => senior,
        'Undergraduate' => ug,
        'Postgraduate' => pg,
        'Working Professional' => pro,
        _ when stage.startsWith('Gap') => gap,
        _ => school,
      };

  /// JEE/NEET track: gets the Prepare tab + exam content on Home.
  bool get preps => this == senior || this == gap;

  /// 3rd bottom-nav tab.
  (String, IconData) get tab => switch (this) {
        school => ('Discover', Icons.lightbulb_rounded),
        senior || gap => ('Prepare', Icons.auto_stories_rounded),
        _ => ('Abroad', Icons.flight_takeoff_rounded),
      };

  /// Features shown as a grid in the Discover / Abroad tab (empty for Prepare).
  List<Feature> get hub => switch (this) {
        school => const [Feature.after12th, Feature.sharkTank],
        senior || gap => const [],
        _ => const [
            Feature.countryGuides,
            Feature.coursesCampus,
            Feature.appTracker,
            Feature.uniFinance,
            Feature.consultancies,
            Feature.uniStay,
            Feature.scholarships,
            Feature.events,
          ],
      };
}

typedef _P = Persona;
const _abroad = {_P.senior, _P.ug, _P.pg, _P.pro, _P.gap};
const _higher = {_P.ug, _P.pg, _P.pro};
const _jee = {_P.senior, _P.gap};

/// Every demo workflow, who it is for, and how to build it.
enum Feature {
  // AI tools (floating AI button)
  consulAi('ConsulAI Visa Interview', 'Practice your visa interview with voice AI', Icons.mic_rounded, Color(0xFF6F2CFF), _abroad, ai: true),
  uniQuest('UniQuest Admission Odds', 'AI audit of your global admission chances', Icons.school_rounded, Color(0xFF0F62FE), _higher, ai: true),
  compareDocs('AI SOP / LOR Writer', 'Draft SOPs & compare universities with AI', Icons.edit_document, Color(0xFF0EA5E9), {_P.ug, _P.pg, _P.pro, _P.gap}, ai: true),
  examArena('AI JEE / NEET Mock', 'CBT simulator with AI rank prediction', Icons.timer_outlined, Color(0xFFE11D48), _jee, ai: true),

  // Regular tools
  after12th('After 12th Hub', 'Streams, courses & careers explained', Icons.menu_book_rounded, Color(0xFFFF6B6B), {_P.school, _P.senior, _P.gap}),
  sharkTank('SharkTank & Stocks', 'Pitch startups & trade with virtual cash', Icons.trending_up_rounded, Color(0xFFFF4757), {_P.school, _P.senior, _P.ug, _P.pg}),
  indiaCourses('NIRF Colleges & Cutoffs', 'Top Indian colleges, cutoffs & packages', Icons.account_balance_rounded, Color(0xFF1B2A56), _jee),
  hackathons('Hackathons & Internships', 'Build, compete & land paid internships', Icons.terminal_rounded, Color(0xFF7C3AED), _higher),
  countryGuides('Country Guides', 'Costs, visas & work rights by country', Icons.public_rounded, Color(0xFF6F2CFF), _abroad),
  coursesCampus('Courses & Campus 360', 'Global intakes & interactive campus tours', Icons.auto_stories_rounded, Color(0xFF0F62FE), _higher),
  appTracker('Application Tracker', 'Track admissions from submit to visa', Icons.checklist_rounded, Color(0xFF00B894), _higher),
  uniFinance('UniFinance Loans', 'Education loan EMIs & lender sanctions', Icons.account_balance_wallet_rounded, Color(0xFF00A884), _abroad),
  consultancies('Consultancies', 'Verified overseas education advisors', Icons.verified_rounded, Color(0xFF10B981), _abroad),
  uniStay('UniStay & Mentors', 'Student housing & 1-on-1 alumni mentors', Icons.apartment_rounded, Color(0xFFFFA502), _higher),
  scholarships('Scholarships', 'Merit scholarships across the globe', Icons.stars_rounded, Color(0xFF8B5CF6), _abroad),
  events('Education Fairs & Events', 'Webinars & fairs with free passes', Icons.calendar_month_rounded, Color(0xFF2563EB), _abroad);

  const Feature(this.title, this.subtitle, this.icon, this.color, this.personas, {this.ai = false});

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Set<Persona> personas;
  final bool ai;

  /// High-resolution 3D asset path.
  String? get imageAsset => switch (this) {
        countryGuides => 'assets/images/home/box_country_guides.png',
        coursesCampus => 'assets/images/home/box_campus.png',
        appTracker => 'assets/images/home/box_app_tracker.png',
        uniFinance => 'assets/images/home/box_unifinance.png',
        consultancies => 'assets/images/home/box_consultancies.png',
        uniStay => 'assets/images/home/box_unistay.png',
        scholarships => 'assets/images/home/box_scholarships.png',
        events => 'assets/images/home/box_events.png',
        sharkTank => 'assets/images/home/box_shark_tank.png',
        hackathons => 'assets/images/home/box_hackathons.png',
        after12th => 'assets/images/home/box_after_12th.png',
        _ => null,
      };

  /// Solid badge icon color matching the visual theme.
  Color get badgeColor => switch (this) {
        countryGuides => const Color(0xFF7C3AED),
        coursesCampus => const Color(0xFF2563EB),
        appTracker => const Color(0xFF059669),
        uniFinance => const Color(0xFF0D9488),
        consultancies => const Color(0xFFEA580C),
        uniStay => const Color(0xFFD97706),
        scholarships => const Color(0xFF7C3AED),
        events => const Color(0xFF2563EB),
        after12th => const Color(0xFFF97316),
        sharkTank => const Color(0xFFEF4444),
        _ => color,
      };

  /// Icon for top-left badge.
  IconData get badgeIcon => switch (this) {
        coursesCampus => Icons.menu_book_rounded,
        consultancies => Icons.verified_user_rounded,
        events => Icons.calendar_month_rounded,
        after12th => Icons.menu_book_rounded,
        sharkTank => Icons.trending_up_rounded,
        _ => icon,
      };

  /// Soft tinted gradient for the card background.
  List<Color> get softGradient => switch (this) {
        countryGuides => const [Color(0xFFF3E8FF), Color(0xFFE9D5FF), Color(0xFFC4B5FD)],
        coursesCampus => const [Color(0xFFE0F2FE), Color(0xFFBAE6FD), Color(0xFF93C5FD)],
        appTracker => const [Color(0xFFD1FAE5), Color(0xFFA7F3D0), Color(0xFF6EE7B7)],
        uniFinance => const [Color(0xFFCCFBF1), Color(0xFF99F6E4), Color(0xFF5EEAD4)],
        consultancies => const [Color(0xFFFFEDD5), Color(0xFFFED7AA), Color(0xFFFDBA74)],
        uniStay => const [Color(0xFFFEF3C7), Color(0xFFFDE68A), Color(0xFFFCD34D)],
        scholarships => const [Color(0xFFF3E8FF), Color(0xFFE9D5FF), Color(0xFFC4B5FD)],
        events => const [Color(0xFFDBEAFE), Color(0xFFBFDBFE), Color(0xFF93C5FD)],
        after12th => const [Color(0xFFFFFBEB), Color(0xFFFEF3C7), Color(0xFFFED7AA)],
        sharkTank => const [Color(0xFFFFF1F2), Color(0xFFFFE4E6), Color(0xFFFED7AA)],
        _ => [color.withValues(alpha: 0.22), color.withValues(alpha: 0.14), color.withValues(alpha: 0.08)],
      };

  /// Cool ambient accent tint for the vertical background accents.
  Color get ambientAccent => switch (this) {
        countryGuides => const Color(0xFF8B5CF6),
        coursesCampus => const Color(0xFF3B82F6),
        after12th => const Color(0xFFF97316),
        sharkTank => const Color(0xFFEF4444),
        appTracker => const Color(0xFF10B981),
        uniFinance => const Color(0xFF14B8A6),
        consultancies => const Color(0xFFF97316),
        uniStay => const Color(0xFFF59E0B),
        scholarships => const Color(0xFF8B5CF6),
        events => const Color(0xFF3B82F6),
        _ => color,
      };

  static List<Feature> forPersona(Persona p, {bool ai = false}) =>
      values.where((f) => f.ai == ai && f.personas.contains(p)).toList();

  /// First candidate available to [p], or null.
  static Feature? firstFor(Persona p, List<Feature> candidates) =>
      candidates.where((f) => f.personas.contains(p)).firstOrNull;

  Widget build(VoidCallback done) => switch (this) {
        consulAi => ConsulAiWorkflow(onCompleted: done, initialRibbonTab: 0),
        uniQuest => ConsulAiWorkflow(onCompleted: done, initialRibbonTab: 1),
        compareDocs => CompareAndDocsWorkflow(onCompleted: done),
        examArena => ExamArenaWorkflow(onCompleted: done),
        after12th => After12thWorkflow(onCompleted: done),
        sharkTank => SharkTankAndStockWorkflow(onCompleted: done),
        indiaCourses => IndiaCoursesWorkflow(onCompleted: done),
        hackathons => HackathonsAndJobsWorkflow(onCompleted: done),
        countryGuides => CountryGuidesWorkflow(onCompleted: done),
        coursesCampus => CoursesAndCampusDeckWorkflow(onCompleted: done),
        appTracker => ApplicationTrackerWorkflow(onCompleted: done),
        uniFinance => ConsulAiWorkflow(onCompleted: done, initialRibbonTab: 2),
        consultancies => ConsultanciesWorkflow(onCompleted: done),
        uniStay => UniStayAndMentorsWorkflow(onCompleted: done),
        scholarships => ScholarshipsAndPartnersWorkflow(onCompleted: done),
        events => EventsRsvpWorkflow(onCompleted: done),
      };
}

