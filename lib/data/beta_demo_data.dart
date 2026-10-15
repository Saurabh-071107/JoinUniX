import 'package:flutter/material.dart';

// Data models for the JoinUniX Beta Demo Workflows

class VisaEmbassyOption {
  final String country;
  final String flag;
  final String visaType;
  final String typicalDuration;
  final String approvalRate;
  final String landmarkAsset;
  final String officerTitle;
  final String legalIntent;
  final String officerAsset;
  final String tiesLabel;

  const VisaEmbassyOption({
    required this.country,
    required this.flag,
    required this.visaType,
    required this.typicalDuration,
    required this.approvalRate,
    this.landmarkAsset = '',
    this.officerTitle = 'Consular Officer (AI Engine)',
    this.legalIntent = 'Evaluating Non-Immigrant Intent (INA 214b)',
    this.officerAsset = '',
    this.tiesLabel = 'Return-to-Home Ties (INA 214b)',
  });
}

const List<VisaEmbassyOption> visaEmbassyOptions = [
  VisaEmbassyOption(
    country: 'United States',
    flag: '🇺🇸',
    visaType: 'F-1 Academic Student Visa',
    typicalDuration: 'Duration: 3 to 5 Minutes',
    approvalRate: '86% High Admit',
    landmarkAsset: 'assets/images/consulai/consulai_landmark_usa.png',
    officerTitle: 'Consular Officer (AI Engine)',
    legalIntent: 'Evaluating Non-Immigrant Intent (INA 214b)',
    officerAsset: 'assets/images/consulai/consulai_officer_us.png',
    tiesLabel: 'Return-to-Home Ties (INA 214b)',
  ),
  VisaEmbassyOption(
    country: 'United Kingdom',
    flag: '🇬🇧',
    visaType: 'Student Route (Tier 4)',
    typicalDuration: 'Duration: Documented / Credibility',
    approvalRate: '94% Approval',
    landmarkAsset: 'assets/images/consulai/consulai_landmark_uk.png',
    officerTitle: 'Home Office Caseworker (AI Engine)',
    legalIntent: 'Evaluating Genuine Student Rule (Tier 4)',
    officerAsset: 'assets/images/consulai/consulai_officer_us.png',
    tiesLabel: 'Return-to-Home Ties (Tier 4 GSR)',
  ),
  VisaEmbassyOption(
    country: 'Germany',
    flag: '🇩🇪',
    visaType: 'National Visa (D-Visa)',
    typicalDuration: 'Duration: APS & Blocked Account',
    approvalRate: '91% Approval',
    landmarkAsset: 'assets/images/consulai/consulai_landmark_germany.png',
    officerTitle: 'Embassy Visa Officer (AI Engine)',
    legalIntent: 'APS & Blocked Account Verification',
    officerAsset: 'assets/images/consulai/consulai_officer_us.png',
    tiesLabel: 'Return-to-Home Ties (D-Visa StBerG)',
  ),
  VisaEmbassyOption(
    country: 'Canada',
    flag: '🇨🇦',
    visaType: 'Study Permit (SDS Stream)',
    typicalDuration: 'Duration: 4 to 6 Weeks Processing',
    approvalRate: '82% Approval',
    landmarkAsset: 'assets/images/consulai/consulai_landmark_canada.png',
    officerTitle: 'IRCC Visa Officer (AI Engine)',
    legalIntent: 'Dual Intent & Financial Admissibility',
    officerAsset: 'assets/images/consulai/consulai_officer_us.png',
    tiesLabel: 'Return-to-Home Ties (IRCC R216)',
  ),
];

class VisaQuestionModel {
  final String id;
  final String officerQuestion;
  final String officerPersonaNote;
  final List<String> quickAnswers;
  final String intentTested;

  const VisaQuestionModel({
    required this.id,
    required this.officerQuestion,
    required this.officerPersonaNote,
    required this.quickAnswers,
    required this.intentTested,
  });
}

const List<VisaQuestionModel> sampleVisaQuestions = [
  VisaQuestionModel(
    id: 'q1',
    officerQuestion: 'Good morning. Why did you choose this specific university over options in your home country?',
    officerPersonaNote: 'Strictly evaluating academic intent & university research depth.',
    intentTested: 'Academic Intent & Institutional Justification',
    quickAnswers: [
      'The M.Sc. in AI program offers specialized labs in Robotics under Prof. Miller, which directly complements my B.Tech project.',
      'This university is ranked top 15 in Systems Engineering with an industry curriculum not currently available domestically.',
    ],
  ),
  VisaQuestionModel(
    id: 'q2',
    officerQuestion: 'Who is sponsoring your education, and how will you cover the ₹45 Lakhs estimated tuition & living costs?',
    officerPersonaNote: 'Probing liquid finances, savings history & non-collateral loan sanction.',
    intentTested: 'Financial Solvency & Liquid Assets',
    quickAnswers: [
      'My parents have sanctioned ₹25 Lakhs in liquid mutual funds, supplemented by an approved ₹30 Lakhs education loan from HDFC Credila.',
      'I hold an official \$15,000 Dean’s Merit Scholarship, with the remainder covered by father’s fixed deposits and bank balance.',
    ],
  ),
  VisaQuestionModel(
    id: 'q3',
    officerQuestion: 'What are your exact career plans once your degree program concludes?',
    officerPersonaNote: 'Checking 214(b) non-immigrant intent: Ties to home country.',
    intentTested: 'Home Ties & Non-Immigrant Intent',
    quickAnswers: [
      'I plan to return to India to join top tech R&D centers as a Senior ML Engineer, where the starting packages for this specialty exceed ₹35 LPA.',
      'I will leverage the global research credentials to expand our family enterprise in Hyderabad into specialized med-tech software.',
    ],
  ),
];

