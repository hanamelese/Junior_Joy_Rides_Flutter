import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/invitationItem.dart';
import 'package:junior_flutter/features/crud/domain/usecase/invitation_use_cases_provider.dart';

class InvitationProvider extends ChangeNotifier {
  final Ref ref;
  bool loading = false;
  String? error;
  List<InvitationItem> invitations = [];
  InvitationItem? currentInvitation;
  final childNameCtr = TextEditingController();
  final guardianPhoneCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final guardianEmailCtr = TextEditingController();
  final specialRequestsCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final dateCtr = TextEditingController();
  final timeCtr = TextEditingController();
  bool? upcoming = true;
  bool? approved = false;
  int? id;

  InvitationProvider(this.ref);

  Future<void> fetchAllInvitations() async {
    print('fetchAllInvitations called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      invitations = await ref.read(invitationUseCasesProvider).getAllInvitations();
      print('Fetched ${invitations.length} invitations');
    } catch (e) {
      error = e.toString();
      print('Fetch all invitations error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchInvitationById(int invitationId) async {
    print('fetchInvitationById called for id: $invitationId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      currentInvitation = await ref.read(invitationUseCasesProvider).getInvitationById(invitationId);
      if (currentInvitation != null) {
        id = currentInvitation!.id;
        childNameCtr.text = currentInvitation!.childName ?? '';
        guardianPhoneCtr.text = currentInvitation!.guardianPhone ?? '';
        ageCtr.text = currentInvitation!.age?.toString() ?? '';
        guardianEmailCtr.text = currentInvitation!.guardianEmail ?? '';
        specialRequestsCtr.text = currentInvitation!.specialRequests ?? '';
        addressCtr.text = currentInvitation!.address ?? '';
        dateCtr.text = currentInvitation!.date ?? '';
        timeCtr.text = currentInvitation!.time ?? '';
        upcoming = currentInvitation!.upcoming;
        approved = currentInvitation!.approved;
        print('Fetched invitation: ${currentInvitation!.toJson()}');
      } else {
        error = 'Invitation not found';
        print('Invitation not found for id: $invitationId');
      }
    } catch (e) {
      error = e.toString();
      print('Fetch invitation error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> saveInvitation() async {
    print('saveInvitation called, id: $id');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final invitation = InvitationItem(
        id: id,
        childName: childNameCtr.text,
        guardianPhone: guardianPhoneCtr.text.replaceAll(RegExp(r'[^0-9]'), ''),
        age: int.tryParse(ageCtr.text),
        guardianEmail: guardianEmailCtr.text,
        specialRequests: specialRequestsCtr.text,
        address: addressCtr.text,
        date: dateCtr.text,
        time: timeCtr.text,
        upcoming: upcoming,
        approved: approved,
      );

      if (id == null) {
        currentInvitation = await ref.read(invitationUseCasesProvider).addInvitation(invitation);
        print('Added new invitation: ${currentInvitation!.toJson()}');
      } else {
        currentInvitation = await ref.read(invitationUseCasesProvider).updateInvitation(invitation);
        if (currentInvitation == null) {
          error = 'Failed to update invitation';
          print('Update returned null for id: $id');
        } else {
          print('Updated invitation: ${currentInvitation!.toJson()}');
        }
      }
    } catch (e) {
      error = e.toString();
      print('Save invitation error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteInvitation(int invitationId) async {
    print('deleteInvitation called for id: $invitationId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      await ref.read(invitationUseCasesProvider).deleteInvitation(invitationId);
      invitations.removeWhere((invitation) => invitation.id == invitationId);
      if (currentInvitation?.id == invitationId) {
        currentInvitation = null;
        clear();
      }
      print('Deleted invitation id: $invitationId');
    } catch (e) {
      error = e.toString();
      print('Delete invitation error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void clear() {
    id = null;
    childNameCtr.clear();
    guardianPhoneCtr.clear();
    ageCtr.clear();
    guardianEmailCtr.clear();
    specialRequestsCtr.clear();
    addressCtr.clear();
    dateCtr.clear();
    timeCtr.clear();
    upcoming = true;
    approved = false;
    error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    childNameCtr.dispose();
    guardianPhoneCtr.dispose();
    ageCtr.dispose();
    guardianEmailCtr.dispose();
    specialRequestsCtr.dispose();
    addressCtr.dispose();
    dateCtr.dispose();
    timeCtr.dispose();
    super.dispose();
  }
}

final invitationProvider = ChangeNotifierProvider<InvitationProvider>((ref) => InvitationProvider(ref));