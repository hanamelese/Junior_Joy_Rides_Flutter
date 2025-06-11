import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';

void main() {
  test('BasicInterviewItem can be created from JSON', () {
    final json = {
      'id': 1,
      'childName': 'Test Child',
      'guardianName': 'Test Guardian',
      'guardianPhone': '1234567890',
      'age': 10,
      'guardianEmail': 'guardian@example.com',
      'specialRequests': 'No special requests',
      'upcoming': true,
      'approved': false,
    };

    final interviewItem = BasicInterviewItem.fromJson(json);

    expect(interviewItem.id, 1);
    expect(interviewItem.childName, 'Test Child');
    expect(interviewItem.guardianName, 'Test Guardian');
    expect(interviewItem.guardianPhone, '1234567890');
    expect(interviewItem.age, 10);
    expect(interviewItem.guardianEmail, 'guardian@example.com');
    expect(interviewItem.specialRequests, 'No special requests');
    expect(interviewItem.upcoming, true);
    expect(interviewItem.approved, false);
  });

  test('BasicInterviewItem can be serialized to JSON', () {
    final interviewItem = BasicInterviewItem(
      id: 2,
      childName: 'Example Child',
      guardianName: 'Example Guardian',
      guardianPhone: '0987654321',
      age: 8,
      guardianEmail: 'example@example.com',
      specialRequests: 'Need additional support',
      upcoming: false,
      approved: true,
    );

    final json = interviewItem.toJson();

    expect(json['id'], 2);
    expect(json['childName'], 'Example Child');
    expect(json['guardianName'], 'Example Guardian');
    expect(json['guardianPhone'], 987654321); // Checks parsed phone number
    expect(json['age'], 8);
    expect(json['guardianEmail'], 'example@example.com');
    expect(json['specialRequests'], 'Need additional support');
    expect(json['upcoming'], false);
    expect(json['approved'], true);
  });

  test('BasicInterviewItem correctly formats JSON for create API', () {
    final interviewItem = BasicInterviewItem(
      childName: 'New Child',
      guardianName: 'New Guardian',
      age: 5,
    );

    final json = interviewItem.toJsonForCreate();

    expect(json.containsKey('id'), false); // Ensure 'id' is not included
    expect(json['childName'], 'New Child');
    expect(json['guardianName'], 'New Guardian');
    expect(json['age'], 5);
  });

  test('BasicInterviewItem correctly formats JSON for patch API', () {

    final interviewItem = BasicInterviewItem(id: 3);

    final json = interviewItem.toJsonForPatch();

    expect(json['id'], 3);
    expect(json['childName'], '');
    expect(json['guardianPhone'], 0); // Ensures default values are assigned
  });
}