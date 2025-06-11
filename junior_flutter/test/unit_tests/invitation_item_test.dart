import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';

void main() {
  test('InvitationItem can be created from JSON', () {
    final json = {
      'id': 1,
      'childName': 'Test Child',
      'guardianPhone': '1234567890',
      'age': 10,
      'guardianEmail': 'guardian@example.com',
      'specialRequests': 'Special gift request',
      'address': '123 Test Street',
      'date': '2025-06-10',
      'time': '14:30',
      'upcoming': true,
      'approved': false,
    };

    final invitationItem = InvitationItem.fromJson(json);

    expect(invitationItem.id, 1);
    expect(invitationItem.childName, 'Test Child');
    expect(invitationItem.guardianPhone, '1234567890');
    expect(invitationItem.age, 10);
    expect(invitationItem.guardianEmail, 'guardian@example.com');
    expect(invitationItem.specialRequests, 'Special gift request');
    expect(invitationItem.address, '123 Test Street');
    expect(invitationItem.date, '2025-06-10');
    expect(invitationItem.time, '14:30');
    expect(invitationItem.upcoming, true);
    expect(invitationItem.approved, false);
  });

  test('InvitationItem can be serialized to JSON', () {
    final invitationItem = InvitationItem(
      id: 2,
      childName: 'Example Child',
      guardianPhone: '0987654321',
      age: 8,
      guardianEmail: 'example@example.com',
      specialRequests: 'VIP seating',
      address: '456 Example Road',
      date: '2025-07-15',
      time: '18:00',
      upcoming: false,
      approved: true,
    );

    final json = invitationItem.toJson();

    expect(json['id'], 2);
    expect(json['childName'], 'Example Child');
    expect(json['guardianPhone'], 987654321); // Checks parsed phone number
    expect(json['age'], 8);
    expect(json['guardianEmail'], 'example@example.com');
    expect(json['specialRequests'], 'VIP seating');
    expect(json['address'], '456 Example Road');
    expect(json['date'], '2025-07-15');
    expect(json['time'], 0); // Ensures time is parsed correctly
    expect(json['upcoming'], false);
    expect(json['approved'], true);
  });

  test('InvitationItem correctly formats JSON for create API', () {
    final invitationItem = InvitationItem(
      childName: 'New Child',
      guardianPhone: '1234567890',
      age: 5,
      date: '2025-08-01',
    );

    final json = invitationItem.toJsonForCreate();

    expect(json.containsKey('id'), false); // Ensure 'id' is not included
    expect(json['childName'], 'New Child');
    expect(json['guardianPhone'], 1234567890);
    expect(json['age'], 5);
    expect(json['date'], '2025-08-01');
  });

  test('InvitationItem correctly formats JSON for patch API', () {
    final invitationItem = InvitationItem(id: 3);

    final json = invitationItem.toJsonForPatch();

    expect(json['id'], 3);
    expect(json['childName'], '');
    expect(json['guardianPhone'], 0); // Ensures default values are assigned
    expect(json['time'], 0); // Checks time defaulting
  });
}