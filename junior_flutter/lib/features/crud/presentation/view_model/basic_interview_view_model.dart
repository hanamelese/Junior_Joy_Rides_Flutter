import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/usecase/basic_interview_use_cases_provider.dart';

class BasicInterviewProvider extends ChangeNotifier {
  final Ref ref;
  bool loading = false;
  String? error;
  List<BasicInterviewItem> interviews = [];
  BasicInterviewItem? currentInterview;
  final childNameCtr = TextEditingController();
  final guardianNameCtr = TextEditingController();
  final guardianPhoneCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final guardianEmailCtr = TextEditingController();
  final specialRequestsCtr = TextEditingController();
  bool? upcoming = true;
  bool? approved = false;
  int? id;

  BasicInterviewProvider(this.ref);

  Future<void> fetchAllBasicInterviews() async {
    print('fetchAllBasicInterviews called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      interviews = await ref.read(basicInterviewUseCasesProvider).getAllBasicInterviews();
      print('Fetched ${interviews.length} interviews');
    } catch (e) {
      error = e.toString();
      print('Fetch all interviews error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBasicInterviewById(int interviewId) async {
    print('fetchBasicInterviewById called for id: $interviewId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      currentInterview = await ref.read(basicInterviewUseCasesProvider).getBasicInterviewById(interviewId);
      if (currentInterview != null) {
        id = currentInterview!.id;
        childNameCtr.text = currentInterview!.childName ?? '';
        guardianNameCtr.text = currentInterview!.guardianName ?? '';
        guardianPhoneCtr.text = currentInterview!.guardianPhone ?? '';
        ageCtr.text = currentInterview!.age?.toString() ?? '';
        guardianEmailCtr.text = currentInterview!.guardianEmail ?? '';
        specialRequestsCtr.text = currentInterview!.specialRequests ?? '';
        upcoming = currentInterview!.upcoming;
        approved = currentInterview!.approved;
        print('Fetched interview: ${currentInterview!.toJson()}');
      } else {
        error = 'Interview not found';
        print('Interview not found for id: $interviewId');
      }
    } catch (e) {
      error = e.toString();
      print('Fetch interview error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> saveBasicInterview() async {
    print('saveBasicInterview called, id: $id');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final interview = BasicInterviewItem(
        id: id,
        childName: childNameCtr.text,
        guardianName: guardianNameCtr.text,
        guardianPhone: guardianPhoneCtr.text.replaceAll(RegExp(r'[^0-9]'), ''),
        age: int.tryParse(ageCtr.text),
        guardianEmail: guardianEmailCtr.text,
        specialRequests: specialRequestsCtr.text,
        upcoming: upcoming,
        approved: approved,
      );

      if (id == null) {
        print('Creating new interview');
        currentInterview = await ref.read(basicInterviewUseCasesProvider).addBasicInterview(interview);
        id = currentInterview!.id; // Set id for future updates
        print('Added new interview: ${currentInterview!.toJson()}');
      } else {
        print('Updating interview with id: $id');
        currentInterview = await ref.read(basicInterviewUseCasesProvider).updateBasicInterview(interview);
        if (currentInterview == null) {
          error = 'Failed to update interview';
          print('Update returned null for id: $id');
        } else {
          print('Updated interview: ${currentInterview!.toJson()}');
        }
      }
    } catch (e) {
      error = e.toString();
      print('Save interview error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBasicInterview(int interviewId) async {
    print('deleteBasicInterview called for id: $interviewId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      await ref.read(basicInterviewUseCasesProvider).deleteBasicInterview(interviewId);
      interviews.removeWhere((interview) => interview.id == interviewId);
      if (currentInterview?.id == interviewId) {
        currentInterview = null;
        clear();
      }
      print('Deleted interview id: $interviewId');
    } catch (e) {
      error = e.toString();
      print('Delete interview error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setUpcoming(bool? value) {
    upcoming = value;
    notifyListeners();
  }

  void setApproved(bool? value) {
    approved = value;
    notifyListeners();
  }

  void clear() {
    id = null;
    childNameCtr.clear();
    guardianNameCtr.clear();
    guardianPhoneCtr.clear();
    ageCtr.clear();
    guardianEmailCtr.clear();
    specialRequestsCtr.clear();
    upcoming = true;
    approved = false;
    error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    childNameCtr.dispose();
    guardianNameCtr.dispose();
    guardianPhoneCtr.dispose();
    ageCtr.dispose();
    guardianEmailCtr.dispose();
    specialRequestsCtr.dispose();
    super.dispose();
  }
}

final basicInterviewProvider = ChangeNotifierProvider<BasicInterviewProvider>((ref) => BasicInterviewProvider(ref));