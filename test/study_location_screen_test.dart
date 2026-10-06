import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/screens/study_location_screen.dart';

void main() {
  testWidgets('StudyLocationScreen renders options, info banner, and handles selection', (tester) async {
    String? continuedLocation;
    bool backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StudyLocationScreen(
          initialSelected: 'India',
          onBack: () => backPressed = true,
          onContinue: (loc) => continuedLocation = loc,
        ),
      ),
    );

    // Verify Title & Subtitle
    expect(find.text('Where do you want to study?'), findsOneWidget);
    expect(find.text('Select your preference'), findsOneWidget);

    // Verify 4 location titles & subtitles
    expect(find.text('India'), findsOneWidget);
    expect(find.text('(Within India)'), findsOneWidget);
    expect(find.text('Abroad'), findsOneWidget);
    expect(find.text('(Global)'), findsOneWidget);
    expect(find.text('India + Abroad'), findsOneWidget);
    expect(find.text('(Both)'), findsOneWidget);
    expect(find.text("I'm Not Sure Yet"), findsOneWidget);

    // Verify Info Banner
    expect(
      find.text('You can always change this later in your profile settings.'),
      findsOneWidget,
    );

    // Initial checkmark on "India"
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap "India + Abroad"
    await tester.tap(find.text('India + Abroad'));
    await tester.pumpAndSettle();

    // Checkmark remains 1 (now on "India + Abroad")
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap Continue
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(continuedLocation, 'India + Abroad');

    // Tap Back
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(backPressed, true);
  });
}
