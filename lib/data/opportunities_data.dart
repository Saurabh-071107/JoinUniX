import 'package:flutter/material.dart';

class OpportunityCategoryTabItem {
  final String id;
  final String title;
  final String iconPath;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  const OpportunityCategoryTabItem({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.bgColor,
    required this.borderColor,
    this.textColor = const Color(0xFF1E293B),
  });
}

class RecommendedOpportunityItem {
  final String id;
  final String title;
  final String organization;
  final String subtitle;
  final String logoPath;
  final String location;
  final String type;
  final String duration;
  final bool isBookmarked;

  const RecommendedOpportunityItem({
    required this.id,
    required this.title,
    required this.organization,
    required this.subtitle,
    required this.logoPath,
    required this.location,
    required this.type,
    required this.duration,
    this.isBookmarked = false,
  });

  RecommendedOpportunityItem copyWith({bool? isBookmarked}) {
    return RecommendedOpportunityItem(
      id: id,
      title: title,
      organization: organization,
      subtitle: subtitle,
      logoPath: logoPath,
      location: location,
      type: type,
      duration: duration,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

class UpcomingDeadlineItem {
  final String id;
  final String day;
  final String month;
  final Color dateColor;
  final Color dateBgColor;
  final String title;
  final String organization;
  final String categoryTag;
  final Color tagBgColor;
  final Color tagTextColor;

  const UpcomingDeadlineItem({
    required this.id,
    required this.day,
    required this.month,
    required this.dateColor,
    required this.dateBgColor,
    required this.title,
    required this.organization,
    required this.categoryTag,
    required this.tagBgColor,
    required this.tagTextColor,
  });
}

class ExploreMoreItem {
  final String id;
  final String title;
  final String subtitle;
  final String iconPath;
  final Color bgColor;
  final Color borderColor;
  final Color accentColor;

  const ExploreMoreItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.bgColor,
    required this.borderColor,
    required this.accentColor,
  });
}

// ----------------- Datasets -----------------

const opportunityCategoryTabs = [
  OpportunityCategoryTabItem(
    id: 'internships',
    title: 'Internships',
    iconPath: 'assets/images/opportunities/opp_tab_internships.png',
    bgColor: Color(0xFFEEF2FF),
    borderColor: Color(0xFFE0E7FF),
    textColor: Color(0xFF4F46E5),
  ),
  OpportunityCategoryTabItem(
    id: 'competitions',
    title: 'Competitions',
    iconPath: 'assets/images/opportunities/opp_tab_competitions.png',
    bgColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFFEF3C7),
  ),
  OpportunityCategoryTabItem(
    id: 'scholarships',
    title: 'Scholarships',
    iconPath: 'assets/images/opportunities/opp_tab_scholarships.png',
    bgColor: Color(0xFFEFF6FF),
    borderColor: Color(0xFFDBEAFE),
  ),
  OpportunityCategoryTabItem(
    id: 'research',
    title: 'Research',
    iconPath: 'assets/images/opportunities/opp_tab_research.png',
    bgColor: Color(0xFFFFF1F2),
    borderColor: Color(0xFFFFE4E6),
  ),
  OpportunityCategoryTabItem(
    id: 'events',
    title: 'Events',
    iconPath: 'assets/images/opportunities/opp_tab_events.png',
    bgColor: Color(0xFFF0FDF4),
    borderColor: Color(0xFFDCFCE7),
  ),
];

const recommendedOpportunitiesList = [
  RecommendedOpportunityItem(
    id: 'google-sde',
    title: 'Software Development Intern',
    organization: 'Google',
    subtitle: 'Google  •  Summer 2025',
    logoPath: 'assets/images/opportunities/opp_logo_google.png',
    location: 'Bangalore',
    type: 'Internship',
    duration: 'May – Jul 2025',
  ),
  RecommendedOpportunityItem(
    id: 'isro-yuvika',
    title: 'YUVIKA Internship Program',
    organization: 'ISRO',
    subtitle: 'ISRO  •  Research Opportunity',
    logoPath: 'assets/images/opportunities/opp_logo_isro.png',
    location: 'Across India',
    type: 'Internship',
    duration: 'May – Jun 2025',
  ),
  RecommendedOpportunityItem(
    id: 'ms-ambassador',
    title: 'Microsoft Learn Student Ambassadors',
    organization: 'Microsoft',
    subtitle: 'Microsoft  •  Student Program',
    logoPath: 'assets/images/opportunities/opp_logo_microsoft.png',
    location: 'Remote',
    type: 'Leadership',
    duration: 'Year-round',
  ),
];

const upcomingDeadlinesList = [
  UpcomingDeadlineItem(
    id: 'tata-fellowship',
    day: '25',
    month: 'OCT',
    dateColor: Color(0xFFE11D48),
    dateBgColor: Color(0xFFFFF1F2),
    title: 'Tata Innovation Fellowship',
    organization: 'Tata Trusts',
    categoryTag: 'Scholarship',
    tagBgColor: Color(0xFFFCE7F3),
    tagTextColor: Color(0xFFBE185D),
  ),
  UpcomingDeadlineItem(
    id: 'sih-2025',
    day: '30',
    month: 'OCT',
    dateColor: Color(0xFF0284C7),
    dateBgColor: Color(0xFFF0F9FF),
    title: 'SIH 2025',
    organization: 'Govt. of India',
    categoryTag: 'Competition',
    tagBgColor: Color(0xFFDBEAFE),
    tagTextColor: Color(0xFF1D4ED8),
  ),
  UpcomingDeadlineItem(
    id: 'google-winter',
    day: '05',
    month: 'NOV',
    dateColor: Color(0xFF7C3AED),
    dateBgColor: Color(0xFFF5F3FF),
    title: 'Google Winter Internship',
    organization: 'Google',
    categoryTag: 'Internship',
    tagBgColor: Color(0xFFEDE9FE),
    tagTextColor: Color(0xFF6D28D9),
  ),
];

const exploreMoreList = [
  ExploreMoreItem(
    id: 'top-companies',
    title: 'Top Companies',
    subtitle: 'Explore internships from\ntop organizations',
    iconPath: 'assets/images/opportunities/opp_more_companies.png',
    bgColor: Color(0xFFF0FDF4),
    borderColor: Color(0xFFDCFCE7),
    accentColor: Color(0xFF10B981),
  ),
  ExploreMoreItem(
    id: 'hackathons',
    title: 'Hackathons',
    subtitle: 'Compete, build and\nshowcase your skills',
    iconPath: 'assets/images/opportunities/opp_more_hackathons.png',
    bgColor: Color(0xFFFFF1F2),
    borderColor: Color(0xFFFFE4E6),
    accentColor: Color(0xFFF43F5E),
  ),
  ExploreMoreItem(
    id: 'scholarships',
    title: 'Scholarships',
    subtitle: 'Find funding for your\nhigher education',
    iconPath: 'assets/images/opportunities/opp_tab_scholarships.png',
    bgColor: Color(0xFFEFF6FF),
    borderColor: Color(0xFFDBEAFE),
    accentColor: Color(0xFF3B82F6),
  ),
  ExploreMoreItem(
    id: 'research',
    title: 'Research Opportunities',
    subtitle: 'Work with leading faculty\nand organizations',
    iconPath: 'assets/images/opportunities/opp_more_research.png',
    bgColor: Color(0xFFFFFBEB),
    borderColor: Color(0xFFFEF3C7),
    accentColor: Color(0xFFF59E0B),
  ),
];
