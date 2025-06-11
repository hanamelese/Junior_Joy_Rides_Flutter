import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/usecase/user_use_cases_implementation.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/userRepositoryProvider.dart';

final userUseCasesProvider = Provider<UserUseCasesImpl>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserUseCasesImpl(repository);
});