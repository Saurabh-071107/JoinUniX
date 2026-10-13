import 'package:flutter/material.dart';
import 'data/onboarding_options.dart';
import 'screens/academic_stage_screen.dart';
import 'screens/career_interests_screen.dart';
import 'screens/class_selection_screen.dart';
import 'screens/future_goals_screen.dart';
import 'screens/home_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/mobile_number_screen.dart';
import 'screens/name_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/profile_ready_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/stream_screen.dart';
import 'screens/study_location_screen.dart';

void main() {
  runApp(const JoinUnixApp());
}

class JoinUnixApp extends StatelessWidget {
  const JoinUnixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JoinUNiX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F62FE),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F62FE),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreenHost(),
    );
  }
}

enum AppScreenStep { splash, intro, mobileNumber, otp, name, stage, stream, classSelection, careerInterests, futureGoals, studyLocation, profileReady, home }

class SplashScreenHost extends StatefulWidget {
  const SplashScreenHost({super.key});

  @override
  State<SplashScreenHost> createState() => _SplashScreenHostState();
}

class _SplashScreenHostState extends State<SplashScreenHost> {
  AppScreenStep _step = AppScreenStep.splash;
  String _enteredPhoneNumber = '+91 98765 43210';
  String _enteredName = 'Saurabh';
  String _selectedStage = '';
  String _selectedStream = '';
  String _selectedClass = 'Class 10';
  List<String> _selectedInterests = const ['Technology'];
  List<String> _selectedGoals = const ['Find a College'];
  String _selectedLocation = 'India';

  bool get _hasStream => !_selectedStage.startsWith('School');
  bool get _hasClass => _selectedStage != 'Working Professional' && !_selectedStage.startsWith('Gap');

