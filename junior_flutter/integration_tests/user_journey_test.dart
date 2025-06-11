import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:junior_flutter/main.dart';
import 'package:junior_flutter/features/crud/presentation/screens/invitationScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/editProfileScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/loginScreen.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Journey Integration Tests', () {
    testWidgets('User logs in, edits profile, and submits invitation', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Login screen interaction
      await tester.enterText(find.byKey(Key('email')), 'test@example.com');
      await tester.enterText(find.byKey(Key('password')), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsOneWidget); // Ensure login success

      // Navigate to Edit Profile Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      // Update profile data
      await tester.enterText(find.byKey(Key('firstName')), 'Updated Name');
      await tester.enterText(find.byKey(Key('lastName')), 'Olani');
      await tester.enterText(find.byKey(Key('email')), 'updated@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.text('Profile updated successfully!'), findsOneWidget);

      // Navigate to Invitation Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Invite'));
      await tester.pumpAndSettle();
      expect(find.byType(InvitationScreen), findsOneWidget);

      // Submit invitation
      await tester.enterText(find.byKey(Key('childName')), 'Liam');
      await tester.enterText(find.byKey(Key('age')), '6');
      await tester.enterText(find.byKey(Key('address')), 'Addis Ababa');
      await tester.enterText(find.byKey(Key('guardianPhone')), '0912345678');
      await tester.enterText(find.byKey(Key('guardianEmail')), 'liam@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Invitation submitted successfully!'), findsOneWidget);
    });

    testWidgets('Displays error message for invalid login', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(Key('email')), 'wrong@example.com');
      await tester.enterText(find.byKey(Key('password')), 'wrongpass');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid login credentials'), findsOneWidget);
    });
  });
}