import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/screens/profileScreen.dart';

void main() {
  testWidgets('Profile screen loads UI elements correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );
    // Verify profile details exist
    expect(find.textContaining('Full Name'), findsOneWidget);
    expect(find.textContaining('name@gmail.com'), findsOneWidget);

    // Verify Edit Profile button exists
    expect(find.widgetWithText(ElevatedButton, 'Edit Profile'), findsOneWidget);

    // Verify My Application section exists
    expect(find.text('My Application'), findsOneWidget);
  });

  testWidgets('Edit Profile button navigates to edit screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfileScreen(),
        '/edit_profile': (context) => Scaffold(body: Text('Edit Profile Screen')),
      },
    ));

    await tester.tap(find.text('Edit Profile'));
    await tester.pumpAndSettle();

    // Verify navigation happened
    expect(find.text('Edit Profile Screen'), findsOneWidget);
  });

  testWidgets('Navigates to Basic Interview screen when card is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfileScreen(),
        '/basic-interview': (context) => Scaffold(body: Text('Basic Interview Screen')),
      },
    ));

    await tester.tap(find.textContaining('Basic Interview'));
    await tester.pumpAndSettle();

    expect(find.text('Basic Interview Screen'), findsOneWidget);
  });

  testWidgets('Navigates to Wishlist screen when card is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfileScreen(),
        '/wishList': (context) => Scaffold(body: Text('Wishlist Screen')),
      },
    ));

    await tester.tap(find.textContaining('Wishlist'));
    await tester.pumpAndSettle();

    expect(find.text('Wishlist Screen'), findsOneWidget);
  });

  testWidgets('Navigates to Invitation screen when card is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => ProfileScreen(),
        '/invitation': (context) => Scaffold(body: Text('Invitation Screen')),
      },
    ));

    await tester.tap(find.textContaining('Invitation'));
    await tester.pumpAndSettle();

    expect(find.text('Invitation Screen'), findsOneWidget);
  });
}
