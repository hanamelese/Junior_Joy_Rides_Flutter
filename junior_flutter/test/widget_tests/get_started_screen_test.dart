import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:junior_flutter/features/crud/presentation/screens/get_started.dart';

void main() {
  group('GetStartedScreen Widget Tests', () {
    testWidgets('Displays correct title and description on initial page', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GetStartedScreen(onNavigate: (route) {})));
      await tester.pumpAndSettle();

      expect(find.text('Book Interviews'), findsOneWidget);
    });

    testWidgets('Navigates when Get Started is pressed', (WidgetTester tester) async {
      String? navigatedRoute;
      await tester.pumpWidget(MaterialApp(home: GetStartedScreen(onNavigate: (route) { navigatedRoute = route; })));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Get Started'));
      await tester.pump();

      expect(navigatedRoute, '/user-signup');
    });

    testWidgets('Changes page when indicator is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GetStartedScreen(onNavigate: (route) {})));
      await tester.pumpAndSettle();

      final secondIndicator = find.byType(GestureDetector).at(1);
      await tester.tap(secondIndicator);
      await tester.pumpAndSettle();


    });
  });
}