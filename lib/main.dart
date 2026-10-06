import 'package:flutter/material.dart';
import 'core/responsive.dart';
import 'screens/academic_stage_screen.dart';
import 'screens/career_interests_screen.dart';
import 'screens/class_selection_screen.dart';
import 'screens/future_goals_screen.dart';
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

  @override
  Widget build(BuildContext context) {
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
              _step = AppScreenStep.stream;
            }),
          ),
        AppScreenStep.stream => StreamScreen(
            key: const ValueKey('StreamScreen'),
            onBack: () => setState(() => _step = AppScreenStep.stage),
            onContinue: (stream) => setState(() {
              _selectedStream = stream;
              _step = AppScreenStep.classSelection;
            }),
          ),
        AppScreenStep.classSelection => ClassSelectionScreen(
            key: const ValueKey('ClassSelectionScreen'),
            initialClass: _selectedClass,
            onBack: () => setState(() => _step = AppScreenStep.stream),
            onContinue: (selectedClass) => setState(() {
              _selectedClass = selectedClass;
              _step = AppScreenStep.careerInterests;
            }),
          ),
        AppScreenStep.careerInterests => CareerInterestsScreen(
            key: const ValueKey('CareerInterestsScreen'),
            initialSelected: _selectedInterests,
            onBack: () => setState(() => _step = AppScreenStep.classSelection),
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
            selectedStream: _selectedStream,
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
}

class HomeScreen extends StatefulWidget {
  final String userName;
  final String stage;
  final String stream;
  final String selectedClass;
  final List<String> interests;
  final List<String> goals;
  final String location;

  const HomeScreen({
    super.key,
    this.userName = 'User',
    this.stage = '',
    this.stream = '',
    this.selectedClass = '',
    this.interests = const [],
    this.goals = const [],
    this.location = '',
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const _destinations = [
    (icon: Icons.dashboard_outlined, selected: Icons.dashboard, label: 'Dashboard'),
    (icon: Icons.folder_outlined, selected: Icons.folder, label: 'Projects'),
    (icon: Icons.settings_outlined, selected: Icons.settings, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final padding = context.responsive(mobile: 16.0, tablet: 24.0, desktop: 32.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('JoinUNiX'),
        centerTitle: context.isMobile,
      ),
      body: Row(
        children: [
          if (!context.isMobile)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              labelType: NavigationRailLabelType.selected,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selected),
                    label: Text(d.label),
                  ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _destinations[_selectedIndex].selected,
                            size: context.responsive(mobile: 48.0, desktop: 64.0),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Welcome, ${widget.userName}!',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Class: ${widget.selectedClass.isNotEmpty ? widget.selectedClass : "Not set"} • Stream: ${widget.stream.isNotEmpty ? widget.stream : "Not set"}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (widget.interests.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Interests: ${widget.interests.join(", ")}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          if (widget.goals.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Looking for: ${widget.goals.join(", ")}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF6F2CFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          if (widget.location.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Study Location: ${widget.location}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF0F62FE),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                          const SizedBox(height: 6),
                          Text(
                            'Active Viewport: ${context.isDesktop ? "Desktop" : context.isTablet ? "Tablet" : "Mobile"}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: context.isMobile
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              destinations: [
                for (final d in _destinations)
                  NavigationDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selected),
                    label: d.label,
                  ),
              ],
            )
          : null,
    );
  }
}
