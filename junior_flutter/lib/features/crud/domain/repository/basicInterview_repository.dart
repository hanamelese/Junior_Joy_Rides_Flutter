import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';

abstract class BasicInterviewRepository {
  Future<List<BasicInterviewItem>> getAllBasicInterviews();
  Future<BasicInterviewItem?> getBasicInterviewById(int id); // Nullable if not found
  Future<BasicInterviewItem> addBasicInterview(BasicInterviewItem basicInterview);
  Future<BasicInterviewItem?> updateBasicInterview(BasicInterviewItem basicInterview);
  Future<void> deleteSpecialInterview(int id);
}