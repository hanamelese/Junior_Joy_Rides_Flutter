import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/basicInterview_repository.dart';

abstract class BasicInterviewUseCases {
  final BasicInterviewRepository repository;

  BasicInterviewUseCases(this.repository);

  Future<List<BasicInterviewItem>> getAllBasicInterviews();
  Future<BasicInterviewItem?> getBasicInterviewById(int id);
  Future<BasicInterviewItem> addBasicInterview(BasicInterviewItem basicInterview);
  Future<BasicInterviewItem?> updateBasicInterview(BasicInterviewItem basicInterview);
  Future<void> deleteBasicInterview(int id);
}