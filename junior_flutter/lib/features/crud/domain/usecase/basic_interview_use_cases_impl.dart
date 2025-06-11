import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/basicInterview_repository.dart';
import 'package:junior_flutter/features/crud/domain/usecase/basic_interview_use_cases.dart';

class BasicInterviewUseCasesImpl implements BasicInterviewUseCases {
  @override
  final BasicInterviewRepository repository;

  BasicInterviewUseCasesImpl(this.repository);

  @override
  Future<List<BasicInterviewItem>> getAllBasicInterviews() => repository.getAllBasicInterviews();

  @override
  Future<BasicInterviewItem?> getBasicInterviewById(int id) => repository.getBasicInterviewById(id);

  @override
  Future<BasicInterviewItem> addBasicInterview(BasicInterviewItem basicInterview) => repository.addBasicInterview(basicInterview);

  @override
  Future<BasicInterviewItem?> updateBasicInterview(BasicInterviewItem basicInterview) => repository.updateBasicInterview(basicInterview);

  @override
  Future<void> deleteBasicInterview(int id) => repository.deleteSpecialInterview(id);
}