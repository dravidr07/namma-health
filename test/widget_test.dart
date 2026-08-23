import 'package:flutter_test/flutter_test.dart';

import 'package:namma_health/main.dart';

void main() {
  testWidgets('Welcome screen shows all language buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Namma Health'), findsOneWidget);
    expect(find.text('Your Health, Our Care'), findsOneWidget);
    expect(find.text('Choose your language'), findsOneWidget);
    expect(find.text('தமிழ்'), findsOneWidget);
    expect(find.text('हिंदी'), findsOneWidget);
    expect(find.text('తెలుగు'), findsOneWidget);
    expect(find.text('ಕನ್ನಡ'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
  });

  testWidgets('Selecting Tamil opens the home dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('தமிழ்'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Namma Health'), findsOneWidget);
    expect(find.text('Selected language: தமிழ்'), findsOneWidget);
  });

  testWidgets('Selecting Kannada opens the home dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('ಕನ್ನಡ'));
    await tester.tap(find.text('ಕನ್ನಡ'));
    await tester.pumpAndSettle();

    expect(find.text('Selected language: ಕನ್ನಡ'), findsOneWidget);
  });

  testWidgets('Selecting English opens the home dashboard', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('English'));
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Selected language: English'), findsOneWidget);
  });
}