class MentorModel {
  final String name;
  final String university;
  final String degree;
  final String company;
  final String rating;
  final String reviewsCount;
  final String hourlyRate;
  final String flag;
  final String badge;

  const MentorModel({
    required this.name,
    required this.university,
    required this.degree,
    required this.company,
    required this.rating,
    required this.reviewsCount,
    required this.hourlyRate,
    required this.flag,
    required this.badge,
  });
}

const List<MentorModel> sampleMentors = [
  MentorModel(
    name: 'Ananya Sharma',
    university: 'MIT (Massachusetts Inst. of Tech)',
    degree: 'M.S. in Computer Science',
    company: 'Incoming ML Engineer @ Google NYC',
    rating: '4.9',
    reviewsCount: '48 reviews',
    hourlyRate: 'Free 20-min Call',
    flag: '🇺🇸',
    badge: 'Ivy League Fellow',
  ),
  MentorModel(
    name: 'Rohan Deshmukh',
    university: 'TU Munich (Germany)',
    degree: 'M.Sc. Automotive Software',
    company: 'Software Architect @ BMW Munich',
    rating: '4.8',
    reviewsCount: '32 reviews',
    hourlyRate: 'Free 20-min Call',
    flag: '🇩🇪',
    badge: '€0 Tuition Expert',
  ),
  MentorModel(
    name: 'Kavya Nair',
    university: 'University of Oxford (UK)',
    degree: 'M.Phil Economics & Finance',
    company: 'Analyst @ Goldman Sachs London',
    rating: '5.0',
    reviewsCount: '64 reviews',
    hourlyRate: 'Free 20-min Call',
    flag: '🇬🇧',
    badge: 'Chevening Scholar',
  ),
];

class SharkTankPitchModel {
  final String title;
  final String founder;
  final String college;
  final String category;
  final String askAmount;
  final String valuation;
  final int votes;
  final String summary;

  const SharkTankPitchModel({
    required this.title,
    required this.founder,
    required this.college,
    required this.category,
    required this.askAmount,
    required this.valuation,
    required this.votes,
    required this.summary,
  });
}

const List<SharkTankPitchModel> sampleSharkTankPitches = [
  SharkTankPitchModel(
    title: 'MedDrone Logistics',
    founder: 'Aarav Patel & Team',
    college: 'IIT Bombay',
    category: 'HealthTech & AI',
    askAmount: '₹20,00,000 for 5%',
    valuation: '₹4.0 Cr Valuation',
    votes: 1420,
    summary: 'Autonomous medical delivery drones for emergency organ & blood transport between tier-2 hospitals.',
  ),
  SharkTankPitchModel(
    title: 'GreenFold Bio-Pack',
    founder: 'Pooja Hegde',
    college: 'BITS Pilani',
    category: 'CleanTech & ESG',
    askAmount: '₹15,00,000 for 7%',
    valuation: '₹2.1 Cr Valuation',
    votes: 980,
    summary: '100% biodegradable seaweed food packaging replacing single-use styrofoam on college campuses.',
  ),
  SharkTankPitchModel(
    title: 'CodeTutor AI',
    founder: 'Karan Verma',
    college: 'NIT Trichy',
    category: 'EdTech',
    askAmount: '₹10,00,000 for 4%',
    valuation: '₹2.5 Cr Valuation',
    votes: 1890,
    summary: 'Voice-interactive pair programming tutor that coaches students in real-time during coding contests.',
  ),
];

class StockEquityModel {
  final String symbol;
  final String companyName;
  final double currentPrice;
  final double dayChange;
  final double changePercent;
  final String exchange;

  const StockEquityModel({
    required this.symbol,
    required this.companyName,
    required this.currentPrice,
    required this.dayChange,
    required this.changePercent,
    required this.exchange,
  });
}

const List<StockEquityModel> sampleStocks = [
  StockEquityModel(
    symbol: 'RELIANCE',
    companyName: 'Reliance Industries Ltd',
    currentPrice: 2840.50,
    dayChange: 32.40,
    changePercent: 1.15,
    exchange: 'NSE',
  ),
  StockEquityModel(
    symbol: 'TCS',
    companyName: 'Tata Consultancy Services',
    currentPrice: 3950.00,
    dayChange: -18.20,
    changePercent: -0.46,
    exchange: 'NSE',
  ),
  StockEquityModel(
    symbol: 'INFY',
    companyName: 'Infosys Technologies',
    currentPrice: 1720.75,
    dayChange: 24.10,
    changePercent: 1.42,
    exchange: 'NSE',
  ),
  StockEquityModel(
    symbol: 'NVDA',
    companyName: 'NVIDIA Corporation',
    currentPrice: 910.25,
    dayChange: 42.80,
    changePercent: 4.93,
    exchange: 'NASDAQ',
  ),
];

