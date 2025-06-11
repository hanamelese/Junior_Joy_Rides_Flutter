// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:junior_flutter/features/crud/presentation/view_model/basic_interview_view_model.dart';
//
//
// class InterviewManagementScreen extends ConsumerStatefulWidget {
//   const InterviewManagementScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<InterviewManagementScreen> createState() => _InterviewManagementScreenState();
// }
//
// class _InterviewManagementScreenState extends ConsumerState<InterviewManagementScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch all interviews once on screen load
//     Future.microtask(() => ref.read(basicInterviewProvider).fetchAllBasicInterviews());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final interviewVM = ref.watch(basicInterviewProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Interview Management'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => ref.read(basicInterviewProvider).fetchAllBasicInterviews(),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: interviewVM.loading
//             ? const Center(child: CircularProgressIndicator())
//             : interviewVM.error != null
//             ? Center(child: Text('Error: ${interviewVM.error}'))
//             : interviewVM.interviews.isEmpty
//             ? const Center(child: Text('No interviews found.'))
//             : ListView.builder(
//           itemCount: interviewVM.interviews.length,
//           itemBuilder: (context, index) {
//             final interview = interviewVM.interviews[index];
//             return Card(
//               child: ListTile(
//                 title: Text(interview.childName ?? 'No Name'),
//                 subtitle: Text('ID: ${interview.id}\n'
//                     'Guardian: ${interview.guardianName ?? 'N/A'}\n'
//                     'Phone: ${interview.guardianPhone ?? 'N/A'}'),
//                 trailing: Icon(interview.approved == true ? Icons.check_circle : Icons.pending),
//                 isThreeLine: true,
//                 onTap: () async {
//                   await ref.read(basicInterviewProvider).fetchBasicInterviewById(interview.id!);
//                   _showInterviewDetails(context);
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           ref.read(basicInterviewProvider).clear();
//           _showInterviewDetails(context, isNew: true);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
//
//   void _showInterviewDetails(BuildContext context, {bool isNew = false}) {
//     final interviewVM = ref.read(basicInterviewProvider);
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             top: 16,
//             left: 16,
//             right: 16,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   isNew ? 'Add New Interview' : 'Edit Interview',
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: interviewVM.childNameCtr,
//                   decoration: const InputDecoration(labelText: 'Child Name'),
//                 ),
//                 TextField(
//                   controller: interviewVM.guardianNameCtr,
//                   decoration: const InputDecoration(labelText: 'Guardian Name'),
//                 ),
//                 TextField(
//                   controller: interviewVM.guardianPhoneCtr,
//                   decoration: const InputDecoration(labelText: 'Guardian Phone'),
//                   keyboardType: TextInputType.phone,
//                 ),
//                 TextField(
//                   controller: interviewVM.ageCtr,
//                   decoration: const InputDecoration(labelText: 'Age'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 TextField(
//                   controller: interviewVM.guardianEmailCtr,
//                   decoration: const InputDecoration(labelText: 'Guardian Email'),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 TextField(
//                   controller: interviewVM.specialRequestsCtr,
//                   decoration: const InputDecoration(labelText: 'Special Requests'),
//                   maxLines: 2,
//                 ),
//                 SwitchListTile(
//                   title: const Text('Upcoming'),
//                   value: interviewVM.upcoming ?? true,
//                   onChanged: (val) => interviewVM.setUpcoming(val),
//                 ),
//                 SwitchListTile(
//                   title: const Text('Approved'),
//                   value: interviewVM.approved ?? false,
//                   onChanged: (val) => interviewVM.setApproved(val),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     if (!isNew)
//                       TextButton.icon(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         label: const Text('Delete', style: TextStyle(color: Colors.red)),
//                         onPressed: () async {
//                           if (interviewVM.id != null) {
//                             await interviewVM.deleteBasicInterview(interviewVM.id!);
//                             Navigator.of(context).pop();
//                           }
//                         },
//                       ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         await interviewVM.saveBasicInterview();
//                         if (interviewVM.error == null) {
//                           Navigator.of(context).pop();
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Error: ${interviewVM.error}')),
//                           );
//                         }
//                       },
//                       child: const Text('Save'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/basic_interview_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/special_interview_view_model.dart';

class InterviewManagementScreen extends ConsumerStatefulWidget {
  const InterviewManagementScreen({super.key});

  @override
  ConsumerState<InterviewManagementScreen> createState() => _InterviewManagementScreenState();
}

