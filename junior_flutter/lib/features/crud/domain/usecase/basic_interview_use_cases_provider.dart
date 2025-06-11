import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/usecase/basic_interview_use_cases.dart';
import 'package:junior_flutter/features/crud/domain/usecase/basic_interview_use_cases_impl.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/basicInterviewRepositoryProvider.dart';

final basicInterviewUseCasesProvider = Provider<BasicInterviewUseCasesImpl>((ref) {
  final repository = ref.watch(basicInterviewRepositoryProvider);
  return BasicInterviewUseCasesImpl(repository);
});