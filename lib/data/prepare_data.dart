import 'package:flutter/material.dart';

enum TopicStatus { completed, inProgress, notStarted }

class SubjectProgressItem {
  final String name;
  final double progress;
  final Color color;
  final String iconPath;

  const SubjectProgressItem({
    required this.name,
    required this.progress,
    required this.color,
    required this.iconPath,
  });
}

class GoalItem {
  final String title;
  final bool isCompleted;

  const GoalItem({
    required this.title,
    required this.isCompleted,
  });
}

class StudyDayItem {
  final String day;
  final String progressText;
  final bool isCompleted;
  final bool isActive;

  const StudyDayItem({
    required this.day,
    required this.progressText,
    this.isCompleted = false,
    this.isActive = false,
  });
}

class ChapterTopicItem {
  final String title;
  final TopicStatus status;

  const ChapterTopicItem({
    required this.title,
    required this.status,
  });
}

class SubjectChapterGroup {
  final String subject;
  final String chaptersCountText;
  final double progress;
  final Color accentColor;
  final Color bgColor;
  final Color borderColor;
  final String iconPath;
  final List<ChapterTopicItem> topics;

  const SubjectChapterGroup({
    required this.subject,
    required this.chaptersCountText,
    required this.progress,
    required this.accentColor,
    required this.bgColor,
    required this.borderColor,
    required this.iconPath,
    required this.topics,
  });
}

class PracticeTestCardItem {
  final String title;
  final String subtitle;
  final String iconPath;
  final Color bgColor;
  final Color borderColor;
  final Color accentColor;

  const PracticeTestCardItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.bgColor,
    required this.borderColor,
    required this.accentColor,
  });
}

// ---------------------- Prepare Datasets ----------------------

const double overallProgressValue = 0.68;

const subjectProgressList = [
  SubjectProgressItem(
    name: 'Physics',
    progress: 0.72,
    color: Color(0xFFF43F5E),
    iconPath: 'assets/images/dashboard/prepare_subject_physics.png',
  ),
  SubjectProgressItem(
    name: 'Mathematics',
    progress: 0.48,
    color: Color(0xFF3B82F6),
    iconPath: 'assets/images/dashboard/prepare_subject_math.png',
  ),
  SubjectProgressItem(
    name: 'Chemistry',
    progress: 0.59,
    color: Color(0xFFF97316),
    iconPath: 'assets/images/dashboard/prepare_subject_chemistry.png',
  ),
];

const todayGoalsList = [
  GoalItem(title: 'Watch theory video', isCompleted: true),
  GoalItem(title: 'Practice 30 questions', isCompleted: true),
  GoalItem(title: 'Revise notes', isCompleted: false),
  GoalItem(title: 'Take a mock test', isCompleted: false),
  GoalItem(title: 'Analyze mistakes', isCompleted: false),
];

const studyPlanDays = [
  StudyDayItem(day: 'Mon', progressText: '3/5', isCompleted: true),
  StudyDayItem(day: 'Tue', progressText: '4/5', isCompleted: true),
  StudyDayItem(day: 'Wed', progressText: '3/5', isActive: true),
  StudyDayItem(day: 'Thu', progressText: '0/5'),
  StudyDayItem(day: 'Fri', progressText: '0/5'),
  StudyDayItem(day: 'Sat', progressText: '0/5'),
  StudyDayItem(day: 'Sun', progressText: '0/5'),
];

const subjectChapterGroups = [
  SubjectChapterGroup(
    subject: 'Physics',
    chaptersCountText: '12/16 chapters',
    progress: 0.75,
    accentColor: Color(0xFFE11D48),
    bgColor: Color(0xFFFFF1F2),
    borderColor: Color(0xFFFFE4E6),
    iconPath: 'assets/images/dashboard/prepare_subject_physics.png',
    topics: [
      ChapterTopicItem(title: 'Units and Dimensions', status: TopicStatus.completed),
      ChapterTopicItem(title: 'Rotational Motion', status: TopicStatus.inProgress),
      ChapterTopicItem(title: 'Gravitation', status: TopicStatus.notStarted),
      ChapterTopicItem(title: 'Mechanical Properties...', status: TopicStatus.notStarted),
    ],
  ),
  SubjectChapterGroup(
    subject: 'Mathematics',
    chaptersCountText: '10/14 chapters',
    progress: 0.71,
    accentColor: Color(0xFF0284C7),
    bgColor: Color(0xFFF0F9FF),
    borderColor: Color(0xFFE0F2FE),
    iconPath: 'assets/images/dashboard/prepare_subject_math.png',
    topics: [
      ChapterTopicItem(title: 'Relations and Functions', status: TopicStatus.completed),
      ChapterTopicItem(title: 'Limits and Continuity', status: TopicStatus.inProgress),
      ChapterTopicItem(title: 'Differentiation', status: TopicStatus.notStarted),
      ChapterTopicItem(title: 'Application of Derivatives', status: TopicStatus.notStarted),
    ],
  ),
  SubjectChapterGroup(
    subject: 'Chemistry',
    chaptersCountText: '11/15 chapters',
    progress: 0.73,
    accentColor: Color(0xFFD97706),
    bgColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFFEF3C7),
    iconPath: 'assets/images/dashboard/prepare_subject_chemistry.png',
    topics: [
      ChapterTopicItem(title: 'Chemical Kinetics', status: TopicStatus.completed),
      ChapterTopicItem(title: 'Thermodynamics', status: TopicStatus.inProgress),
      ChapterTopicItem(title: 'Equilibrium', status: TopicStatus.notStarted),
      ChapterTopicItem(title: 'Electrochemistry', status: TopicStatus.notStarted),
    ],
  ),
];

const practiceTestCards = [
  PracticeTestCardItem(
    title: 'Practice\nQuestions',
    subtitle: 'Chapter-wise\n& Topic-wise',
    iconPath: 'assets/images/dashboard/prepare_practice_questions.png',
    bgColor: Color(0xFFF5F3FF),
    borderColor: Color(0xFFEDE9FE),
    accentColor: Color(0xFF6366F1),
  ),
  PracticeTestCardItem(
    title: 'Mock Tests',
    subtitle: 'Full length\n& Part tests',
    iconPath: 'assets/images/dashboard/prepare_mock_tests.png',
    bgColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFFEF3C7),
    accentColor: Color(0xFFD97706),
  ),
  PracticeTestCardItem(
    title: 'Previous Year\nPapers',
    subtitle: 'JEE Main\n(2020–2024)',
    iconPath: 'assets/images/dashboard/prepare_pyq_papers.png',
    bgColor: Color(0xFFF0FDF4),
    borderColor: Color(0xFFDCFCE7),
    accentColor: Color(0xFF059669),
  ),
  PracticeTestCardItem(
    title: 'Study Material',
    subtitle: 'Notes, Formulas\n& PYQs',
    iconPath: 'assets/images/dashboard/prepare_study_material.png',
    bgColor: Color(0xFFFFF1F2),
    borderColor: Color(0xFFFFE4E6),
    accentColor: Color(0xFFE11D48),
  ),
];