  @override
  Widget build(BuildContext context) {
    final (classTitle, classOptions) = switch (_selectedStage) {
      'Class 11 - 12' => ('What class are you in?', seniorClasses),
      'Undergraduate' => ('Which year are you in?', ugYears),
      'Postgraduate' => ('Which year are you in?', pgYears),
      _ => ('What class are you in?', schoolClasses),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: switch (_step) {
        AppScreenStep.splash => SplashScreen(
            key: const ValueKey('SplashScreen'),
            onLoaded: () => setState(() => _step = AppScreenStep.intro),
          ),
        AppScreenStep.intro => IntroScreen(
            key: const ValueKey('IntroScreen'),
            onBack: () => setState(() => _step = AppScreenStep.splash),
            onGetStarted: () => setState(() => _step = AppScreenStep.mobileNumber),
          ),
        AppScreenStep.mobileNumber => MobileNumberScreen(
            key: const ValueKey('MobileNumberScreen'),
            onBack: () => setState(() => _step = AppScreenStep.intro),
            onContinue: (phone) => setState(() {
              if (phone.trim().isNotEmpty) {
                _enteredPhoneNumber = phone;
              }
              _step = AppScreenStep.otp;
            }),
          ),
        AppScreenStep.otp => OtpScreen(
            key: const ValueKey('OtpScreen'),
            phoneNumber: _enteredPhoneNumber,
            onBack: () => setState(() => _step = AppScreenStep.mobileNumber),
            onChangeNumber: () => setState(() => _step = AppScreenStep.mobileNumber),
            onVerify: (_) => setState(() => _step = AppScreenStep.name),
          ),
        AppScreenStep.name => NameScreen(
            key: const ValueKey('NameScreen'),
            initialName: _enteredName,
            onBack: () => setState(() => _step = AppScreenStep.otp),
            onContinue: (name) => setState(() {
              _enteredName = name;
              _step = AppScreenStep.stage;
            }),
          ),
        AppScreenStep.stage => AcademicStageScreen(
            key: const ValueKey('AcademicStageScreen'),
            onBack: () => setState(() => _step = AppScreenStep.name),
            onStageSelected: (stage) => setState(() {
              _selectedStage = stage;
              _selectedStream = '';
              _step = _hasStream ? AppScreenStep.stream : AppScreenStep.classSelection;
            }),
          ),
        AppScreenStep.stream => switch (_selectedStage) {
            'Undergraduate' => StreamScreen(
                key: const ValueKey('UgStreamScreen'),
                title: 'What are you studying?',
                subtitle: 'Choose your course',
                options: ugStreams,
                onBack: () => setState(() => _step = AppScreenStep.stage),
                onContinue: _onStreamContinue,
              ),
            'Postgraduate' => StreamScreen(
                key: const ValueKey('PgStreamScreen'),
                title: 'What are you pursuing?',
                subtitle: 'Choose your program and field',
                options: pgStreams,
                dropdownLabel: 'Field / Specialization',
                dropdownHint: 'Select your field',
                dropdownIcon: Icons.school_rounded,
                dropdownItems: (s) => pgFields[s] ?? const [],
                onBack: () => setState(() => _step = AppScreenStep.stage),
                onContinue: _onStreamContinue,
              ),
            'Working Professional' => StreamScreen(
                key: const ValueKey('ProfessionScreen'),
                title: 'What do you do?',
                subtitle: 'Choose your profession',
                options: professions,
                dropdownLabel: 'Experience Level',
                dropdownHint: 'Select years of experience',
                dropdownIcon: Icons.work_history_rounded,
                dropdownItems: (_) => experienceRanges,
                onBack: () => setState(() => _step = AppScreenStep.stage),
                onContinue: _onStreamContinue,
              ),
            _ => StreamScreen(
                key: const ValueKey('StreamScreen'),
                onBack: () => setState(() => _step = AppScreenStep.stage),
                onContinue: _onStreamContinue,
              ),
          },
        AppScreenStep.classSelection => ClassSelectionScreen(
            key: ValueKey('ClassSelectionScreen$_selectedStage'),
            initialClass: _selectedClass,
            title: classTitle,
            options: classOptions,
            onBack: () => setState(() => _step = _hasStream ? AppScreenStep.stream : AppScreenStep.stage),
            onContinue: (selectedClass) => setState(() {
              _selectedClass = selectedClass;
              _step = AppScreenStep.careerInterests;
            }),
          ),
        AppScreenStep.careerInterests => CareerInterestsScreen(
            key: const ValueKey('CareerInterestsScreen'),
            initialSelected: _selectedInterests,
            onBack: () => setState(() => _step = _hasClass ? AppScreenStep.classSelection : AppScreenStep.stream),
            onContinue: (interests) => setState(() {
              _selectedInterests = interests;
              _step = AppScreenStep.futureGoals;
            }),
          ),
        AppScreenStep.futureGoals => FutureGoalsScreen(
            key: const ValueKey('FutureGoalsScreen'),
            initialSelected: _selectedGoals,
            onBack: () => setState(() => _step = AppScreenStep.careerInterests),
            onContinue: (goals) => setState(() {
              _selectedGoals = goals;
              _step = AppScreenStep.studyLocation;
            }),
          ),
        AppScreenStep.studyLocation => StudyLocationScreen(
            key: const ValueKey('StudyLocationScreen'),
            initialSelected: _selectedLocation,
            onBack: () => setState(() => _step = AppScreenStep.futureGoals),
            onContinue: (loc) => setState(() {
              _selectedLocation = loc;
              _step = AppScreenStep.profileReady;
            }),
          ),
        AppScreenStep.profileReady => ProfileReadyScreen(
            key: const ValueKey('ProfileReadyScreen'),
            selectedClass: _selectedClass,
            selectedStream: _selectedStream.isNotEmpty ? _selectedStream : _selectedStage,
            selectedInterests: _selectedInterests,
            selectedGoals: _selectedGoals,
            selectedLocation: _selectedLocation,
            onStartExploring: () => setState(() => _step = AppScreenStep.home),
          ),
        AppScreenStep.home => HomeScreen(
            key: const ValueKey('HomeScreen'),
            userName: _enteredName,
            stage: _selectedStage,
            stream: _selectedStream,
            selectedClass: _selectedClass,
            interests: _selectedInterests,
            goals: _selectedGoals,
            location: _selectedLocation,
          ),
      },
    );
  }

  void _onStreamContinue(String stream) => setState(() {
        _selectedStream = stream;
        if (_hasClass) {
          _step = AppScreenStep.classSelection;
        } else {
          _selectedClass = _selectedStage; // no class page for this stage
          _step = AppScreenStep.careerInterests;
        }
      });
}

