import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/screens/profile_ready_screen.dart';

void main() {
  testWidgets('ProfileReadyScreen renders summary items and triggers onStartExploring', (tester) async {
    bool exploringClicked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ProfileReadyScreen(
          selectedClass: 'Class 10',
          selectedStream: 'Science (PCM)',
          selectedInterests: const ['Technology', 'Business'],
          selectedGoals: const ['Find a College', 'Prepare for Exams'],
          selectedLocation: 'India',
          onStartExploring: () => exploringClicked = true,
        ),
      ),
    );

    // Verify Title & Subtitles
    expect(find.text("You're All Set!"), findsOneWidget);
    expect(find.text('Your JoinUNiX profile is ready 🎉'), findsOneWidget);
    expect(find.text('Get ready to explore amazing opportunities!'), findsOneWidget);

    // Verify Summary Card Items
    expect(find.text('Class 10'), findsOneWidget);
    expect(find.text('Science (PCM)'), findsOneWidget);
    expect(find.text('Technology, Business'), findsOneWidget);
    expect(find.text('Find a College, Prepare for Exams'), findsOneWidget);
    expect(find.text('India'), findsOneWidget);

    // Tap "Start Exploring"
    await tester.tap(find.text('Start Exploring'));
    await tester.pumpAndSettle();
    expect(exploringClicked, true);
  });
}
