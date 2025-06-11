import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:junior_flutter/features/crud/presentation/screens/loginScreen.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    late UserViewModel mockViewModel;

    setUp(() {
      mockViewModel = UserViewModel();
    });

    Widget createTestWidget() {
      return ChangeNotifierProvider<UserViewModel>.value(
        value: mockViewModel,
        child: MaterialApp(
          home: LoginScreen(),
        ),
      );
    }

    testWidgets('UI elements are present', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password fields
      expect(find.widgetWithIcon(IconButton, Icons.visibility_off), findsOneWidget);
      expect(find.widgetWithIcon(IconButton, Icons.lock), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
    });

    testWidgets('Password visibility toggle works', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      final passwordToggleButton = find.widgetWithIcon(IconButton, Icons.visibility_off);
      await tester.tap(passwordToggleButton);
      await tester.pump();

      expect(find.widgetWithIcon(IconButton, Icons.visibility), findsOneWidget);
    });

    testWidgets('Shows error when email or password is empty', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      expect(find.textContaining('Email and password cannot be empty'), findsOneWidget);
    });

    testWidgets('Valid login triggers login function', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(1), 'password123');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
      await tester.pump();

      expect(find.textContaining('Email and password cannot be empty'), findsNothing);
    });

    testWidgets('Forgot password navigates correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/login': (context) => LoginScreen(),
          '/forgotPassword': (context) => Scaffold(body: Text('Forgot Password Screen')),
        },
        initialRoute: '/login',
      ));

      await tester.tap(find.text('Forgot password'));
      await tester.pumpAndSettle();

      expect(find.text('Forgot Password Screen'), findsOneWidget);
    });

    testWidgets('Signup navigation works', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/login': (context) => LoginScreen(),
          '/signup': (context) => Scaffold(body: Text('Signup Screen')),
        },
        initialRoute: '/login',
      ));

      await tester.tap(find.text("Signup"));
      await tester.pumpAndSettle();

      expect(find.text('Signup Screen'), findsOneWidget);
    });
  });
}