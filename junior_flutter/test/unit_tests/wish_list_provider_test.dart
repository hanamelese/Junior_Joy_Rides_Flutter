import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/wishListItem.dart';

void main() {
  group('WishListItem', () {
    test('toJson includes populated fields', () {
      final item = WishListItem(
        id: 1,
        childName: 'Maya',
        guardianEmail: 'maya@example.com',
        age: 8,
        date: '2025-10-12',
        specialRequests: 'Dollhouse',
        imageUrl: 'https://img.com/doll.jpg',
        upcoming: true,
        approved: false,
      );

      final json = item.toJson();

      expect(json['id'], 1);
      expect(json['childName'], 'Maya');
      expect(json['guardianEmail'], 'maya@example.com');
      expect(json['specialRequests'], 'Dollhouse');
      expect(json['imageUrl'], 'https://img.com/doll.jpg');
    });

    test('toJsonForCreate excludes ID', () {
      final item = WishListItem(
        id: 5,
        childName: 'Yordi',
        guardianEmail: 'yordi@example.com',
        date: '2025-11-01',
      );

      final json = item.toJsonForCreate();

      expect(json.containsKey('id'), false);
      expect(json['childName'], 'Yordi');
      expect(json['date'], '2025-11-01');
    });

    test('toJsonForPatch applies defaults where necessary', () {
      final item = WishListItem(id: 10);

      final json = item.toJsonForPatch();

      expect(json['id'], 10);
      expect(json['childName'], '');
      expect(json['guardianEmail'], '');
      expect(json['age'], 0);
      expect(json['imageUrl'], '');
      expect(json['upcoming'], false);
      expect(json['approved'], false);
    });

    test('fromJson parses all fields correctly', () {
      final json = {
        'id': 42,
        'childName': 'Sara',
        'guardianEmail': 'sara@example.com',
        'age': 7,
        'date': '2025-12-25',
        'specialRequests': 'Bike',
        'imageUrl': 'https://img.com/bike.jpg',
        'upcoming': true,
        'approved': true,
      };

      final item = WishListItem.fromJson(json);

      expect(item.id, 42);
      expect(item.childName, 'Sara');
      expect(item.guardianEmail, 'sara@example.com');
      expect(item.date, '2025-12-25');
      expect(item.upcoming, true);
      expect(item.approved, true);
    });
  });
}