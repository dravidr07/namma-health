import 'package:flutter_test/flutter_test.dart';

import 'package:namma_health/main.dart';

void main() {
  testWidgets('Welcome screen shows app name and language buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Namma Health'), findsOneWidget);
    expect(find.text('Your Health, Our Care'), findsOneWidget);
    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('தமிழ்'), findsOneWidget);
    expect(find.text('हिंदी'), findsOneWidget);
    expect(find.text('తెలుగు'), findsOneWidget);

    await tester.tap(find.text('தமிழ்'));
    await tester.pump();

    expect(find.text('Selected: தமிழ்'), findsOneWidget);
  });
}