class _InterviewManagementScreenState extends ConsumerState<InterviewManagementScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data once when the widget is initialized
    Future.microtask(() {
      ref.read(basicInterviewProvider.notifier).fetchAllBasicInterviews();
      ref.read(specialInterviewProvider.notifier).fetchAllSpecialInterviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the basic and special interview providers
    final basicInterviewState = ref.watch(basicInterviewProvider);
    final specialInterviewState = ref.watch(specialInterviewProvider);

    // Filter special interviews by approval status
    final videosForApproval = specialInterviewState.specialInterviews
        .where((interview) => interview.approved == false)
        .toList();
    final approvedVideos = specialInterviewState.specialInterviews
        .where((interview) => interview.approved == true)
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          // Recent Basic Interviews
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RECENT BASIC INTERVIEWS",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (basicInterviewState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (basicInterviewState.error != null)
                    Text(
                      'Error: ${basicInterviewState.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else if (basicInterviewState.interviews.isEmpty)
                      const Text('No basic interviews')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: basicInterviewState.interviews.length,
                        itemBuilder: (context, index) {
                          final interview = basicInterviewState.interviews[index];
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      "${interview.childName}'s Interview",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "${interview.childName} sent basic interview request",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "... Show More",
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary),
                                ),
                              ),
                              if (index < basicInterviewState.interviews.length - 1)
                                const Divider(
                                  height: 16,
                                  thickness: 1,
                                  color: Colors.black12,
                                ),
                            ],
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
          // Videos for Approval
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VIDEOS FOR APPROVAL",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (specialInterviewState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (specialInterviewState.error != null)
                    Text(
                      'Error: ${specialInterviewState.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else if (videosForApproval.isEmpty)
                      const Text('No videos for approval')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (videosForApproval.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          final startIndex = index * 2;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (startIndex < videosForApproval.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 16, bottom: 8),
                                    child: VideoCard(
                                      name: videosForApproval[startIndex].childName ??
                                          'Unknown',
                                      age: videosForApproval[startIndex].age ?? 0,
                                      dateTime:
                                      videosForApproval[startIndex].specialRequests,
                                      isApprovedSection: false,
                                      onApprove: () {
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .setApproved(true);
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .saveSpecialInterview();
                                      },
                                      onCancel: () {
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .deleteSpecialInterview(
                                            videosForApproval[startIndex].id!);
                                      },
                                    ),
                                  ),
                                ),
                              if (startIndex + 1 < videosForApproval.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 16, bottom: 8),
                                    child: VideoCard(
                                      name: videosForApproval[startIndex + 1]
                                          .childName ??
                                          'Unknown',
                                      age:
                                      videosForApproval[startIndex + 1].age ?? 0,
                                      dateTime: videosForApproval[startIndex + 1]
                                          .specialRequests,
                                      isApprovedSection: false,
                                      onApprove: () {
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .setApproved(true);
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .saveSpecialInterview();
                                      },
                                      onCancel: () {
                                        ref
                                            .read(specialInterviewProvider.notifier)
                                            .deleteSpecialInterview(
                                            videosForApproval[startIndex + 1].id!);
                                      },
                                    ),
                                  ),
                                )
                              else
                                const Spacer(),
                            ],
                          );
                        },
                      ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Show More logic (can be implemented to fetch more data if needed)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5AE3D),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Show More"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Videos that have been Approved
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VIDEOS THAT HAVE BEEN APPROVED",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (specialInterviewState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (specialInterviewState.error != null)
                    Text(
                      'Error: ${specialInterviewState.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else if (approvedVideos.isEmpty)
                      const Text('No approved videos')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (approvedVideos.length / 2).ceil(),
                        itemBuilder: (context, index) {
                          final startIndex = index * 2;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (startIndex < approvedVideos.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, top: 8, bottom: 8),
                                    child: VideoCard(
                                      name: approvedVideos[startIndex].childName ??
                                          'Unknown',
                                      age: approvedVideos[startIndex].age ?? 0,
                                      contact:
                                      approvedVideos[startIndex].guardianEmail,
                                      isApprovedSection: true,
                                    ),
                                  ),
                                ),
                              if (startIndex + 1 < approvedVideos.length)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 8, bottom: 8),
                                    child: VideoCard(
                                      name: approvedVideos[startIndex + 1].childName ??
                                          'Unknown',
                                      age: approvedVideos[startIndex + 1].age ?? 0,
                                      contact: approvedVideos[startIndex + 1]
                                          .guardianEmail,
                                      isApprovedSection: true,
                                    ),
                                  ),
                                )
                              else
                                const Spacer(),
                            ],
                          );
                        },
                      ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Show More logic (can be implemented to fetch more data if needed)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC5AE3D),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Show More"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String name;
  final int age;
  final String? dateTime;
  final String? contact;
  final bool isApprovedSection;
  final VoidCallback? onApprove;
  final VoidCallback? onCancel;

  const VideoCard({
    super.key,
    required this.name,
    required this.age,
    this.dateTime,
    this.contact,
    required this.isApprovedSection,
    this.onApprove,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.videocam),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("Name: $name"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("Age: $age"),
            ),
            if (isApprovedSection && contact != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text("Contact: $contact"),
              ),
            if (!isApprovedSection && dateTime != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text("Details: $dateTime"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: onApprove,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          child: Text(
                            "Approve",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ElevatedButton(
                          onPressed: onCancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE53935),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}