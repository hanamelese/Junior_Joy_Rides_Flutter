import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';

abstract class SpecialInterviewRepository {
  Future<List<SpecialInterviewItem>> getAllSpecialInterviews();
  Future<SpecialInterviewItem?> getSpecialInterviewById(int id); // Nullable if not found
  Future<SpecialInterviewItem> addSpecialInterview(SpecialInterviewItem specialInterview);
  Future<SpecialInterviewItem?> updateSpecialInterview(SpecialInterviewItem specialInterview);
  Future<void> deleteSpecialInterview(int id);
}