class CompareUniversityModel {
  final String name;
  final String location;
  final String flag;
  final String qsRank;
  final String annualTuition;
  final String livingExpense;
  final String postStudyWork;
  final String acceptanceRate;
  final String minIelts;

  const CompareUniversityModel({
    required this.name,
    required this.location,
    required this.flag,
    required this.qsRank,
    required this.annualTuition,
    required this.livingExpense,
    required this.postStudyWork,
    required this.acceptanceRate,
    required this.minIelts,
  });
}

const List<CompareUniversityModel> compareUniverseList = [
  CompareUniversityModel(
    name: 'MIT (Massachusetts)',
    location: 'Cambridge, USA',
    flag: '🇺🇸',
    qsRank: '#1 Globally',
    annualTuition: '\$59,750 / yr',
    livingExpense: '\$21,000 / yr',
    postStudyWork: '3 Years (STEM OPT)',
    acceptanceRate: '4.8% Very Selective',
    minIelts: '7.5+ Band',
  ),
  CompareUniversityModel(
    name: 'University of Oxford',
    location: 'Oxford, UK',
    flag: '🇬🇧',
    qsRank: '#3 Globally',
    annualTuition: '£33,500 / yr',
    livingExpense: '£15,000 / yr',
    postStudyWork: '2 Years (Graduate Visa)',
    acceptanceRate: '14.2% Selective',
    minIelts: '7.5+ Band',
  ),
  CompareUniversityModel(
    name: 'TU Munich (TUM)',
    location: 'Munich, Germany',
    flag: '🇩🇪',
    qsRank: '#28 Globally',
    annualTuition: '€0 (Public Waiver)',
    livingExpense: '€11,208 / yr',
    postStudyWork: '18 Months Job Seeker',
    acceptanceRate: '22% Competitive',
    minIelts: '6.5+ Band',
  ),
  CompareUniversityModel(
    name: 'University of Toronto',
    location: 'Toronto, Canada',
    flag: '🇨🇦',
    qsRank: '#21 Globally',
    annualTuition: 'CAD \$42,000 / yr',
    livingExpense: 'CAD \$18,000 / yr',
    postStudyWork: '3 Years (PGWP)',
    acceptanceRate: '43% Balanced',
    minIelts: '6.5+ Band',
  ),
];

// 1. Consultancies Directory Models
class ConsultancyAgencyModel {
  final String name;
  final String city;
  final String area;
  final String rating;
  final String reviewsCount;
  final int counselorsCount;
  final List<String> certifications;
  final List<String> destinations;
  final String successRate;
  final String description;

  const ConsultancyAgencyModel({
    required this.name,
    required this.city,
    required this.area,
    required this.rating,
    required this.reviewsCount,
    required this.counselorsCount,
    required this.certifications,
    required this.destinations,
    required this.successRate,
    required this.description,
  });
}

const List<ConsultancyAgencyModel> sampleConsultancies = [
  ConsultancyAgencyModel(
    name: 'GlobalEdu Pathways',
    city: 'Bangalore',
    area: 'Indiranagar / Koramangala',
    rating: '4.9',
    reviewsCount: '280+ Reviews',
    counselorsCount: 24,
    certifications: ['British Council Certified', 'AIRC Accredited', 'ICEF Trained'],
    destinations: ['USA', 'UK', 'Germany', 'Canada', 'Australia'],
    successRate: '98.2% Visa Success',
    description: 'Premier overseas admissions, high-admit visas & global mentorship in Bangalore.',
  ),
  ConsultancyAgencyModel(
    name: 'Vanguard Overseas Education',
    city: 'Hyderabad',
    area: 'Jubilee Hills / Hitec City',
    rating: '4.95',
    reviewsCount: '340+ Reviews',
    counselorsCount: 30,
    certifications: ['US News Global Ed Partner', 'British Council', 'PIER Certified'],
    destinations: ['USA', 'UK', 'Germany', 'Ireland'],
    successRate: '99.1% Visa Success',
    description: 'Specialized in Ivy League STEM admissions & non-collateral loan sanction tie-ups.',
  ),
  ConsultancyAgencyModel(
    name: 'Apex Global Scholars',
    city: 'Mumbai',
    area: 'BKC / Andheri West',
    rating: '4.85',
    reviewsCount: '190+ Reviews',
    counselorsCount: 18,
    certifications: ['AIRC Accredited', 'ICEF Gold Partner'],
    destinations: ['USA', 'UK', 'Singapore', 'Canada'],
    successRate: '97.8% Visa Success',
    description: 'Direct institutional tie-ups with top 100 global business and engineering schools.',
  ),
  ConsultancyAgencyModel(
    name: 'TransWorld Education Group',
    city: 'New Delhi',
    area: 'Connaught Place / Nehru Place',
    rating: '4.9',
    reviewsCount: '220+ Reviews',
    counselorsCount: 22,
    certifications: ['British Council', 'DAAD Recognized Partner'],
    destinations: ['Germany', 'UK', 'France', 'USA'],
    successRate: '98.5% Visa Success',
    description: 'North India leading study abroad agency for Germany €0 tuition public universities.',
  ),
];

