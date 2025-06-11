import 'package:flutter_test/flutter_test.dart';
import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';

void main() {
  group('SpecialInterviewItem serialization', () {
    test('toJson serializes populated fields', () {
      final item = SpecialInterviewItem(
        id: 42,
        childName: 'Kidus',
        guardianName: 'Beti',
        guardianPhone: '0911-123-456',
        age: 9,
        guardianEmail: 'kidus@example.com',
        specialRequests: 'Interpreter',
        videoUrl: 'https://youtu.be/abc123',
        upcoming: true,
        approved: false,
      );

      final json = item.toJson();

      expect(json['id'], 42);
      expect(json['childName'], 'Kidus');
      expect(json['guardianName'], 'Beti');
      expect(json['guardianPhone'], 911123456); // Cleaned to numbers
      expect(json['age'], 9);
      expect(json['guardianEmail'], 'kidus@example.com');
      expect(json['specialRequests'], 'Interpreter');
      expect(json['videoUrl'], 'https://youtu.be/abc123');
      expect(json['upcoming'], true);
      expect(json['approved'], false);
    });

    test('toJsonForCreate omits id and includes cleaned phone', () {
      final item = SpecialInterviewItem(
        id: 77,
        childName: 'Sami',
        guardianName: 'Liya',
        guardianPhone: '(+251) 911-456789',
        videoUrl: 'https://video.com/xyz',
      );

      final json = item.toJsonForCreate();

      expect(json.containsKey('id'), false);
      expect(json['guardianPhone'], 251911456789);
      expect(json['videoUrl'], 'https://video.com/xyz');
    });

    test('toJsonForPatch uses default values when fields are null', () {
      final item = SpecialInterviewItem(id: 5);

      final json = item.toJsonForPatch();

      expect(json['id'], 5);
      expect(json['childName'], '');
      expect(json['guardianName'], '');
      expect(json['guardianPhone'], 0);
      expect(json['age'], 0);
      expect(json['guardianEmail'], '');
      expect(json['specialRequests'], '');
      expect(json['videoUrl'], '');
      expect(json['upcoming'], false);
      expect(json['approved'], false);
    });

    test('fromJson parses all fields correctly', () {
      final json = {
        'id': 8,
        'childName': 'Abel',
        'guardianName': 'Tsion',
        'guardianPhone': '011223344',
        'age': 11,
        'guardianEmail': 'abel@example.com',
        'specialRequests': 'Audio help',
        'videoUrl': 'https://vimeo.com/xyz',
        'upcoming': true,
        'approved': true,
      };

      final item = SpecialInterviewItem.fromJson(json);

      expect(item.id, 8);
      expect(item.childName, 'Abel');
      expect(item.guardianPhone, '011223344');
      expect(item.age, 11);
      expect(item.videoUrl, 'https://vimeo.com/xyz');
      expect(item.upcoming, true);
      expect(item.approved, true);
    });
  });
}