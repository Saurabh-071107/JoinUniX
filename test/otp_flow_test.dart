import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/main.dart';
import 'package:joinunix/screens/otp_screen.dart';

void main() {
  testWidgets('Test transition from MobileNumberScreen to OtpScreen', (tester) async {
    await tester.pumpWidget(const JoinUnixApp());
    // Splash
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    // Intro Screen -> tap Get Started
    final getStartedFinder = find.text('Get Started');
    expect(getStartedFinder, findsOneWidget);
    await tester.tap(getStartedFinder);
    await tester.pumpAndSettle();

    // Mobile Number Screen -> tap Continue
    final continueFinder = find.text('Continue');
    expect(continueFinder, findsOneWidget);
    await tester.tap(continueFinder);
    await tester.pumpAndSettle();

    // OtpScreen should be visible
    expect(find.byType(OtpScreen), findsOneWidget);
    expect(find.text('Verify Your Number'), findsOneWidget);
  });
}