// 2. Country Guides Models
class CountryGuideModel {
  final String country;
  final String flag;
  final String pswvYears;
  final String avgTuition;
  final String livingCost;
  final String visaProcessing;
  final int topUniversitiesCount;
  final String visaCategory;
  final String prPathway;
  final String highlight;

  const CountryGuideModel({
    required this.country,
    required this.flag,
    required this.pswvYears,
    required this.avgTuition,
    required this.livingCost,
    required this.visaProcessing,
    required this.topUniversitiesCount,
    required this.visaCategory,
    required this.prPathway,
    required this.highlight,
  });

  String get landmarkAsset => switch (country) {
        'United States' => 'assets/images/consulai/consulai_landmark_usa.png',
        'United Kingdom' => 'assets/images/consulai/consulai_landmark_uk.png',
        'Germany' => 'assets/images/consulai/consulai_landmark_germany.png',
        'Canada' => 'assets/images/consulai/consulai_landmark_canada.png',
        _ => 'assets/images/consulai/consulai_landmark_usa.png',
      };
}

const List<CountryGuideModel> sampleCountryGuides = [
  CountryGuideModel(
    country: 'United States',
    flag: '🇺🇸',
    pswvYears: 'Up to 3 Years (STEM OPT)',
    avgTuition: '\$28,000 - \$65,000 / yr',
    livingCost: '\$15,000 - \$22,000 / yr',
    visaProcessing: '3 to 6 Weeks',
    topUniversitiesCount: 450,
    visaCategory: 'F-1 Academic Visa',
    prPathway: 'H-1B Lottery ➔ EB-2 / EB-3 NIW Green Card',
    highlight: 'Highest global tech & AI starting salaries (\$115k+ median).',
  ),
  CountryGuideModel(
    country: 'United Kingdom',
    flag: '🇬🇧',
    pswvYears: '2 Years (3 Yrs for PhD)',
    avgTuition: '£16,000 - £38,000 / yr',
    livingCost: '£12,000 - £16,000 / yr',
    visaProcessing: '3 Weeks Fast Track',
    topUniversitiesCount: 160,
    visaCategory: 'Student Route (Tier 4)',
    prPathway: 'Skilled Worker Visa (5 Years ➔ ILR Permanent Residency)',
    highlight: '1-Year Master’s degrees cut living costs in half.',
  ),
  CountryGuideModel(
    country: 'Germany',
    flag: '🇩🇪',
    pswvYears: '18 Months Job Seeker',
    avgTuition: '€0 - €3,000 / yr (Public TU9)',
    livingCost: '€11,208 / yr (Mandatory Blocked Acc)',
    visaProcessing: '4 to 8 Weeks',
    topUniversitiesCount: 380,
    visaCategory: 'National Visa (D-Visa)',
    prPathway: 'EU Blue Card ➔ Fast-track PR in 21 Months',
    highlight: 'World-renowned tuition-free engineering and tech degrees.',
  ),
  CountryGuideModel(
    country: 'Canada',
    flag: '🇨🇦',
    pswvYears: 'Up to 3 Years (PGWP)',
    avgTuition: 'CAD \$20,000 - \$45,000 / yr',
    livingCost: 'CAD \$14,000 - \$20,000 / yr',
    visaProcessing: '4 to 8 Weeks (SDS Stream)',
    topUniversitiesCount: 110,
    visaCategory: 'Study Permit (SDS)',
    prPathway: 'Canadian Experience Class (CEC) ➔ Express Entry PR',
    highlight: 'Most structured post-graduation immigration system.',
  ),
];

// 3. After 12th Career Pathways
class After12thPathwayModel {
  final String title;
  final String stream;
  final String duration;
  final String totalCost;
  final String eligibility;
  final String recognition;
  final List<String> benefits;
  final String icon;

  const After12thPathwayModel({
    required this.title,
    required this.stream,
    required this.duration,
    required this.totalCost,
    required this.eligibility,
    required this.recognition,
    required this.benefits,
    required this.icon,
  });
}

