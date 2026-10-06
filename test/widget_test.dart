import 'package:flutter_test/flutter_test.dart';
import 'package:joinunix/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JoinUnixApp());
    expect(find.text('Connecting Talent\nBuilding Futures'), findsOneWidget);
  });
}
