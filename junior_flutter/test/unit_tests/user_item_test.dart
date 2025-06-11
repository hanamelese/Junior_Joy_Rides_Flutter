import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/userItem.dart';

void main() {
  test('UserItem can be created from JSON', () {
    final json = {
      'id': 1,
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john.doe@example.com',
      'password': 'securepassword',
      'profileImageUrl': 'https://example.com/profile.jpg',
      'backgroundImageUrl': 'https://example.com/background.jpg',
      'role': 'user',
    };

    final userItem = UserItem.fromJson(json);

    expect(userItem.id, 1);
    expect(userItem.firstName, 'John');
    expect(userItem.lastName, 'Doe');
    expect(userItem.email, 'john.doe@example.com');
    expect(userItem.password, 'securepassword');
    expect(userItem.profileImageUrl, 'https://example.com/profile.jpg');
    expect(userItem.backgroundImageUrl, 'https://example.com/background.jpg');
    expect(userItem.role, 'user');
  });

  test('UserItem can be serialized to JSON', () {
    final userItem = UserItem(
      id: 2,
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane.smith@example.com',
      password: 'password123',
      profileImageUrl: 'https://example.com/jane.jpg',
      backgroundImageUrl: 'https://example.com/bg.jpg',
      role: 'admin',
    );

    final json = userItem.toJson();

    expect(json['id'], 2);
    expect(json['firstName'], 'Jane');
    expect(json['lastName'], 'Smith');
    expect(json['email'], 'jane.smith@example.com');
    expect(json['password'], 'password123');
    expect(json['profileImageUrl'], 'https://example.com/jane.jpg');
    expect(json['backgroundImageUrl'], 'https://example.com/bg.jpg');
    expect(json['role'], 'admin');
  });

  test('UserItem correctly formats JSON for login', () {
    final userItem = UserItem(
        email: 'user@example.com', password: 'mypassword');

    final json = userItem.toJsonForLogin();

    expect(json.containsKey('id'), false);
    expect(json['email'], 'user@example.com');
    expect(json['password'], 'mypassword');
  });

  test('UserItem correctly formats JSON for registration', () {
    final userItem = UserItem(
      firstName: 'New',
      lastName: 'User',
      email: 'new.user@example.com',
      password: 'securepass',
    );

    final json = userItem.toJsonForRegistration();

    expect(json.containsKey('id'), false);
    expect(json['firstName'], 'New');
    expect(json['lastName'], 'User');
    expect(json['email'], 'new.user@example.com');
    expect(json['password'], 'securepass');
  });

  test('UserItem correctly formats JSON for profile updates', () {
    final userItem = UserItem(
      firstName: 'Updated',
      lastName: 'Profile',
      email: 'updated@example.com',
      profileImageUrl: 'https://example.com/updated.jpg',
      backgroundImageUrl: 'https://example.com/bg_updated.jpg',
    );

    final json = userItem.toJsonForPut();

    expect(json['firstName'], 'Updated');
    expect(json['lastName'], 'Profile');
    expect(json['email'], 'updated@example.com');
    expect(json.containsKey('password'), true);
    expect(json['profileImageUrl'], 'https://example.com/updated.jpg');
    expect(json['backgroundImageUrl'], 'https://example.com/bg_updated.jpg');
  });
}