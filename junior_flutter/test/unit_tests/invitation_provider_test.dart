import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';

void main() {
  group('InvitationItem serialization', () {
    test('toJson includes all populated fields by default', () {
      final item = InvitationItem(
        id: 1,
        childName: 'Sami',
        guardianPhone: '09-123-4567',
        age: 10,
        guardianEmail: 'sami@example.com',
        specialRequests: 'wheelchair',
        address: 'Addis Ababa',
        date: '2025-06-12',
        time: '1500',
        upcoming: true,
        approved: false,
      );

      final json = item.toJson();

      expect(json['id'], 1);
      expect(json['childName'], 'Sami');
      expect(json['guardianPhone'], 91234567); // numbers only
      expect(json['age'], 10);
      expect(json['guardianEmail'], 'sami@example.com');
      expect(json['specialRequests'], 'wheelchair');
      expect(json['address'], 'Addis Ababa');
      expect(json['date'], '2025-06-12');
      expect(json['time'], 1500);
      expect(json['upcoming'], true);
      expect(json['approved'], false);
    });

    test('toJsonForCreate excludes the ID field', () {
      final item = InvitationItem(
        id: 42,
        childName: 'Liya',
        guardianPhone: '0900123456',
        age: 8,
        guardianEmail: 'liya@example.com',
      );

      final json = item.toJsonForCreate();

      expect(json.containsKey('id'), false);
      expect(json['childName'], 'Liya');
      expect(json['guardianPhone'], 900123456);
    });

    test('toJsonForPatch uses defaults for missing fields', () {
      final item = InvitationItem(id: 5);

      final json = item.toJsonForPatch();

      expect(json['id'], 5);
      expect(json['childName'], '');
      expect(json['guardianPhone'], 0);
      expect(json['age'], 0);
      expect(json['guardianEmail'], '');
      expect(json['upcoming'], false);
      expect(json['approved'], false);
    });

    test('fromJson reconstructs model correctly', () {
      final json = {
        'id': 2,
        'childName': 'Kidus',
        'guardianPhone': 911223344,
        'age': 12,
        'guardianEmail': 'kidus@example.com',
        'specialRequests': null,
        'address': 'Bole',
        'date': '2025-06-14',
        'time': 1330,
        'upcoming': true,
        'approved': true,
      };

      final item = InvitationItem.fromJson(json);

      expect(item.id, 2);
      expect(item.childName, 'Kidus');
      expect(item.guardianPhone, '911223344');
      expect(item.age, 12);
      expect(item.upcoming, true);
      expect(item.approved, true);
    });
  });
}