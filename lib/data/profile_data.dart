import 'package:flutter/material.dart';

class UserProfileModel {
  final String name;
  final String email;
  final String avatarPath;
  final String selectedClass;
  final String exam;
  final double preparationProgress;

  const UserProfileModel({
    this.name = 'Saurabh Singh',
    this.email = 'saurabh.singh@example.com',
    this.avatarPath = 'assets/images/profile/profile_avatar_student.png',
    this.selectedClass = 'Class 12th',
    this.exam = 'JEE (Main + Advanced)',
    this.preparationProgress = 0.75,
  });
}

class ProfileStatItem {
  final String id;
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final Color borderColor;

  const ProfileStatItem({
    required this.id,
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.borderColor,
  });
}

class ProfileMenuItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const ProfileMenuItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

// ----------------- Datasets -----------------

const defaultUserProfile = UserProfileModel();

const profileStatsList = [
  ProfileStatItem(
    id: 'tests',
    value: '12',
    label: 'Tests Completed',
    icon: Icons.emoji_events_rounded,
    iconColor: Color(0xFFF59E0B),
    bgColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFFEF3C7),
  ),
  ProfileStatItem(
    id: 'score',
    value: '78%',
    label: 'Best Score',
    icon: Icons.military_tech_rounded,
    iconColor: Color(0xFFE11D48),
    bgColor: Color(0xFFFFF1F2),
    borderColor: Color(0xFFFFE4E6),
  ),
  ProfileStatItem(
    id: 'friends',
    value: '15',
    label: 'Study Friends',
    icon: Icons.groups_rounded,
    iconColor: Color(0xFF10B981),
    bgColor: Color(0xFFF0FDF4),
    borderColor: Color(0xFFDCFCE7),
  ),
  ProfileStatItem(
    id: 'opps',
    value: '3',
    label: 'Opportunities',
    icon: Icons.business_center_rounded,
    iconColor: Color(0xFFF97316),
    bgColor: Color(0xFFFFF7ED),
    borderColor: Color(0xFFFFEDD5),
  ),
];

const profileMenuItems = [
  ProfileMenuItem(
    id: 'personal',
    title: 'Personal Information',
    subtitle: 'Name, contact details, date of birth',
    icon: Icons.person_rounded,
    iconColor: Color(0xFF3B82F6),
    iconBgColor: Color(0xFFEFF6FF),
  ),
  ProfileMenuItem(
    id: 'academic',
    title: 'Academic Details',
    subtitle: 'Class, exam, subjects',
    icon: Icons.auto_stories_rounded,
    iconColor: Color(0xFF10B981),
    iconBgColor: Color(0xFFF0FDF4),
  ),
  ProfileMenuItem(
    id: 'settings',
    title: 'App Settings',
    subtitle: 'Notifications, language, preferences',
    icon: Icons.settings_rounded,
    iconColor: Color(0xFF8B5CF6),
    iconBgColor: Color(0xFFF5F3FF),
  ),
  ProfileMenuItem(
    id: 'privacy',
    title: 'Privacy & Security',
    subtitle: 'Manage your data and account security',
    icon: Icons.security_rounded,
    iconColor: Color(0xFFF59E0B),
    iconBgColor: Color(0xFFFFFBEB),
  ),
  ProfileMenuItem(
    id: 'help',
    title: 'Help & Support',
    subtitle: 'FAQs, contact us',
    icon: Icons.help_rounded,
    iconColor: Color(0xFFF43F5E),
    iconBgColor: Color(0xFFFFF1F2),
  ),
];