const List<After12thPathwayModel> sample12thPathways = [
  After12thPathwayModel(
    title: 'MBBS Abroad (NMC & WHO Approved)',
    stream: 'Medical',
    duration: '5.5 to 6 Years',
    totalCost: '₹22 - ₹35 Lakhs Complete Package',
    eligibility: 'NEET Qualified · 50% in 12th PCB',
    recognition: 'NMC / WHO / ECFMG Recognized',
    benefits: [
      '100% English Medium Curriculum',
      'Indian Mess with Vegetarian food',
      'Integrated NExT & USMLE coaching',
      'Georgia, Uzbekistan & Russia top universities',
    ],
    icon: '🩺',
  ),
  After12thPathwayModel(
    title: 'B.Sc Nursing & Paramedical Abroad',
    stream: 'Paramedical',
    duration: '3 to 4 Years',
    totalCost: '₹8 - ₹15 Lakhs (or Paid Ausbildung)',
    eligibility: '12th Science (PCB/PCM) 45%+',
    recognition: 'NHS UK / German Health Board',
    benefits: [
      'Direct UK NHS Band 5 hospital sponsorship',
      'German Ausbildung: €1,200/month stipend while studying',
      'Zero tuition fee public nursing institutes',
      'Guaranteed post-study employment placement',
    ],
    icon: '🏥',
  ),
  After12thPathwayModel(
    title: 'B.Tech in AI & German B.S. Engineering',
    stream: 'Engineering',
    duration: '3.5 to 4 Years',
    totalCost: '€0 Public Tuition (Living only)',
    eligibility: '12th PCM 65%+ · JEE / TestAS optional',
    recognition: 'TU9 German Universities / Global ABET',
    benefits: [
      '€0 tuition fee at top German public institutes',
      'English-taught Computer Science & AI degrees',
      'Paid industry internships with BMW, Siemens, SAP',
      '18-month European Job Seeker Visa post-graduation',
    ],
    icon: '⚡',
  ),
];

// 4. CBT Exam Question Model
class CbtQuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String subject;
  final String topic;

  const CbtQuestionModel({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.subject,
    required this.topic,
  });
}

const List<CbtQuestionModel> sampleCbtQuestions = [
  CbtQuestionModel(
    question: 'A particle executes SHM with amplitude A. At what displacement from the mean position is its kinetic energy equal to its potential energy?',
    options: ['A / 2', 'A / √2', 'A / √3', 'A / 4'],
    correctIndex: 1,
    subject: 'Physics',
    topic: 'Oscillations & Waves',
  ),
  CbtQuestionModel(
    question: 'Which of the following compounds exhibits optical isomerism and has a chiral center?',
    options: ['2-Chlorobutane', '1-Chlorobutane', '2-Chloropropane', 'Chlorobenzene'],
    correctIndex: 0,
    subject: 'Chemistry',
    topic: 'Organic Chemistry',
  ),
  CbtQuestionModel(
    question: 'If the roots of the equation x² - bx + c = 0 are two consecutive integers, then b² - 4c equals:',
    options: ['-1', '0', '1', '2'],
    correctIndex: 2,
    subject: 'Mathematics',
    topic: 'Quadratic Equations',
  ),
];

// 5. NIRF Indian College Model
class NirfCollegeModel {
  final int rank;
  final String name;
  final String location;
  final String category;
  final String cutoff;
  final String medianPkg;
  final String annualFee;
  final String imageAsset;

  const NirfCollegeModel({
    required this.rank,
    required this.name,
    required this.location,
    required this.category,
    required this.cutoff,
    required this.medianPkg,
    required this.annualFee,
    this.imageAsset = 'assets/images/dashboard/nirf_iit_madras.jpg',
  });
}

const List<NirfCollegeModel> sampleNirfColleges = [
  NirfCollegeModel(
    rank: 1,
    name: 'IIT Madras',
    location: 'Chennai, Tamil Nadu',
    category: 'Engineering & Tech',
    cutoff: 'JEE Adv Rank: Top 85 - 180',
    medianPkg: '₹21.48 LPA',
    annualFee: '₹2.2 Lakhs / yr',
    imageAsset: 'assets/images/dashboard/nirf_iit_madras.jpg',
  ),
  NirfCollegeModel(
    rank: 2,
    name: 'IIT Bombay',
    location: 'Mumbai, Maharashtra',
    category: 'Engineering & AI',
    cutoff: 'JEE Adv Rank: Top 60 - 150',
    medianPkg: '₹22.70 LPA',
    annualFee: '₹2.3 Lakhs / yr',
    imageAsset: 'assets/images/dashboard/iit_bombay_main.jpg',
  ),
  NirfCollegeModel(
    rank: 1,
    name: 'AIIMS New Delhi',
    location: 'New Delhi, Delhi NCR',
    category: 'Medical Sciences',
    cutoff: 'NEET UG: AIR 1 - 55',
    medianPkg: '₹18.50 LPA',
    annualFee: '₹1,628 / yr',
    imageAsset: 'assets/images/dashboard/nirf_aiims_delhi.jpg',
  ),
  NirfCollegeModel(
    rank: 1,
    name: 'IIM Ahmedabad',
    location: 'Ahmedabad, Gujarat',
    category: 'Management',
    cutoff: 'CAT: 99.85+ Percentile',
    medianPkg: '₹34.36 LPA',
    annualFee: '₹25.0 Lakhs Total',
    imageAsset: 'assets/images/dashboard/nirf_iim_ahmedabad.jpg',
  ),
];

