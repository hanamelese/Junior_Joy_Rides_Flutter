import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/special_interview_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialInterviewScreen extends ConsumerStatefulWidget {
  const SpecialInterviewScreen({super.key});

  @override
  ConsumerState<SpecialInterviewScreen> createState() => _SpecialInterviewScreenState();
}

class _SpecialInterviewScreenState extends ConsumerState<SpecialInterviewScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      final int? id = args != null && args is Map<String, dynamic> ? args['id'] as int? : null;
      if (id != null) {
        ref.read(specialInterviewProvider.notifier).fetchSpecialInterviewById(id).then((_) {
          if (!mounted) return;
          final state = ref.read(specialInterviewProvider);
          print('Fetched interview data: childName=${state.childNameCtr.text}, videoUrl=${state.videoUrlCtr.text}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(specialInterviewProvider);

    ref.listen<SpecialInterviewProvider>(specialInterviewProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              const SizedBox(height: 100),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/interview');
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Basic Interview',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 1.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Talent Show',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC5AE3D)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 7, color: Color(0xFFD9D9D9))),
                      Expanded(child: Divider(thickness: 7, color: Color(0xFFC5AE3D))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enhance your child's talent", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Text(
                          "Upload your child's talent video to participate on our TV show",
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 16.0),
                        Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.videocam_outlined, size: 40, color: Colors.black),
                              onPressed: () async {
                                const googleDriveUrl = 'https://drive.google.com';
                                if (await canLaunchUrl(Uri.parse(googleDriveUrl))) {
                                  await launchUrl(Uri.parse(googleDriveUrl));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Could not open Google Drive")),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextField(
                          controller: provider.videoUrlCtr,
                          labelText: "Video Link",
                          prefixIcon: Icons.link,
                          keyboardType: TextInputType.url,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a video link';
                            }
                            if (!Uri.parse(value).isAbsolute) {
                              return 'Please enter a valid URL';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      CustomTextField(
                        controller: provider.childNameCtr,
                        labelText: "Child's Name",
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the child\'s name';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: provider.ageCtr,
                        labelText: "Age",
                        prefixIcon: Icons.cake,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the age';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: provider.guardianNameCtr,
                        labelText: "Guardian’s Name",
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the guardian\'s name';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: provider.guardianPhoneCtr,
                        labelText: "Phone",
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          final numericPhone = value.replaceAll(RegExp(r'[^0-9]'), '');
                          if (numericPhone.isEmpty || int.tryParse(numericPhone) == null) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: provider.guardianEmailCtr,
                        labelText: "Email",
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: provider.specialRequestsCtr,
                        labelText: "Special Requests",
                        prefixIcon: Icons.note,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: provider.loading
                            ? null
                            : () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await provider.saveSpecialInterview();
                              if (!mounted) return;
                              if (provider.error == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Submission successful")),
                                );
                                provider.clear();
                                final args = ModalRoute.of(context)!.settings.arguments;
                                if (args != null && args is Map<String, dynamic> && args['id'] != null) {
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Error: ${provider.error}")),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to save: $e")),
                                );
                              }
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC5AE3D)),
                        child: provider.loading
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
                            : const Text('Submit Request', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}