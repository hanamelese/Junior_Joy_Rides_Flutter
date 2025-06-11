import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/usecase/special_interview_use_cases.dart';
import 'package:junior_flutter/features/crud/domain/usecase/special_interview_use_cases_impl.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/specialInterviewRepositoryProvider.dart';

final specialInterviewUseCasesProvider = Provider<SpecialInterviewUseCasesImpl>((ref) {
  final repository = ref.watch(specialInterviewRepositoryProvider);
  return SpecialInterviewUseCasesImpl(repository);
});