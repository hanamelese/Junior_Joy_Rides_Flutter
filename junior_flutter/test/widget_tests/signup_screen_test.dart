import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/screens/signupScreen.dart';

void main() {
  testWidgets('Signup Screen loads UI elements correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: SignupScreen()),
      ),
    );

    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Confirm password'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Signup'), findsOneWidget);
  });

  testWidgets('Password validation fails for weak password', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: SignupScreen()),
      ),
    );

    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '123');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm password'), '123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Signup'));
    await tester.pump();  // Allow UI to update

    expect(find.textContaining('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Policy agreement is required before signup', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: SignupScreen()),
      ),
    );

    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'securePass123');
    await tester.enterText(find.widgetWithText(TextFormField, 'Confirm password'), 'securePass123');

    final buttonFinder = find.widgetWithText(ElevatedButton, 'Signup');
    expect(tester.widget<ElevatedButton>(buttonFinder).onPressed, isNull);
  });

  testWidgets('Navigates to login screen on clicking Sign In', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          initialRoute: '/signup',
          routes: {
            '/signup': (context) => SignupScreen(),
            '/login': (context) => Scaffold(body: Text('Login Screen')),
          },
        ),
      ),
    );

    await tester.tap(find.text('Sign In')); // Updated button text
    await tester.pumpAndSettle();

    expect(find.text('Login Screen'), findsOneWidget);
  });
}