import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';

void main() {
  test('WishListItem can be created from JSON', () {
    final json = {
      'id': 1,
      'childName': 'Test Child',
      'guardianEmail': 'guardian@example.com',
      'age': 10,
      'date': '2025-06-10',
      'specialRequests': 'Special gift request',
      'imageUrl': 'https://example.com/image.jpg',
      'upcoming': true,
      'approved': false,
    };

    final wishListItem = WishListItem.fromJson(json);

    expect(wishListItem.id, 1);
    expect(wishListItem.childName, 'Test Child');
    expect(wishListItem.guardianEmail, 'guardian@example.com');
    expect(wishListItem.age, 10);
    expect(wishListItem.date, '2025-06-10');
    expect(wishListItem.specialRequests, 'Special gift request');
    expect(wishListItem.imageUrl, 'https://example.com/image.jpg');
    expect(wishListItem.upcoming, true);
    expect(wishListItem.approved, false);
  });

  test('WishListItem can be serialized to JSON', () {
    final wishListItem = WishListItem(
      id: 2,
      childName: 'Example Child',
      guardianEmail: 'example@example.com',
      age: 8,
      date: '2025-07-15',
      specialRequests: 'VIP treatment',
      imageUrl: 'https://example.com/example.jpg',
      upcoming: false,
      approved: true,
    );

    final json = wishListItem.toJson();

    expect(json['id'], 2);
    expect(json['childName'], 'Example Child');
    expect(json['guardianEmail'], 'example@example.com');
    expect(json['age'], 8);
    expect(json['date'], '2025-07-15');
    expect(json['specialRequests'], 'VIP treatment');
    expect(json['imageUrl'], 'https://example.com/example.jpg');
    expect(json['upcoming'], false);
    expect(json['approved'], true);
  });

  test('WishListItem correctly formats JSON for create API', () {
    final wishListItem = WishListItem(
      childName: 'New Child',
      guardianEmail: 'new@example.com',
      age: 5,
      date: '2025-08-01',
    );

    final json = wishListItem.toJsonForCreate();

    expect(json.containsKey('id'), false); // Ensure 'id' is not included
    expect(json['childName'], 'New Child');
    expect(json['guardianEmail'], 'new@example.com');
    expect(json['age'], 5);
    expect(json['date'], '2025-08-01');
  });

  test('WishListItem correctly formats JSON for patch API', () {
    final wishListItem = WishListItem(id: 3);

    final json = wishListItem.toJsonForPatch();


    expect(json['id'], 3);
    expect(json['childName'], '');
    expect(json['guardianEmail'], '');
    expect(json['age'], 0); // Ensures default values are assigned
  });
}