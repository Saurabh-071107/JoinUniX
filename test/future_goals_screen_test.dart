import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/screens/future_goals_screen.dart';

void main() {
  testWidgets('FutureGoalsScreen renders all options and handles multi-selection', (tester) async {
    List<String>? continuedGoals;
    bool backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: FutureGoalsScreen(
          initialSelected: const ['Find a College'],
          onBack: () => backPressed = true,
          onContinue: (list) => continuedGoals = list,
        ),
      ),
    );

    // Verify Title & Subtitle
    expect(find.text('What are you looking for?'), findsOneWidget);
    expect(find.text('You can select multiple options'), findsOneWidget);

    // Verify all 9 Goal titles
    expect(find.text('Find a College'), findsOneWidget);
    expect(find.text('Find a Course'), findsOneWidget);
    expect(find.text('Discover a Career'), findsOneWidget);
    expect(find.text('Prepare for Exams'), findsOneWidget);
    expect(find.text('Get Scholarships'), findsOneWidget);
    expect(find.text('Find Internships'), findsOneWidget);
    expect(find.text('Find a Mentor'), findsOneWidget);
    expect(find.text('Build Skills'), findsOneWidget);
    expect(find.text("I'm Exploring"), findsOneWidget);

    // Initial checkmark on "Find a College"
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap "Build Skills" to toggle it on
    await tester.tap(find.text('Build Skills'));
    await tester.pumpAndSettle();

    // Now 2 checkmarks
    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));

    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(continuedGoals, containsAll(['Find a College', 'Build Skills']));

    // Tap Back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(backPressed, true);
  });
}
