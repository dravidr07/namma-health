import 'package:flutter/material.dart';
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

    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('How can we help you?'), findsOneWidget);
    expect(find.text('Selected language: தமிழ்'), findsOneWidget);
    expect(find.text('Ask Health Assistant'), findsOneWidget);
    expect(find.text('Nearby Hospitals'), findsOneWidget);
    expect(find.text('Doctor Appointment'), findsOneWidget);
    expect(find.text('My Medicines'), findsOneWidget);
    expect(find.text('Health Records'), findsOneWidget);
    expect(find.text('EMERGENCY SOS'), findsOneWidget);
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

  testWidgets('Dashboard cards open placeholder screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('தமிழ்'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ask Health Assistant'));
    await tester.pumpAndSettle();
    expect(find.text('Health Assistant'), findsWidgets);
    expect(
      find.text('AI health assistance will be available here.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Nearby Hospitals'));
    await tester.pumpAndSettle();
    expect(
      find.text('Hospital and PHC finder will be available here.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Doctor Appointment'));
    await tester.pumpAndSettle();
    expect(
      find.text('Appointment booking will be available here.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('My Medicines'));
    await tester.tap(find.text('My Medicines'));
    await tester.pumpAndSettle();
    expect(
      find.text('Medicine reminders will be available here.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Health Records'));
    await tester.tap(find.text('Health Records'));
    await tester.pumpAndSettle();
    expect(
      find.text('Digital health records will be available here.'),
      findsOneWidget,
    );

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('EMERGENCY SOS'));
    await tester.tap(find.text('EMERGENCY SOS'));
    await tester.pumpAndSettle();
    expect(find.text('Emergency SOS'), findsWidgets);
    expect(
      find.text('Emergency assistance will be available here.'),
      findsOneWidget,
    );
  });

  testWidgets('Bottom navigation opens Health and Profile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('தமிழ்'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Health'));
    await tester.pumpAndSettle();
    expect(
      find.text('Your health information will be available here.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(
      find.text('Your profile will be available here.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('How can we help you?'), findsOneWidget);
  });

  testWidgets('Home dashboard fits a small Android screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('தமிழ்'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('How can we help you?'), findsOneWidget);

    await tester.ensureVisible(find.text('EMERGENCY SOS'));
    await tester.pumpAndSettle();
    expect(find.text('EMERGENCY SOS'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
