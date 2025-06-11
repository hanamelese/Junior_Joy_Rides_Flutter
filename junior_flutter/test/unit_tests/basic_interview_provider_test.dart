import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';

void main() {
  test('BasicInterviewItem serialization works correctly', () {
    final item = BasicInterviewItem(
      id: 1,
      childName: 'Alice',
      guardianName: 'Bob',
      guardianPhone: '123456789',
      age: 10,
      guardianEmail: 'alice@example.com',
      specialRequests: 'Special care',
      upcoming: true,
      approved: false,
    );

    final json = item.toJson();
    expect(json['id'], 1);
    expect(json['childName'], 'Alice');
    expect(json['guardianPhone'], 123456789); // Ensures phone is parsed correctly
  });

  test('BasicInterviewItem correctly formats JSON for create API', () {
    final item = BasicInterviewItem(
      childName: 'New Child',
      guardianName: 'New Guardian',
      age: 5,
      guardianEmail: 'new@example.com',
    );

    final json = item.toJsonForCreate();
    expect(json.containsKey('id'), false); // Ensure 'id' is not included
    expect(json['childName'], 'New Child');
    expect(json['guardianEmail'], 'new@example.com');
  });

  test('BasicInterviewItem correctly formats JSON for patch API', () {
    final item = BasicInterviewItem(id: 3);

    final json = item.toJsonForPatch();
    expect(json['id'], 3);
    expect(json['guardianPhone'], 0); // Ensures default values are assigned correctly
  });

  test('BasicInterviewItem deserialization works correctly', () {
    final json = {
      'id': 2,
      'childName': 'Charlie',
      'guardianName': 'David',
      'guardianPhone': '987654321',
      'age': 7,
      'guardianEmail': 'charlie@example.com',
      'specialRequests': 'Wheelchair access',
      'upcoming': false,
      'approved': true,
    };

    final item = BasicInterviewItem.fromJson(json);
    expect(item.id, 2);
    expect(item.childName, 'Charlie');
    expect(item.guardianPhone, '987654321'); // Ensures correct phone parsing
    expect(item.age, 7);
    expect(item.approved, true);
  });
}