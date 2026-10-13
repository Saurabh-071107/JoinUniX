import 'package:flutter/material.dart';

class ExploreFeatureCardItem {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color accentColor;
  final Color buttonColor;
  final Color subColor;
  final String imagePath;

  const ExploreFeatureCardItem({
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.accentColor,
    required this.buttonColor,
    required this.subColor,
    required this.imagePath,
  });
}

class ExplorationProgressItem {
  final String title;
  final String field;
  final double progress;
  final String imagePath;
  final Color accentColor;

  const ExplorationProgressItem({
    required this.title,
    required this.field,
    required this.progress,
    required this.imagePath,
    this.accentColor = const Color(0xFF6366F1),
  });
}

class CollegeCardItem {
  final String name;
  final String location;
  final String imagePath;
  final String ranking;

  const CollegeCardItem({
    required this.name,
    required this.location,
    required this.imagePath,
    this.ranking = '#1 in Tech',
  });
}

// ---------------------- Datasets ----------------------

const exploreFeatureCards = [
  ExploreFeatureCardItem(
    title: 'Find\nColleges',
    subtitle: '500+ Universities\nin India & Abroad',
    bgColor: Color(0xFFF3F1FE),
    accentColor: Color(0xFF3B2F80),
    buttonColor: Color(0xFF6366F1),
    subColor: Color(0xFF64748B),
    imagePath: 'assets/images/dashboard/explore_find_colleges.png',
  ),
  ExploreFeatureCardItem(
    title: 'Explore\nCareers',
    subtitle: 'Discover paths\nthat fit you',
    bgColor: Color(0xFFFFF7ED),
    accentColor: Color(0xFF9A3412),
    buttonColor: Color(0xFFF97316),
    subColor: Color(0xFFB45309),
    imagePath: 'assets/images/dashboard/explore_careers_boy.png',
  ),
  ExploreFeatureCardItem(
    title: 'Study\nAbroad',
    subtitle: '50+ Countries\nGlobal Opportunities',
    bgColor: Color(0xFFF0FDF4),
    accentColor: Color(0xFF065F46),
    buttonColor: Color(0xFF10B981),
    subColor: Color(0xFF047857),
    imagePath: 'assets/images/dashboard/explore_study_abroad_globe.png',
  ),
  ExploreFeatureCardItem(
    title: 'Courses\n& Degrees',
    subtitle: 'Explore 1000+\nCourses',
    bgColor: Color(0xFFEFF6FF),
    accentColor: Color(0xFF1E40AF),
    buttonColor: Color(0xFF3B82F6),
    subColor: Color(0xFF2563EB),
    imagePath: 'assets/images/dashboard/explore_courses_books.png',
  ),
  ExploreFeatureCardItem(
    title: 'Internships\n& Jobs',
    subtitle: 'Gain real-world\nexperience',
    bgColor: Color(0xFFFDF2F8),
    accentColor: Color(0xFF9D174D),
    buttonColor: Color(0xFFEC4899),
    subColor: Color(0xFFBE185D),
    imagePath: 'assets/images/dashboard/explore_internships_briefcase.png',
  ),
  ExploreFeatureCardItem(
    title: 'Events &\nCompetitions',
    subtitle: 'Hackathons,\nWorkshops & More',
    bgColor: Color(0xFFFFFBEB),
    accentColor: Color(0xFF92400E),
    buttonColor: Color(0xFFF59E0B),
    subColor: Color(0xFFB45309),
    imagePath: 'assets/images/dashboard/explore_events_trophy.png',
  ),
];

const inProgressExplorationItems = [
  ExplorationProgressItem(
    title: 'IIT Delhi',
    field: 'Engineering',
    progress: 0.80,
    imagePath: 'assets/images/dashboard/top_colleges.jpg',
    accentColor: Color(0xFF5B4CE8),
  ),
  ExplorationProgressItem(
    title: 'University of Oxford',
    field: 'Computer Science',
    progress: 0.60,
    imagePath: 'assets/images/dashboard/explore_oxford.jpg',
    accentColor: Color(0xFF2563EB),
  ),
  ExplorationProgressItem(
    title: 'Data Science',
    field: 'Career Path',
    progress: 0.40,
    imagePath: 'assets/images/dashboard/explore_data_science_laptop.png',
    accentColor: Color(0xFFEA580C),
  ),
];

const topCollegeItems = [
  CollegeCardItem(
    name: 'IIT Bombay',
    location: 'Mumbai, India',
    imagePath: 'assets/images/dashboard/explore_iit_bombay.jpg',
    ranking: 'NIRF #3',
  ),
  CollegeCardItem(
    name: 'IIT Delhi',
    location: 'New Delhi, India',
    imagePath: 'assets/images/dashboard/top_colleges.jpg',
    ranking: 'NIRF #2',
  ),
  CollegeCardItem(
    name: 'BITS Pilani',
    location: 'Pilani, India',
    imagePath: 'assets/images/dashboard/explore_bits_pilani.jpg',
    ranking: 'Top Private',
  ),
  CollegeCardItem(
    name: 'IISc Bangalore',
    location: 'Bangalore, India',
    imagePath: 'assets/images/dashboard/explore_iisc_bangalore.jpg',
    ranking: 'NIRF #1 Research',
  ),
];
