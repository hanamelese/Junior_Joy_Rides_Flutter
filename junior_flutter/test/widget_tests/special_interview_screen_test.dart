import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/screens/specialInterviewScreen.dart';

void main() {
  testWidgets('Special Interview Screen loads UI elements correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: SpecialInterviewScreen()))
    );

    expect(find.text('Interview'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Basic Interview'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Talent Show'), findsOneWidget);
    expect(find.text("Enhance your child's talent"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Submit Request'), findsOneWidget);
  });

  testWidgets('Video upload button exists and functions', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: SpecialInterviewScreen()))
    );

    await tester.tap(find.byIcon(Icons.videocam_outlined));
    await tester.pumpAndSettle();

    // This test ensures the button exists and responds to tap events
    expect(find.textContaining('Could not open Google Drive'), findsNothing);
  });

  testWidgets('Submit button validation fails for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: SpecialInterviewScreen()))
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit Request'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Required'), findsWidgets);
  });

  testWidgets('Navigates to Basic Interview screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/specialInterview',
      routes: {
        '/specialInterview': (context) => SpecialInterviewScreen(),
        '/interview': (context) => Scaffold(body: Text('Basic Interview Screen')),
      },
    ));

    await tester.tap(find.text('Basic Interview'));
    await tester.pumpAndSettle();

    expect(find.text('Basic Interview Screen'), findsOneWidget);
  });
}