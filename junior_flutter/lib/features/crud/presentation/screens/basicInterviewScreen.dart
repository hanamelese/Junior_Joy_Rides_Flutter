import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/basic_interview_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';

class BasicInterviewScreen extends ConsumerStatefulWidget {
  final int? interviewId;

  const BasicInterviewScreen({super.key, this.interviewId});

  @override
  _BasicInterviewScreenState createState() => _BasicInterviewScreenState();
}

class _BasicInterviewScreenState extends ConsumerState<BasicInterviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    print('BasicInterviewScreen initialized with interviewId: ${widget.interviewId}');
    if (widget.interviewId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(basicInterviewProvider.notifier).fetchBasicInterviewById(widget.interviewId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final basicInterviewState = ref.watch(basicInterviewProvider);
    final userState = ref.watch(userProvider);

    // Listen for errors to show error SnackBar
    ref.listen<BasicInterviewProvider>(basicInterviewProvider, (previous, next) {
      print('ref.listen triggered: '
          'previous.error=${previous?.error}, next.error=${next.error}, '
          'previous.loading=${previous?.loading}, next.loading=${next.loading}');
      if (next.error != null && next.error != previous?.error) {
        if (mounted) {
          print('Showing error SnackBar: ${next.error}');
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(next.error ?? 'Unknown error'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 150,
                left: 16,
                right: 16,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    });

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: basicInterviewState.loading || userState.loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 64.0), // Increased bottom padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Interview',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(thickness: 1, color: Colors.black),
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Basic Interview',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFC5AE3D),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 1.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/talentShow');
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Talent Show',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(thickness: 7, color: Color(0xFFC5AE3D)),
                        ),
                        Expanded(
                          child: Divider(thickness: 7, color: Color(0xFFD9D9D9)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if (basicInterviewState.error != null)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  basicInterviewState.error!,
                                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                                ),
                              ),
                            CustomTextField(
                              controller: basicInterviewState.childNameCtr,
                              labelText: "Child's Name",
                              prefixIcon: Icons.person,
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            CustomTextField(
                              controller: basicInterviewState.guardianNameCtr,
                              labelText: "Guardian's Name",
                              prefixIcon: Icons.person,
                              validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                            ),
                            CustomTextField(
                              controller: basicInterviewState.guardianPhoneCtr,
                              labelText: 'Phone',
                              prefixIcon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                if (!RegExp(r'^\+?\d+$').hasMatch(value)) return 'Enter a valid phone number (digits only)';
                                return null;
                              },
                            ),
                            CustomTextField(
                              controller: basicInterviewState.ageCtr,
                              labelText: 'Age',
                              prefixIcon: Icons.cake,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                if (int.tryParse(value) == null) return 'Enter a valid number';
                                return null;
                              },
                            ),
                            CustomTextField(
                              controller: basicInterviewState.guardianEmailCtr,
                              labelText: 'Email',
                              prefixIcon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Required';
                                if (!value.contains('@')) return 'Enter a valid email';
                                return null;
                              },
                            ),
                            CustomTextField(
                              controller: basicInterviewState.specialRequestsCtr,
                              labelText: 'Special Requests',
                              prefixIcon: Icons.note,
                            ),
                            const SizedBox(height: 70),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: basicInterviewState.loading
                                    ? null
                                    : () async {
                                  print('Submit button pressed');
                                  if (_formKey.currentState!.validate()) {
                                    print('Form validation passed, calling saveBasicInterview');
                                    try {
                                      await ref.read(basicInterviewProvider.notifier).saveBasicInterview();
                                      print('saveBasicInterview completed');
                                      if (!mounted) return;
                                      final state = ref.read(basicInterviewProvider);
                                      if (state.error == null) {
                                        print('Showing success SnackBar');
                                        _scaffoldMessengerKey.currentState?.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              state.id != null
                                                  ? 'Interview updated successfully'
                                                  : 'Interview added successfully',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                            backgroundColor: Colors.black,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).size.height - 150,
                                              left: 16,
                                              right: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            duration: const Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      print('Error in saveBasicInterview: $e');
                                      if (mounted) {
                                        _scaffoldMessengerKey.currentState?.showSnackBar(
                                          SnackBar(
                                            content: Text('Failed to save: $e'),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).size.height - 150,
                                              left: 16,
                                              right: 16,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            duration: const Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    print('Form validation failed');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC5AE3D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: basicInterviewState.loading
                                    ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text('Saving', style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ],
                                )
                                    : const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}