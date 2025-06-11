import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/screens/basicInterviewScreen.dart';

void main() {
  testWidgets('Basic Interview Screen loads UI elements correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: BasicInterviewScreen()))
    );

    expect(find.widgetWithText(TextFormField, "Child's Name"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Guardian's Name"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Phone"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Age"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Email"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Special Requests"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
  });

  testWidgets('Submit button validation fails for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: BasicInterviewScreen()))
    );

    // Ensure button is visible
    final submitButtonFinder = find.widgetWithText(ElevatedButton, 'Submit');
    expect(submitButtonFinder, findsOneWidget); // Verify button exists before scrolling
    await tester.ensureVisible(submitButtonFinder);
    // Tap Submit button
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Check validation errors
    expect(find.textContaining('Required'), findsWidgets);
  });
}