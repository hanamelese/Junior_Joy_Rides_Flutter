import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/screens/wishListScreen.dart';

void main() {
  testWidgets('wishList Screen loads UI elements correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: WishListScreen()))
    );

    expect(find.widgetWithText(TextFormField, "Date Of Celebration"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Special Requests"), findsOneWidget);
    expect(find.widgetWithText(TextFormField, "Guardian's Email"), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "Submit Request"), findsOneWidget);
  });

  testWidgets('Date picker opens and selects a date', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: WishListScreen()))
    );

    await tester.tap(find.widgetWithText(TextFormField, "Date Of Celebration"));
    await tester.pumpAndSettle();

    // Select a date (assuming today)
    await tester.tap(find.text(DateTime.now().day.toString()));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify date field is updated
    expect(find.textContaining(DateTime.now().year.toString()), findsOneWidget);
  });

  testWidgets('Submit button validation fails for empty fields', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: WishListScreen()))
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit Request'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Please select a date'), findsOneWidget);
    expect(find.textContaining('Please enter an email'), findsOneWidget);
  });

  testWidgets('Wishlist submission triggers success message', (WidgetTester tester) async {
    await tester.pumpWidget(
        ProviderScope(child: MaterialApp(home: WishListScreen()))
    );

    await tester.enterText(find.widgetWithText(TextFormField, "Date Of Celebration"), "2025-06-10");
    await tester.enterText(find.widgetWithText(TextFormField, "Guardian's Email"), "valid@example.com");
    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit Request'));
    await tester.pumpAndSettle();

    expect(find.text('Wishlist submitted successfully!'), findsOneWidget);
  });
}