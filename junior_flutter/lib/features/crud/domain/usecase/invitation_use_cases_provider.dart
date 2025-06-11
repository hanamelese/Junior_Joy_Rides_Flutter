import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/usecase/invitation_use_cases.dart';
import 'package:junior_flutter/features/crud/domain/usecase/invitation_use_cases_impl.dart';
import 'package:junior_flutter/features/crud/infrastructure/repository/invitationRepositoryProvider.dart';

final invitationUseCasesProvider = Provider<InvitationUseCasesImpl>((ref) {
  final repository = ref.watch(invitationRepositoryProvider);
  return InvitationUseCasesImpl(repository);
});