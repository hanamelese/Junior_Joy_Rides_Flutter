import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:junior_flutter/main.dart';
import 'package:junior_flutter/features/crud/presentation/screens/landing_screen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/invitationScreen.dart';
import 'package:junior_flutter/features/crud/presentation/screens/editProfileScreen.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Navigation Flow Integration Tests', () {
    testWidgets('User moves between Home, Profile, and Invitation screens', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LandingScreen), findsOneWidget);

      // Navigate to Edit Profile
      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit Profile'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      // Go to Invitation Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Invite'));
      await tester.pumpAndSettle();
      expect(find.byType(InvitationScreen), findsOneWidget);

      // Return to Home Screen
      await tester.tap(find.widgetWithText(ElevatedButton, 'Home'));
      await tester.pumpAndSettle();
      expect(find.byType(LandingScreen), findsOneWidget);
    });

    testWidgets('Maintains user session during navigation', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      final userProvider = tester
          .widget<ProviderScope>(find.byType(ProviderScope))
          .container
          .read(userProvider.notifier);
      userProvider.updateUserProfileData('John', 'Doe', 'john@example.com');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Edit Profile'));
      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
    });
  });
}