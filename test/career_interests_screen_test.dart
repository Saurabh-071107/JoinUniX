import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/screens/career_interests_screen.dart';

void main() {
  testWidgets('CareerInterestsScreen renders all options and handles multi-selection', (tester) async {
    List<String>? continuedInterests;
    bool backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: CareerInterestsScreen(
          initialSelected: const ['Technology'],
          onBack: () => backPressed = true,
          onContinue: (list) => continuedInterests = list,
        ),
      ),
    );

    // Verify Title & Subtitle
    expect(find.text('What are you interested in?'), findsOneWidget);
    expect(find.text('Select up to 5 interests'), findsOneWidget);

    // Verify Interest titles
    expect(find.text('Technology'), findsOneWidget);
    expect(find.text('Medicine'), findsOneWidget);
    expect(find.text('Business'), findsOneWidget);
    expect(find.text('Design'), findsOneWidget);
    expect(find.text('Law'), findsOneWidget);
    expect(find.text('Aviation'), findsOneWidget);
    expect(find.text('Media'), findsOneWidget);
    expect(find.text('Environment'), findsOneWidget);
    expect(find.text('Gaming'), findsOneWidget);
    expect(find.text('Research'), findsOneWidget);
    expect(find.text('Entrepreneurship'), findsOneWidget);
    expect(find.text('Not Sure'), findsOneWidget);

    // Initial checkmark on Technology
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap Medicine to add it
    await tester.tap(find.text('Medicine'));
    await tester.pumpAndSettle();

    // Now 2 checkmarks
    expect(find.byIcon(Icons.check_rounded), findsNWidgets(2));

    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(continuedInterests, containsAll(['Technology', 'Medicine']));

    // Tap Back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(backPressed, true);
  });
}