// 6. Application Tracker Milestones
class ApplicationMilestoneModel {
  final String step;
  final String date;
  final bool isCompleted;
  final bool isCurrent;
  final String description;

  const ApplicationMilestoneModel({
    required this.step,
    required this.date,
    required this.isCompleted,
    required this.isCurrent,
    required this.description,
  });
}

const List<ApplicationMilestoneModel> sampleMilestones = [
  ApplicationMilestoneModel(
    step: '1. Profile Evaluation & Shortlisting',
    date: 'Completed Jan 15',
    isCompleted: true,
    isCurrent: false,
    description: 'Selected MIT, Stanford, TUM & Oxford based on GPA and test scores.',
  ),
  ApplicationMilestoneModel(
    step: '2. AI Document Studio (SOP & LORs)',
    date: 'Completed Feb 02',
    isCompleted: true,
    isCurrent: false,
    description: 'Statement of Purpose drafted with 0% plagiarism & 3 academic LORs secured.',
  ),
  ApplicationMilestoneModel(
    step: '3. Official University Submissions',
    date: 'Submitted Feb 18',
    isCompleted: true,
    isCurrent: false,
    description: 'Application portals submitted with fee waiver codes applied.',
  ),
  ApplicationMilestoneModel(
    step: '4. Offer Letter & I-20 / CAS Issuance',
    date: 'Expected March 25',
    isCompleted: false,
    isCurrent: true,
    description: 'Admit packet received from TUM! Awaiting Stanford official decision.',
  ),
  ApplicationMilestoneModel(
    step: '5. Consular Visa Mock & Embassy Filing',
    date: 'Upcoming May 10',
    isCompleted: false,
    isCurrent: false,
    description: 'ConsulAI adaptive voice interview prep & DS-160 financial documentation.',
  ),
];

// 7. Event Mega Fair Model
class EventFairModel {
  final String title;
  final String date;
  final String time;
  final String venue;
  final int participatingUnis;
  final String feeWaiver;
  final String description;

  const EventFairModel({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.participatingUnis,
    required this.feeWaiver,
    required this.description,
  });
}

const List<EventFairModel> sampleEventsList = [
  EventFairModel(
    title: 'Global University Mega Fair 2026',
    date: 'Saturday, March 28, 2026',
    time: '10:00 AM - 5:00 PM IST',
    venue: 'Convention Center & Live Virtual Stream',
    participatingUnis: 65,
    feeWaiver: '\$150 / ₹12,500 App Fee Waiver',
    description: 'Meet official admissions delegates from University of Toronto, Oxford, Imperial, and TUM for direct on-the-spot profile evaluations.',
  ),
  EventFairModel(
    title: 'German Embassy National Visa & APS Masterclass',
    date: 'Thursday, April 09, 2026',
    time: '6:30 PM - 8:00 PM IST',
    venue: 'Live Zoom & YouTube Stream',
    participatingUnis: 12,
    feeWaiver: 'Free APS Verification Guide',
    description: 'Official session by German consular experts covering APS certificate expedites, €11,208 blocked accounts, and EU Blue Card pathways.',
  ),
];

// 8. Scholarship Model
class ScholarshipModel {
  final String title;
  final String provider;
  final String amount;
  final String deadline;
  final String country;
  final String type;

  const ScholarshipModel({
    required this.title,
    required this.provider,
    required this.amount,
    required this.deadline,
    required this.country,
    required this.type,
  });
}

const List<ScholarshipModel> sampleScholarshipsList = [
  ScholarshipModel(
    title: 'Dean’s International Merit Fellowship',
    provider: 'Global University Consortium',
    amount: 'Up to \$25,000 Tuition Waiver',
    deadline: 'April 15, 2026',
    country: 'United States',
    type: 'Merit-Based',
  ),
  ScholarshipModel(
    title: 'DAAD Helmut-Schmidt Masters Grant',
    provider: 'German Academic Exchange Service',
    amount: '100% Tuition + €934/month Living',
    deadline: 'July 31, 2026',
    country: 'Germany',
    type: 'Full-Ride Govt',
  ),
  ScholarshipModel(
    title: 'British Council Great Scholarship',
    provider: 'UK Government & Universities',
    amount: '£10,000 Direct Tuition Credit',
    deadline: 'May 30, 2026',
    country: 'United Kingdom',
    type: 'Merit-Based',
  ),
];

// 9. Courses & Intakes Explorer Models
class CourseIntakeModel {
  final String title;
  final String degree;
  final String university;
  final String location;
  final String flag;
  final String duration;
  final String tuitionAnnual;
  final String deadlineFall;
  final String deadlineSpring;
  final String minGpa;
  final String minIelts;

  const CourseIntakeModel({
    required this.title,
    required this.degree,
    required this.university,
    required this.location,
    required this.flag,
    required this.duration,
    required this.tuitionAnnual,
    required this.deadlineFall,
    required this.deadlineSpring,
    required this.minGpa,
    required this.minIelts,
  });

