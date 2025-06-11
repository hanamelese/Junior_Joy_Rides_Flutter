import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';

void main() {
  test('SpecialInterviewItem can be created from JSON', () {
    final json = {
      'id': 1,
      'childName': 'Test Child',
      'guardianName': 'Test Guardian',
      'guardianPhone': '1234567890',
      'age': 10,
      'guardianEmail': 'guardian@example.com',
      'specialRequests': 'Special appearance request',
      'upcoming': true,
      'approved': false,
    };

    final specialInterviewItem = SpecialInterviewItem.fromJson(json);

    expect(specialInterviewItem.id, 1);
    expect(specialInterviewItem.childName, 'Test Child');
    expect(specialInterviewItem.guardianName, 'Test Guardian');
    expect(specialInterviewItem.guardianPhone, '1234567890');
    expect(specialInterviewItem.age, 10);
    expect(specialInterviewItem.guardianEmail, 'guardian@example.com');
    expect(specialInterviewItem.specialRequests, 'Special appearance request');
    expect(specialInterviewItem.upcoming, true);
    expect(specialInterviewItem.approved, false);
  });

  test('SpecialInterviewItem can be serialized to JSON', () {
    final specialInterviewItem = SpecialInterviewItem(
      id: 2,
      childName: 'Example Child',
      guardianName: 'Example Guardian',
      guardianPhone: '0987654321',
      age: 8,
      guardianEmail: 'example@example.com',
      specialRequests: 'VIP appearance',
      upcoming: false,
      approved: true,
    );

    final json = specialInterviewItem.toJson();

    expect(json['id'], 2);
    expect(json['childName'], 'Example Child');
    expect(json['guardianName'], 'Example Guardian');
    expect(json['guardianPhone'], 987654321); // Checks parsed phone number
    expect(json['age'], 8);
    expect(json['guardianEmail'], 'example@example.com');
    expect(json['specialRequests'], 'VIP appearance');
    expect(json['upcoming'], false);
    expect(json['approved'], true);
  });

  test('SpecialInterviewItem correctly formats JSON for create API', () {
    final specialInterviewItem = SpecialInterviewItem(
      childName: 'New Child',
      guardianName: 'New Guardian',
      age: 5,
    );

    final json = specialInterviewItem.toJsonForCreate();

    expect(json.containsKey('id'), false); // Ensure 'id' is not included
    expect(json['childName'], 'New Child');
    expect(json['guardianName'], 'New Guardian');
    expect(json['age'], 5);
  });

  test('SpecialInterviewItem correctly formats JSON for patch API', () {
    final specialInterviewItem = SpecialInterviewItem(id: 3);

    final json = specialInterviewItem.toJsonForPatch();


    expect(json['id'], 3);
    expect(json['childName'], '');
    expect(json['guardianPhone'], 0); // Ensures default values are assigned
  });
}