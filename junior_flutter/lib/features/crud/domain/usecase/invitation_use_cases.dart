import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
import 'package:junior_flutter/features/crud/domain/repository/invitation_repository.dart';

abstract class InvitationUseCases {
  final InvitationRepository repository;

  InvitationUseCases(this.repository);

  Future<List<InvitationItem>> getAllInvitations();
  Future<InvitationItem?> getInvitationById(int id);
  Future<InvitationItem> addInvitation(InvitationItem invitation);
  Future<InvitationItem?> updateInvitation(InvitationItem invitation);
  Future<void> deleteInvitation(int id);
}