  String get campusPhoto => switch (university) {
        String u when u.contains('Massachusetts') || u.contains('MIT') =>
          'assets/images/abroad/campus_header_dome.png',
        String u when u.contains('Munich') || u.contains('TUM') =>
          'assets/images/consulai/consulai_landmark_germany.png',
        String u when u.contains('Stanford') =>
          'assets/images/uniquest/uniquest_campus_hero.png',
        String u when u.contains('Oxford') =>
          'assets/images/consulai/consulai_landmark_uk.png',
        String u when u.contains('Toronto') =>
          'assets/images/consulai/consulai_landmark_canada.png',
        _ => 'assets/images/abroad/campus_header_dome.png',
      };

  String get logoInitials => switch (university) {
        String u when u.contains('Massachusetts') || u.contains('MIT') => 'MIT',
        String u when u.contains('Munich') || u.contains('TUM') => 'TUM',
        String u when u.contains('Stanford') => 'S',
        String u when u.contains('Oxford') => 'OX',
        String u when u.contains('Toronto') => 'UofT',
        _ => 'UNI',
      };

  Color get brandColor => switch (university) {
        String u when u.contains('Massachusetts') || u.contains('MIT') => const Color(0xFFA31F34),
        String u when u.contains('Munich') || u.contains('TUM') => const Color(0xFF0065BD),
        String u when u.contains('Stanford') => const Color(0xFF8C1515),
        String u when u.contains('Oxford') => const Color(0xFF002147),
        String u when u.contains('Toronto') => const Color(0xFF002A5C),
        _ => const Color(0xFF0F62FE),
      };
}

const List<CourseIntakeModel> sampleCoursesList = [
  CourseIntakeModel(
    title: 'M.Sc. Artificial Intelligence & Robotics',
    degree: 'Masters (M.Sc.)',
    university: 'Massachusetts Institute of Technology',
    location: 'Cambridge, MA, USA',
    flag: '🇺🇸',
    duration: '2 Years (64 Credits)',
    tuitionAnnual: '\$59,750 / yr',
    deadlineFall: 'Dec 15, 2026',
    deadlineSpring: 'Not Offered (Fall Only)',
    minGpa: '3.7 / 4.0 (8.5+ CGPA)',
    minIelts: 'English: 7.5+ Band / 100+ TOEFL',
  ),
  CourseIntakeModel(
    title: 'M.Sc. Automotive & Autonomous Software',
    degree: 'Masters (M.Sc.)',
    university: 'Technical University of Munich',
    location: 'Munich, Germany',
    flag: '🇩🇪',
    duration: '2 Years (120 ECTS)',
    tuitionAnnual: '€0 (Public Waiver) (Living only)',
    deadlineFall: 'May 31, 2026',
    deadlineSpring: 'Nov 30, 2026',
    minGpa: '3.0 / 4.0 (7.5+ CGPA)',
    minIelts: 'English: 6.5+ Band (APS Mandatory)',
  ),
  CourseIntakeModel(
    title: 'M.Sc. Computer Science',
    degree: 'Masters (M.Sc.)',
    university: 'Stanford University',
    location: 'Stanford, CA, USA',
    flag: '🇺🇸',
    duration: '2 Years',
    tuitionAnnual: '\$62,484 / yr',
    deadlineFall: 'Dec 01, 2026',
    deadlineSpring: 'Not Offered (Fall Only)',
    minGpa: '3.8 / 4.0 (8.8+ CGPA)',
    minIelts: 'English: 7.5+ Band / 100+ TOEFL',
  ),
  CourseIntakeModel(
    title: 'Full-Time MBA & Global Leadership',
    degree: 'MBA',
    university: 'Oxford Saïd Business School',
    location: 'Oxford, United Kingdom',
    flag: '🇬🇧',
    duration: '1 Year Accelerated',
    tuitionAnnual: '£71,440 Total',
    deadlineFall: 'March 20, 2026 (Round 3)',
    deadlineSpring: 'Not Offered',
    minGpa: '3.5 / 4.0 · 3+ Yrs Work Exp',
    minIelts: '7.5+ Band / GMAT 690+',
  ),
  CourseIntakeModel(
    title: 'B.S. Computer Science & Data Systems',
    degree: 'Bachelors (B.S.)',
    university: 'University of Toronto',
    location: 'Toronto, Canada',
    flag: '🇨🇦',
    duration: '4 Years (Co-op Included)',
    tuitionAnnual: 'CAD \$58,000 / yr',
    deadlineFall: 'Jan 15, 2026 (OUAC 105)',
    deadlineSpring: 'Not Offered',
    minGpa: '85%+ in 12th Standard',
    minIelts: '6.5+ Band',
  ),
];

// 10. Campus Deck & 360 Tour Models
class CampusDeckModel {
  final String university;
  final String location;
  final String flag;
  final String qsRank;
  final String studentFacultyRatio;
  final String acceptanceRate;
  final String campusSize;
  final List<String> topResearchLabs;
  final List<String> highlights;
  final String overview;

