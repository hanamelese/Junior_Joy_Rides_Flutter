// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
// import 'package:junior_flutter/features/crud/domain/usecase/special_interview_use_cases_provider.dart';
//
// class SpecialInterviewProvider extends ChangeNotifier {
//   final Ref ref;
//   bool loading = false;
//   String? error;
//   List<SpecialInterviewItem> specialInterviews = [];
//   SpecialInterviewItem? currentInterview;
//   final childNameCtr = TextEditingController();
//   final guardianNameCtr = TextEditingController();
//   final guardianPhoneCtr = TextEditingController();
//   final ageCtr = TextEditingController();
//   final guardianEmailCtr = TextEditingController();
//   final specialRequestsCtr = TextEditingController();
//   final videoUrlCtr = TextEditingController();
//   bool? upcoming = true;
//   bool? approved = false;
//   int? id;
//
//   SpecialInterviewProvider(this.ref);
//
//   Future<void> fetchAllSpecialInterviews() async {
//     print('fetchAllSpecialInterviews called');
//     if (loading) return;
//     loading = true;
//     error = null;
//     notifyListeners();
//
//     try {
//       specialInterviews = await ref.read(specialInterviewUseCasesProvider).getAllSpecialInterviews();
//       print('Fetched ${specialInterviews.length} special interviews');
//     } catch (e) {
//       error = e.toString();
//       print('Fetch all special interviews error: $error');
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> fetchSpecialInterviewById(int interviewId) async {
//     print('fetchSpecialInterviewById called for id: $interviewId');
//     if (loading) return;
//     loading = true;
//     error = null;
//     notifyListeners();
//
//     try {
//       currentInterview = await ref.read(specialInterviewUseCasesProvider).getSpecialInterviewById(interviewId);
//       if (currentInterview != null) {
//         id = currentInterview!.id;
//         childNameCtr.text = currentInterview!.childName ?? '';
//         guardianNameCtr.text = currentInterview!.guardianName ?? '';
//         guardianPhoneCtr.text = currentInterview!.guardianPhone ?? '';
//         ageCtr.text = currentInterview!.age?.toString() ?? '';
//         guardianEmailCtr.text = currentInterview!.guardianEmail ?? '';
//         specialRequestsCtr.text = currentInterview!.specialRequests ?? '';
//         videoUrlCtr.text = currentInterview!.videoUrl ?? '';
//         upcoming = currentInterview!.upcoming;
//         approved = currentInterview!.approved;
//         print('Fetched interview: ${currentInterview!.toJson()}');
//       } else {
//         error = 'Interview not found';
//         print('Interview not found for id: $interviewId');
//       }
//     } catch (e) {
//       error = e.toString();
//       print('Fetch special interview error: $error');
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> saveSpecialInterview() async {
//     print('saveSpecialInterview called, id: $id');
//     if (loading) return;
//     loading = true;
//     error = null;
//     notifyListeners();
//
//     try {
//       final specialInterview = SpecialInterviewItem(
//         id: id,
//         childName: childNameCtr.text,
//         guardianName: guardianNameCtr.text,
//         guardianPhone: guardianPhoneCtr.text,
//         age: int.tryParse(ageCtr.text),
//         guardianEmail: guardianEmailCtr.text,
//         specialRequests: specialRequestsCtr.text,
//         videoUrl: videoUrlCtr.text,
//         upcoming: upcoming,
//         approved: approved,
//       );
//
//       if (id == null) {
//         // Add new interview
//         currentInterview = await ref.read(specialInterviewUseCasesProvider).addSpecialInterview(specialInterview);
//         print('Added new interview: ${currentInterview!.toJson()}');
//       } else {
//         // Update existing interview
//         currentInterview = await ref.read(specialInterviewUseCasesProvider).updateSpecialInterview(specialInterview);
//         if (currentInterview == null) {
//           error = 'Failed to update interview';
//           print('Update returned null for id: $id');
//         } else {
//           print('Updated interview: ${currentInterview!.toJson()}');
//         }
//       }
//     } catch (e) {
//       error = e.toString();
//       print('Save special interview error: $error');
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
//
//   Future<void> deleteSpecialInterview(int interviewId) async {
//     print('deleteSpecialInterview called for id: $interviewId');
//     if (loading) return;
//     loading = true;
//     error = null;
//     notifyListeners();
//
//     try {
//       await ref.read(specialInterviewUseCasesProvider).deleteSpecialInterview(interviewId);
//       specialInterviews.removeWhere((interview) => interview.id == interviewId);
//       if (currentInterview?.id == interviewId) {
//         currentInterview = null;
//         clear();
//       }
//       print('Deleted interview id: $interviewId');
//     } catch (e) {
//       error = e.toString();
//       print('Delete special interview error: $error');
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
//
//   void clear() {
//     id = null;
//     childNameCtr.clear();
//     guardianNameCtr.clear();
//     guardianPhoneCtr.clear();
//     ageCtr.clear();
//     guardianEmailCtr.clear();
//     specialRequestsCtr.clear();
//     videoUrlCtr.clear();
//     upcoming = true;
//     approved = false;
//     error = null;
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     childNameCtr.dispose();
//     guardianNameCtr.dispose();
//     guardianPhoneCtr.dispose();
//     ageCtr.dispose();
//     guardianEmailCtr.dispose();
//     specialRequestsCtr.dispose();
//     videoUrlCtr.dispose();
//     super.dispose();
//   }
// }
//
// final specialInterviewProvider = ChangeNotifierProvider<SpecialInterviewProvider>((ref) => SpecialInterviewProvider(ref));




import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/specialInterviewItem.dart';
import 'package:junior_flutter/features/crud/domain/usecase/special_interview_use_cases_provider.dart';

class SpecialInterviewProvider extends ChangeNotifier {
  final Ref ref;
  bool loading = false;
  String? error;
  List<SpecialInterviewItem> specialInterviews = [];
  SpecialInterviewItem? currentInterview;
  final childNameCtr = TextEditingController();
  final guardianNameCtr = TextEditingController();
  final guardianPhoneCtr = TextEditingController();
  final ageCtr = TextEditingController();
  final guardianEmailCtr = TextEditingController();
  final specialRequestsCtr = TextEditingController();
  final videoUrlCtr = TextEditingController();
  bool? upcoming = true;
  bool? approved = false;
  int? id;

  SpecialInterviewProvider(this.ref);

  Future<void> fetchAllSpecialInterviews() async {
    print('fetchAllSpecialInterviews called');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      specialInterviews = await ref.read(specialInterviewUseCasesProvider).getAllSpecialInterviews();
      print('Fetched ${specialInterviews.length} interviews');
    } catch (e) {
      error = e.toString();
      print('Fetch all interviews error: $error');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSpecialInterviewById(int interviewId) async {
    print('fetchSpecialInterviewById called for id: $interviewId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      currentInterview = await ref.read(specialInterviewUseCasesProvider).getSpecialInterviewById(interviewId);
      if (currentInterview != null) {
        id = currentInterview!.id;
        childNameCtr.text = currentInterview!.childName ?? '';
        guardianNameCtr.text = currentInterview!.guardianName ?? '';
        guardianPhoneCtr.text = currentInterview!.guardianPhone ?? '';
        ageCtr.text = currentInterview!.age?.toString() ?? '';
        guardianEmailCtr.text = currentInterview!.guardianEmail ?? '';
        specialRequestsCtr.text = currentInterview!.specialRequests ?? '';
        videoUrlCtr.text = currentInterview!.videoUrl ?? '';
        upcoming = currentInterview!.upcoming;
        approved = currentInterview!.approved;
        print('Fetched interview: ${currentInterview!.toJson()}, id: $id');
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

  Future<void> saveSpecialInterview() async {
    print('saveSpecialInterview called, id: $id');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      final interview = SpecialInterviewItem(
        id: id,
        childName: childNameCtr.text.isNotEmpty ? childNameCtr.text : null,
        guardianName: guardianNameCtr.text.isNotEmpty ? guardianNameCtr.text : null,
        guardianPhone: guardianPhoneCtr.text.isNotEmpty ? guardianPhoneCtr.text.replaceAll(RegExp(r'[^0-9]'), '') : null,
        age: int.tryParse(ageCtr.text),
        guardianEmail: guardianEmailCtr.text.isNotEmpty ? guardianEmailCtr.text : null,
        specialRequests: specialRequestsCtr.text.isNotEmpty ? specialRequestsCtr.text : null,
        videoUrl: videoUrlCtr.text.isNotEmpty ? videoUrlCtr.text : null,
        upcoming: upcoming,
        approved: approved,
      );

      if (id == null) {
        print('Creating new interview');
        currentInterview = await ref.read(specialInterviewUseCasesProvider).addSpecialInterview(interview);
        id = currentInterview!.id;
        print('Added new interview: ${currentInterview!.toJson()}, id: $id');
      } else {
        print('Updating interview with id: $id');
        currentInterview = await ref.read(specialInterviewUseCasesProvider).updateSpecialInterview(interview);
        if (currentInterview == null) {
          error = 'Failed to update interview';
          print('Update returned null for id: $id');
        } else {
          print('Updated interview: ${currentInterview!.toJson()}, id: $id');
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

  Future<void> deleteSpecialInterview(int interviewId) async {
    print('deleteSpecialInterview called for id: $interviewId');
    if (loading) return;
    loading = true;
    error = null;
    notifyListeners();

    try {
      await ref.read(specialInterviewUseCasesProvider).deleteSpecialInterview(interviewId);
      specialInterviews.removeWhere((interview) => interview.id == interviewId);
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
    videoUrlCtr.clear();
    upcoming = true;
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
    videoUrlCtr.dispose();
    super.dispose();
  }
}

final specialInterviewProvider = ChangeNotifierProvider<SpecialInterviewProvider>((ref) => SpecialInterviewProvider(ref));