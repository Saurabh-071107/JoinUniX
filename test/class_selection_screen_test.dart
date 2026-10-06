import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/screens/class_selection_screen.dart';

void main() {
  testWidgets('ClassSelectionScreen renders options and handles selection', (tester) async {
    String? continuedClass;
    bool backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ClassSelectionScreen(
          initialClass: 'Class 10',
          onBack: () => backPressed = true,
          onContinue: (c) => continuedClass = c,
        ),
      ),
    );

    // Verify Title and options
    expect(find.text('What class are you in?'), findsOneWidget);
    expect(find.text('Class 8'), findsOneWidget);
    expect(find.text('Class 9'), findsOneWidget);
    expect(find.text('Class 10'), findsOneWidget);
    expect(find.text('Class 11'), findsOneWidget);
    expect(find.text('Class 12'), findsOneWidget);

    // Initial checkmark visible on Class 10
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap Class 12
    await tester.tap(find.text('Class 12'));
    await tester.pumpAndSettle();

    // Verify checkmark still exists (now on Class 12)
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // Tap Continue button
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(continuedClass, 'Class 12');

    // Tap Back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new_rounded));
    await tester.pumpAndSettle();
    expect(backPressed, true);
  });
}
