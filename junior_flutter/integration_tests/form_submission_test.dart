import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:junior_flutter/features/crud/presentation/screens/editProfileScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/invitationScreen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Form Submission Integration Tests', () {
    testWidgets('Shows validation errors on EditProfileScreen', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: EditProfileScreen()),
        ),
      );

      final saveButton = find.widgetWithText(ElevatedButton, 'Save');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.textContaining('Please enter'), findsWidgets);
    });

    testWidgets('Shows validation errors on InvitationScreen', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: InvitationScreen()),
        ),
      );

      final submitButton = find.widgetWithText(ElevatedButton, 'Submit');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Required'), findsWidgets);
    });

    testWidgets('Successfully submits profile edit and invitation', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: EditProfileScreen()),
        ),
      );

      await tester.enterText(find.byKey(Key('firstName')), 'Updated Name');
      await tester.enterText(find.byKey(Key('lastName')), 'Olani');
      await tester.enterText(find.byKey(Key('email')), 'updated@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.text('Profile updated successfully!'), findsOneWidget);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: InvitationScreen()),
        ),
      );

      await tester.enterText(find.byKey(Key('childName')), 'Liam');
      await tester.enterText(find.byKey(Key('age')), '6');
      await tester.enterText(find.byKey(Key('address')), 'Addis Ababa');
      await tester.enterText(find.byKey(Key('guardianPhone')), '0912345678');
      await tester.enterText(
          find.byKey(Key('guardianEmail')), 'liam@example.com');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Invitation submitted successfully!'), findsOneWidget);
    });
  });
}