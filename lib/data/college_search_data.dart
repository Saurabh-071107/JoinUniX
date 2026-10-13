import 'package:flutter/material.dart';

class CollegeItem {
  final String id;
  final String shortName;
  final String fullName;
  final String location;
  final String state;
  final double rating;
  final String reviewCount;
  final String badgeText;
  final Color badgeColor;
  final String imagePath;
  final List<String> tags;
  final String avgFees;
  final String placementRate;
  final String nirfRank;
  final String avgPackage;
  final String examAccepted;
  final String type; // e.g. 'Govt / INI', 'Private Deemed', 'Global University'
  final bool isVerified;
  final bool isFavorite;

  const CollegeItem({
    required this.id,
    required this.shortName,
    required this.fullName,
    required this.location,
    required this.state,
    required this.rating,
    required this.reviewCount,
    required this.badgeText,
    required this.badgeColor,
    required this.imagePath,
    required this.tags,
    required this.avgFees,
    required this.placementRate,
    required this.nirfRank,
    this.avgPackage = '₹18.5 LPA',
    this.examAccepted = 'JEE Advanced',
    this.type = 'Government / INI',
    this.isVerified = true,
    this.isFavorite = false,
  });

  CollegeItem copyWith({bool? isFavorite}) {
    return CollegeItem(
      id: id,
      shortName: shortName,
      fullName: fullName,
      location: location,
      state: state,
      rating: rating,
      reviewCount: reviewCount,
      badgeText: badgeText,
      badgeColor: badgeColor,
      imagePath: imagePath,
      tags: tags,
      avgFees: avgFees,
      placementRate: placementRate,
      nirfRank: nirfRank,
      avgPackage: avgPackage,
      examAccepted: examAccepted,
      type: type,
      isVerified: isVerified,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

const allCollegesList = [
  CollegeItem(
    id: 'iit_bombay',
    shortName: 'IIT Bombay',
    fullName: 'Indian Institute of Technology Bombay',
    location: 'Powai, Mumbai',
    state: 'Maharashtra',
    rating: 4.9,
    reviewCount: '14.2K',
    badgeText: 'NIRF #3 Engineering',
    badgeColor: Color(0xFF4F46E5),
    imagePath: 'assets/images/dashboard/explore_iit_bombay.jpg',
    tags: ['IIT', 'Engineering', 'Govt', 'Research'],
    avgFees: '₹2.1 L / yr',
    placementRate: '96%',
    nirfRank: '#3',
    avgPackage: '₹21.8 LPA',
    examAccepted: 'JEE Advanced',
    type: 'Govt / INI',
    isVerified: true,
  ),
  CollegeItem(
    id: 'iit_delhi',
    shortName: 'IIT Delhi',
    fullName: 'Indian Institute of Technology Delhi',
    location: 'Hauz Khas, New Delhi',
    state: 'Delhi',
    rating: 4.8,
    reviewCount: '12.8K',
    badgeText: 'NIRF #2 Engineering',
    badgeColor: Color(0xFF0284C7),
    imagePath: 'assets/images/dashboard/top_colleges.jpg',
    tags: ['IIT', 'Engineering', 'Govt', 'High Placements'],
    avgFees: '₹2.2 L / yr',
    placementRate: '95%',
    nirfRank: '#2',
    avgPackage: '₹20.5 LPA',
    examAccepted: 'JEE Advanced',
    type: 'Govt / INI',
    isVerified: true,
  ),
  CollegeItem(
    id: 'iisc_bangalore',
    shortName: 'IISc Bangalore',
    fullName: 'Indian Institute of Science Bangalore',
    location: 'Bangalore, Karnataka',
    state: 'Karnataka',
    rating: 4.9,
    reviewCount: '8.7K',
    badgeText: 'NIRF #1 Overall & Research',
    badgeColor: Color(0xFF059669),
    imagePath: 'assets/images/dashboard/explore_iisc_bangalore.jpg',
    tags: ['Research', 'Science', 'Govt', 'Premier'],
    avgFees: '₹35 K / yr',
    placementRate: '98%',
    nirfRank: '#1',
    avgPackage: '₹28.0 LPA',
    examAccepted: 'JEE Adv / GATE / KVPY',
    type: 'Govt / Autonomous',
    isVerified: true,
  ),
  CollegeItem(
    id: 'bits_pilani',
    shortName: 'BITS Pilani',
    fullName: 'Birla Institute of Technology & Science',
    location: 'Pilani, Rajasthan',
    state: 'Rajasthan',
    rating: 4.7,
    reviewCount: '10.5K',
    badgeText: 'Top Private University',
    badgeColor: Color(0xFFD97706),
    imagePath: 'assets/images/dashboard/explore_bits_pilani.jpg',
    tags: ['Private', 'Engineering', 'Autonomous', 'High Placements'],
    avgFees: '₹5.4 L / yr',
    placementRate: '92%',
    nirfRank: '#20',
    avgPackage: '₹19.2 LPA',
    examAccepted: 'BITSAT',
    type: 'Private Deemed',
    isVerified: true,
  ),
  CollegeItem(
    id: 'vit_vellore',
    shortName: 'VIT Vellore',
    fullName: 'Vellore Institute of Technology',
    location: 'Vellore, Tamil Nadu',
    state: 'Tamil Nadu',
    rating: 4.5,
    reviewCount: '16.1K',
    badgeText: 'High Placements Volume',
    badgeColor: Color(0xFF7C3AED),
    imagePath: 'assets/images/dashboard/explore_find_colleges.png',
    tags: ['Private', 'Engineering', 'Placements'],
    avgFees: '₹2.9 L / yr',
    placementRate: '90%',
    nirfRank: '#11',
    avgPackage: '₹9.2 LPA',
    examAccepted: 'VITEEE',
    type: 'Private Deemed',
    isVerified: true,
  ),
  CollegeItem(
    id: 'oxford_univ',
    shortName: 'Univ. of Oxford',
    fullName: 'University of Oxford',
    location: 'Oxford, United Kingdom',
    state: 'International',
    rating: 4.9,
    reviewCount: '25.3K',
    badgeText: 'QS World #3 Global',
    badgeColor: Color(0xFF1E3A8A),
    imagePath: 'assets/images/dashboard/explore_oxford.jpg',
    tags: ['Global', 'Study Abroad', 'Ivy / Elite', 'Research'],
    avgFees: '£28.5 K / yr',
    placementRate: '97%',
    nirfRank: '#3 Global',
    avgPackage: '£65K / yr',
    examAccepted: 'SAT / ACT / IELTS',
    type: 'Collegiate Research',
    isVerified: true,
  ),
  CollegeItem(
    id: 'srm_ist',
    shortName: 'SRM IST',
    fullName: 'SRM Institute of Science and Technology',
    location: 'Kattankulathur, Chennai',
    state: 'Tamil Nadu',
    rating: 4.4,
    reviewCount: '11.4K',
    badgeText: 'NAAC A++ Accredited',
    badgeColor: Color(0xFF2563EB),
    imagePath: 'assets/images/dashboard/explore_iit_bombay.jpg',
    tags: ['Private', 'Engineering', 'Placements'],
    avgFees: '₹2.6 L / yr',
    placementRate: '88%',
    nirfRank: '#18',
    avgPackage: '₹7.8 LPA',
    examAccepted: 'SRMJEEE',
    type: 'Private Deemed',
    isVerified: true,
  ),
];

const collegeCategoryFilters = [
  'All Colleges',
  'Premier IITs & NITs',
  'Research & Science',
  'Top Private',
  'High Placements',
  'Study Abroad',
];
