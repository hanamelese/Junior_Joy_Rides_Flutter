import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/invitation_repository.dart';
import 'package:junior_flutter/features/crud/domain/usecase/invitation_use_cases.dart';

class InvitationUseCasesImpl implements InvitationUseCases {
  @override
  final InvitationRepository repository;

  InvitationUseCasesImpl(this.repository);

  @override
  Future<List<InvitationItem>> getAllInvitations() => repository.getAllInvitations();

  @override
  Future<InvitationItem?> getInvitationById(int id) => repository.getInvitationById(id);

  @override
  Future<InvitationItem> addInvitation(InvitationItem invitation) => repository.addInvitation(invitation);

  @override
  Future<InvitationItem?> updateInvitation(InvitationItem invitation) => repository.updateInvitation(invitation);

  @override
  Future<void> deleteInvitation(int id) => repository.deleteInvitation(id);
}