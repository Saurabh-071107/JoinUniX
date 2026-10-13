import 'package:flutter/material.dart';

typedef StreamOption = ({
  String title,
  String? subtitle,
  String keyName,
  String? imagePath,
  IconData? icon,
  Color bgColor,
  Color borderColor,
});

const _palette = [
  (Color(0xFFF7F8FE), Color(0xFFE4E7FA)),
  (Color(0xFFF3FBF7), Color(0xFFDAEFE5)),
  (Color(0xFFFEFBF2), Color(0xFFF8EED9)),
  (Color(0xFFFDF4FB), Color(0xFFF8E1F3)),
  (Color(0xFFF3F8FE), Color(0xFFDDE8FA)),
  (Color(0xFFFEF8EE), Color(0xFFF8EAD4)),
];


StreamOption _img(String title, String? sub, String file, int i) => (
      title: title,
      subtitle: sub,
      keyName: sub == null ? title : '$title $sub',
      imagePath: 'assets/images/streams/$file.png',
      icon: null,
      bgColor: _palette[i % _palette.length].$1,
      borderColor: _palette[i % _palette.length].$2,
    );

final schoolStreams = [
  _img('Science', '(PCM)', 'science_pcm', 0),
  _img('Science', '(PCB)', 'science_pcb', 1),
  _img('Commerce', null, 'commerce', 2),
  _img('Arts & Humanities', null, 'arts_humanities', 3),
  _img('Vocational', null, 'vocational', 4),
  _img('Not Sure Yet', null, 'not_sure_yet', 5),
];

final ugStreams = [
  _img('Engineering', null, 'engineering', 0),
  _img('Medical', null, 'medical', 1),
  _img('Commerce', null, 'commerce_finance', 2),
  _img('Arts', null, 'arts', 3),
  _img('Law', null, 'law', 4),
  _img('Management', null, 'management', 5),
  _img('Science', null, 'science', 6),
  _img('Other', null, 'other_category', 7),
];

final pgStreams = [
  _img('Masters', null, 'masters', 0),
  _img('PhD', null, 'phd', 1),
  _img('Research', null, 'research', 2),
  _img('MBA', null, 'mba', 3),
  _img('Other', null, 'other_category', 4),
];

const pgFields = {
  'Masters': ['M.Tech', 'M.Sc', 'M.A', 'M.Com', 'MCA', 'M.Pharm', 'LLM', 'MD / MS'],
  'PhD': ['Engineering', 'Science', 'Arts & Humanities', 'Commerce', 'Medical', 'Management', 'Law'],
  'Research': ['Engineering', 'Science', 'Social Sciences', 'Medical', 'Management', 'Humanities'],
  'MBA': ['Finance', 'Marketing', 'HR', 'Operations', 'Business Analytics', 'International Business'],
  'Other': ['Design', 'Education', 'Journalism', 'Architecture', 'Other'],
};

final professions = [
  _img('Engineer', null, 'engineering', 0),
  _img('Teacher', null, 'teacher', 1),
  _img('Doctor', null, 'medical', 2),
  _img('Developer', null, 'developer', 3),
  _img('Designer', null, 'designer', 4),
  _img('Business Owner', null, 'business_owner', 5),
  _img('Finance / Accountant', null, 'commerce_finance', 6),
  _img('Other', null, 'other_category', 7),
];

const experienceRanges = ['0–1 years', '1–3 years', '3–5 years', '5–10 years', '10+ years'];

const schoolClasses = ['Class 8', 'Class 9', 'Class 10'];
const seniorClasses = ['Class 11', 'Class 12'];
const ugYears = ['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year'];
const pgYears = ['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year +'];
