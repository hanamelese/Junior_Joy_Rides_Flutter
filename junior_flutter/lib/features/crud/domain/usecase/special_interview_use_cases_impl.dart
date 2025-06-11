import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/specialInterview_repository.dart';
import 'package:junior_flutter/features/crud/domain/usecase/special_interview_use_cases.dart';

class SpecialInterviewUseCasesImpl implements SpecialInterviewUseCases {
  @override
  final SpecialInterviewRepository repository;

  SpecialInterviewUseCasesImpl(this.repository);

  @override
  Future<List<SpecialInterviewItem>> getAllSpecialInterviews() => repository.getAllSpecialInterviews();

  @override
  Future<SpecialInterviewItem?> getSpecialInterviewById(int id) => repository.getSpecialInterviewById(id);

  @override
  Future<SpecialInterviewItem> addSpecialInterview(SpecialInterviewItem specialInterview) => repository.addSpecialInterview(specialInterview);

  @override
  Future<SpecialInterviewItem?> updateSpecialInterview(SpecialInterviewItem specialInterview) => repository.updateSpecialInterview(specialInterview);

  @override
  Future<void> deleteSpecialInterview(int id) => repository.deleteSpecialInterview(id);
}