  const CampusDeckModel({
    required this.university,
    required this.location,
    required this.flag,
    required this.qsRank,
    required this.studentFacultyRatio,
    required this.acceptanceRate,
    required this.campusSize,
    required this.topResearchLabs,
    required this.highlights,
    required this.overview,
  });
}

const List<CampusDeckModel> sampleCampusDecks = [
  CampusDeckModel(
    university: 'Massachusetts Institute of Technology (MIT)',
    location: 'Cambridge, MA, United States',
    flag: '🇺🇸',
    qsRank: '#1 World University Ranking',
    studentFacultyRatio: '3:1 Ultra-low ratio',
    acceptanceRate: '4.8% Highly Selective',
    campusSize: '168 Acres on Charles River',
    topResearchLabs: [
      'CSAIL (Computer Science & AI Lab)',
      'MIT Media Lab (Interactive Tech)',
      'Koch Institute for Integrative Cancer Research',
      'Plasma Science & Fusion Center',
    ],
    highlights: [
      '101 Nobel Laureates affiliated',
      'Over \$800 Million sponsored annual research budget',
      'Need-blind admissions for international applicants',
      'Direct cross-registration with Harvard University',
    ],
    overview: 'World leader in scientific and technological breakthrough research with state-of-the-art incubation facilities.',
  ),
  CampusDeckModel(
    university: 'Technical University of Munich (TUM)',
    location: 'Munich, Bavaria, Germany',
    flag: '🇩🇪',
    qsRank: '#28 World / #1 in Germany',
    studentFacultyRatio: '14:1',
    acceptanceRate: '22% Competitive',
    campusSize: 'Garching Science City & Downtown',
    topResearchLabs: [
      'Munich Data Science Institute (MDSI)',
      'TUM Venture Labs (DeepTech Incubator)',
      'Munich Institute of Robotics and Machine Intelligence',
    ],
    highlights: [
      '€0 Tuition fees for engineering degrees',
      'Direct industrial partnerships with BMW, Siemens & Airbus',
      'English-taught master programs in AI and Aerospace',
      '18-month European Job Seeker Visa post-graduation',
    ],
    overview: 'German University of Excellence driving automotive innovation, medtech, and European startup spin-offs.',
  ),
];

// 11. AI Hackathons Model
class HackathonModel {
  final String title;
  final String organizer;
  final String prizePool;
  final String deadline;
  final String teamSize;
  final String format;
  final String theme;

  const HackathonModel({
    required this.title,
    required this.organizer,
    required this.prizePool,
    required this.deadline,
    required this.teamSize,
    required this.format,
    required this.theme,
  });
}

const List<HackathonModel> sampleHackathons = [
  HackathonModel(
    title: 'JoinUniX Global AI Agent Sprint 2026',
    organizer: 'JoinUniX & Global Tech Partners',
    prizePool: '₹5,00,000 + \$25k Cloud Credits',
    deadline: 'April 20, 2026',
    teamSize: '2 to 4 Members',
    format: '48-Hour Virtual Sprint',
    theme: 'Autonomous Multi-Agent Systems in Education & FinTech',
  ),
  HackathonModel(
    title: 'CleanTech Campus Innovation Cup',
    organizer: 'TUM Venture Labs & IIT Bombay',
    prizePool: '€10,000 Seed Grant + Incubation',
    deadline: 'May 12, 2026',
    teamSize: '1 to 5 Members',
    format: 'Hybrid (Online + Finale in Munich)',
    theme: 'Circular Economy, Battery Storage & Bio-Materials',
  ),
];

// 12. Student Internships Model
class InternshipModel {
  final String title;
  final String organization;
  final String location;
  final String stipend;
  final String duration;
  final String workType;
  final List<String> requiredSkills;

  const InternshipModel({
    required this.title,
    required this.organization,
    required this.location,
    required this.stipend,
    required this.duration,
    required this.workType,
    required this.requiredSkills,
  });
}

const List<InternshipModel> sampleInternships = [
  InternshipModel(
    title: 'AI & Data Science Research Intern',
    organization: 'JoinUniX AI Labs',
    location: 'Remote / Bangalore Hub',
    stipend: '₹35,000 / month',
    duration: '3 Months (Full-Time)',
    workType: 'Remote',
    requiredSkills: ['Python', 'PyTorch / TensorFlow', 'LLM Prompt Engineering', 'Git'],
  ),
  InternshipModel(
    title: 'Overseas Student Counselor Trainee',
    organization: 'GlobalEdu Pathways',
    location: 'Indiranagar, Bangalore',
    stipend: '₹22,000 / month + Incentives',
    duration: '6 Months',
    workType: 'In-Office',
    requiredSkills: ['Study Abroad Knowledge', 'Communication', 'CRM Management'],
  ),
  InternshipModel(
    title: 'Mobile App Developer Intern (Flutter)',
    organization: 'EdTech Venture Labs',
    location: 'Remote / Hyderabad',
    stipend: '₹30,000 / month',
    duration: '3 to 6 Months',
    workType: 'Remote',
    requiredSkills: ['Flutter / Dart', 'REST APIs', 'State Management', 'UI/UX'],
  ),
];
