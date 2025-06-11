import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/invitation_view_model.dart';

class InvitationScreen extends ConsumerStatefulWidget {
  const InvitationScreen({super.key});

  @override
  ConsumerState<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends ConsumerState<InvitationScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _timeInSeconds;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final int? id = args?['id'];
      if (id != null) {
        ref.read(invitationProvider.notifier).fetchInvitationById(id).then((_) {
          if (!mounted) return;
          final state = ref.read(invitationProvider);
          if (state.timeCtr.text.isNotEmpty) {
            _timeInSeconds = int.tryParse(state.timeCtr.text);
            if (_timeInSeconds != null) {
              final hours = _timeInSeconds! ~/ 3600;
              final minutes = (_timeInSeconds! % 3600) ~/ 60;
              final timeOfDay = TimeOfDay(hour: hours, minute: minutes);
              state.timeCtr.text = timeOfDay.format(context);
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final invitationState = ref.watch(invitationProvider);

    ref.listen<InvitationProvider>(invitationProvider, (previous, next) {
      final previousError = previous?.error;
      if (next.error != null && previousError != next.error) {
        if (mounted) {
          print('Showing error SnackBar: ${next.error}');
          ScaffoldMessenger.of(context).showSnackBar(
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: invitationState.loading && invitationState.currentInvitation == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                      child: const Text(
                        'Invite Etopis',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC5AE3D),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 1.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/wishList');
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Wishlist',
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
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 7, color: Color(0xFFC5AE3D))),
                  Expanded(child: Divider(thickness: 7, color: Color(0xFFD9D9D9))),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Book A Mascot',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          if (invitationState.error != null)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                invitationState.error!,
                                style: TextStyle(color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                          CustomTextField(
                            controller: invitationState.childNameCtr,
                            labelText: "Child's Name",
                            prefixIcon: Icons.person,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          CustomTextField(
                            controller: invitationState.ageCtr,
                            labelText: "Age",
                            prefixIcon: Icons.cake,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              if (int.tryParse(v) == null || int.parse(v) <= 0) {
                                return 'Enter a valid age';
                              }
                              return null;
                            },
                          ),
                          GestureDetector(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (date != null) {
                                invitationState.dateCtr.text = date.toIso8601String().split('T')[0];
                              }
                            },
                            child: CustomTextField(
                              controller: invitationState.dateCtr,
                              labelText: "Date of celebration",
                              prefixIcon: Icons.date_range,
                              enabled: false,
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                _timeInSeconds = time.hour * 3600 + time.minute * 60;
                                invitationState.timeCtr.text = _timeInSeconds.toString();
                              }
                            },
                            child: CustomTextField(
                              controller: invitationState.timeCtr,
                              labelText: "Time",
                              prefixIcon: Icons.access_time,
                              enabled: false,
                              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                            ),
                          ),
                          CustomTextField(
                            controller: invitationState.addressCtr,
                            labelText: "Address",
                            prefixIcon: Icons.location_on,
                            validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                          ),
                          CustomTextField(
                            controller: invitationState.specialRequestsCtr,
                            labelText: "Special Requests",
                            prefixIcon: Icons.note,
                          ),
                          CustomTextField(
                            controller: invitationState.guardianPhoneCtr,
                            labelText: "Guardian Phone",
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              final numericPhone = v.replaceAll(RegExp(r'[^0-9]'), '');
                              if (numericPhone.isEmpty || int.tryParse(numericPhone) == null) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: invitationState.guardianEmailCtr,
                            labelText: "Guardian Email",
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Required';
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 70),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: invitationState.loading
                                  ? null
                                  : () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    print('Submitting invitation');
                                    await ref.read(invitationProvider.notifier).saveInvitation();
                                    print('saveInvitation completed');
                                    if (!mounted) return;
                                    final state = ref.watch(invitationProvider);
                                    if (state.error == null) {
                                      print('Showing success SnackBar');
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Invitation submitted successfully!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          backgroundColor: const Color(0x000000),
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).size.height - 150,
                                            left: 16,
                                            right: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          elevation: 8,
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      _timeInSeconds = null;
                                      if (state.timeCtr.text.isNotEmpty) {
                                        final seconds = int.tryParse(state.timeCtr.text);
                                        if (seconds != null) {
                                          final hours = seconds ~/ 3600;
                                          final minutes = (seconds % 3600) ~/ 60;
                                          final timeOfDay = TimeOfDay(hour: hours, minute: minutes);
                                          state.timeCtr.text = timeOfDay.format(context);
                                        }
                                      }
                                    }
                                  } catch (e) {
                                    print('Error in saveInvitation: $e');
                                    if (mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
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
                                              borderRadius: BorderRadius.circular(12)),
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFC5AE3D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: invitationState.loading
                                  ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('Saving...', style: TextStyle(color: Colors.white)),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}