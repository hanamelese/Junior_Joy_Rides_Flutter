import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/specialInterview_repository.dart';

abstract class SpecialInterviewUseCases {
  final SpecialInterviewRepository repository;

  SpecialInterviewUseCases(this.repository);

  Future<List<SpecialInterviewItem>> getAllSpecialInterviews();
  Future<SpecialInterviewItem?> getSpecialInterviewById(int id);
  Future<SpecialInterviewItem> addSpecialInterview(SpecialInterviewItem specialInterview);
  Future<SpecialInterviewItem?> updateSpecialInterview(SpecialInterviewItem specialInterview);
  Future<void> deleteSpecialInterview(int id);
}