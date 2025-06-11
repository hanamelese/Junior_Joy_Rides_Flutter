import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:junior_flutter/main.dart';
import 'package:junior_flutter/features/crud/presentation/screens/invitationScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/editProfileScreen.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/invitation_view_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    testWidgets(
        'Navigates between screens successfully', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Navigate to Edit Profile Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      // Navigate to Invitation Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Invite'));
      await tester.pumpAndSettle();
      expect(find.byType(InvitationScreen), findsOneWidget);
    });

    testWidgets('Validates form submission in EditProfileScreen', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: EditProfileScreen()),
        ),
      );

      await tester.enterText(find.byKey(Key('firstName')), 'jon');
      await tester.enterText(find.byKey(Key('lastName')), 'doe');
      await tester.enterText(find.byKey(Key('email')), 'jon@example.com');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Save'));
      await tester.pumpAndSettle();

      expect(find.text('Profile updated successfully!'), findsOneWidget);
    });

    testWidgets('Saves new invitation in InvitationScreen', (
        WidgetTester tester) async {
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