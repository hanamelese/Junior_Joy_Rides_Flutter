import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';

abstract class InvitationRepository {
  Future<List<InvitationItem>> getAllInvitations();
  Future<InvitationItem?> getInvitationById(int id); // Nullable if not found
  Future<InvitationItem> addInvitation(InvitationItem invitation);
  Future<InvitationItem?> updateInvitation(InvitationItem invitation);
  Future<void> deleteInvitation(int id);
}