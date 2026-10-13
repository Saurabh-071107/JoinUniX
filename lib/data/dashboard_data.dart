import 'package:flutter/material.dart';

class QuickActionItem {
  final String title;
  final String imagePath;
  final Color bgColor;
  final Color borderColor;

  const QuickActionItem({
    required this.title,
    required this.imagePath,
    required this.bgColor,
    required this.borderColor,
  });
}

class PreparationItem {
  final String title;
  final String imagePath;
  final double progress;
  final String progressText;
  final Color accentColor;
  final String subtitle;
  final String metric;

  const PreparationItem({
    required this.title,
    required this.imagePath,
    required this.progress,
    required this.progressText,
    required this.accentColor,
    required this.subtitle,
    required this.metric,
  });
}

class RecommendedItem {
  final String title;
  final String subtitle;
  final String imagePath;

  const RecommendedItem({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class UpcomingItem {
  final int days;
  final Color badgeColor;
  final String title;
  final String dateLabel;
  final String dateValue;

  const UpcomingItem({
    required this.days,
    required this.badgeColor,
    required this.title,
    required this.dateLabel,
    required this.dateValue,
  });
}

class CareerPathItem {
  final String title;
  final String imagePath;
  final Color bgColor;
  final Color borderColor;

  const CareerPathItem({
    required this.title,
    required this.imagePath,
    required this.bgColor,
    required this.borderColor,
  });
}

// ---------------------- Dashboard Datasets ----------------------

const quickActions = [
  QuickActionItem(
    title: 'Continue\nPreparation',
    imagePath: 'assets/images/dashboard/Glossy Orange Open Book Icon-Photoroom.png',
    bgColor: Color(0xFFFFF4EC),
    borderColor: Color(0xFFFFDEC9),
  ),
  QuickActionItem(
    title: 'Find\nColleges',
    imagePath: 'assets/images/dashboard/explore_find_colleges.png',
    bgColor: Color(0xFFEDF5FF),
    borderColor: Color(0xFFD6E8FE),
  ),
  QuickActionItem(
    title: 'Explore\nCareers',
    imagePath: 'assets/images/dashboard/Glossy Emerald Compass Icon-Photoroom.png',
    bgColor: Color(0xFFEDFBF3),
    borderColor: Color(0xFFD2F5DF),
  ),
  QuickActionItem(
    title: 'Find\nInternships',
    imagePath: 'assets/images/dashboard/explore_internships_briefcase.png',
    bgColor: Color(0xFFFDF0F5),
    borderColor: Color(0xFFFCDCE8),
  ),
];

const preparationItems = [
  PreparationItem(
    title: 'JEE Main',
    imagePath: 'assets/images/dashboard/Glossy Pink Bullseye Dart Icon-Photoroom.png',
    progress: 0.72,
    progressText: '72%',
    accentColor: Color(0xFFF43F5E),
    subtitle: 'Physics',
    metric: '120/165 topics',
  ),
  PreparationItem(
    title: 'JEE Advanced',
    imagePath: 'assets/images/dashboard/Glossy Blue 3D Atom Icon.png',
    progress: 0.48,
    progressText: '48%',
    accentColor: Color(0xFF3B82F6),
    subtitle: 'Mathematics',
    metric: '86/178 topics',
  ),
  PreparationItem(
    title: 'Practice Qs',
    imagePath: 'assets/images/dashboard/Glossy Orange Question Document Icon.png',
    progress: 0.65,
    progressText: '65%',
    accentColor: Color(0xFFF97316),
    subtitle: 'Mixed Practice',
    metric: '320 questions',
  ),
  PreparationItem(
    title: 'Mock Tests',
    imagePath: 'assets/images/dashboard/Glossy Purple Clipboard Checklist-Photoroom.png',
    progress: 0.40,
    progressText: '40%',
    accentColor: Color(0xFF8B5CF6),
    subtitle: '5/12 tests',
    metric: 'attempted',
  ),
];

const recommendedItems = [
  RecommendedItem(
    title: 'Top Engineering\nColleges',
    subtitle: 'NITs, IIITs, Private\n& More',
    imagePath: 'assets/images/dashboard/top_colleges.jpg',
  ),
  RecommendedItem(
    title: 'Popular B.Tech\nCourses',
    subtitle: 'CS, AI/ML, ECE,\nMechanical...',
    imagePath: 'assets/images/dashboard/Glossy Laptop with Floating Blue Gear.png',
  ),
  RecommendedItem(
    title: 'Career Paths\nin Engineering',
    subtitle: 'Roles, Skills\n& Growth',
    imagePath: 'assets/images/dashboard/Friendly 3D Podcast Presenter with Smartphone.png',
  ),
  RecommendedItem(
    title: 'Scholarships\n& Financial Aid',
    subtitle: 'Government,\nPrivate & More',
    imagePath: 'assets/images/dashboard/Navy Graduation Cap and Gold Coins-Photoroom.png',
  ),
];

const upcomingItems = [
  UpcomingItem(
    days: 42,
    badgeColor: Color(0xFFF43F5E),
    title: 'JEE Main 2026',
    dateLabel: 'Exam Date',
    dateValue: '20 Jan 2026',
  ),
  UpcomingItem(
    days: 8,
    badgeColor: Color(0xFF3B82F6),
    title: 'NIT Application Deadline',
    dateLabel: 'Last Date',
    dateValue: '15 Oct 2026',
  ),
];

const careerPathItems = [
  CareerPathItem(
    title: 'Software\nEngineer',
    imagePath: 'assets/images/dashboard/Glossy Purple Coding Laptop Icon.png',
    bgColor: Color(0xFFF5F3FF),
    borderColor: Color(0xFFECE7FE),
  ),
  CareerPathItem(
    title: 'AI/ML\nEngineer',
    imagePath: 'assets/images/dashboard/Glossy Orange AI Microchip Icon.png',
    bgColor: Color(0xFFFFF7ED),
    borderColor: Color(0xFFFFEED9),
  ),
  CareerPathItem(
    title: 'Robotics\nEngineer',
    imagePath: 'assets/images/dashboard/Glossy Blue Industrial Robotic Arm-Photoroom.png',
    bgColor: Color(0xFFEFF6FF),
    borderColor: Color(0xFFDBEAFE),
  ),
  CareerPathItem(
    title: 'Data\nScientist',
    imagePath: 'assets/images/dashboard/Glossy Green Analytics Chart Icon.png',
    bgColor: Color(0xFFF0FDF4),
    borderColor: Color(0xFFDCFCE7),
  ),
];
