// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
// import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';
//
// class EditProfileScreen extends ConsumerStatefulWidget {
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameCtr = TextEditingController();
//   final _lastNameCtr = TextEditingController();
//   final _emailCtr = TextEditingController();
//   final _profileImageUrlCtr = TextEditingController();
//   final _backgroundImageUrlCtr = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     final userProviderState = ref.read(userProvider);
//     final user = userProviderState.user;
//     if (user != null) {
//       _firstNameCtr.text = user.firstName ?? '';
//       _lastNameCtr.text = user.lastName ?? '';
//       _emailCtr.text = user.email ?? '';
//       _profileImageUrlCtr.text = user.profileImageUrl ?? '';
//       _backgroundImageUrlCtr.text = user.backgroundImageUrl ?? '';
//     }
//     // Delay provider modification to avoid build-time mutation
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (user == null) {
//         ref.read(userProvider.notifier).fetchUserProfile();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _firstNameCtr.dispose();
//     _lastNameCtr.dispose();
//     _emailCtr.dispose();
//     _profileImageUrlCtr.dispose();
//     _backgroundImageUrlCtr.dispose();
//     super.dispose();
//   }
//
//   Future<void> _openGoogleDrive() async {
//     const driveUrl = 'https://drive.google.com/drive/my-drive';
//     if (await canLaunchUrl(Uri.parse(driveUrl))) {
//       await launchUrl(Uri.parse(driveUrl), mode: LaunchMode.externalApplication);
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please copy and paste your shared photo link below.'),
//           ),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userProviderState = ref.watch(userProvider);
//     final user = userProviderState.user;
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(bottom: 64.0),
//         child: Column(
//           children: [
//             Container(
//               height: 250.0,
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
//                         height: 200.0,
//                         color: Color(0xFF8E8E8B),
//                       ),
//                     ],
//                   ),
//                   Positioned(
//                     top: 150.0,
//                     left: MediaQuery.of(context).size.width / 2 - 50,
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: AssetImage('assets/profile_picture.jpg'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Card(
//                 elevation: 4,
//                 color: Color(0xFFF9F9F8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 20),
//                         Text(
//                           user?.firstName != null && user?.lastName != null
//                               ? '${user!.firstName} ${user.lastName}'
//                               : 'Full Name',
//                           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           user?.email ?? 'name@gmail.com',
//                           style: TextStyle(fontSize: 18, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 20),
//                         _buildTextField('First Name', 'Enter First Name', _firstNameCtr),
//                         const SizedBox(height: 20),
//                         _buildTextField('Last Name', 'Enter Last Name', _lastNameCtr),
//                         const SizedBox(height: 20),
//                         _buildTextField('Email', 'Enter Email', _emailCtr),
//                         const SizedBox(height: 20),
//                         const Text(
//                           'Profile Picture',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         GestureDetector(
//                           onTap: _openGoogleDrive,
//                           child: _buildPictureContainer('assets/camera_icon.png', _profileImageUrlCtr),
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextField(
//                           controller: _profileImageUrlCtr,
//                           labelText: 'Profile Image URL',
//                           prefixIcon: Icons.link,
//                           validator: (value) {
//                             if (value != null && value.isNotEmpty && !Uri.parse(value).isAbsolute) {
//                               return 'Please enter a valid URL';
//                             }
//                             return null; // No error if empty
//                           },
//                         ),
//                         const SizedBox(height: 30),
//                         const Text(
//                           'Background Picture',
//                           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         GestureDetector(
//                           onTap: _openGoogleDrive,
//                           child: _buildPictureContainer('assets/camera_icon.png', _backgroundImageUrlCtr),
//                         ),
//                         const SizedBox(height: 16),
//                         CustomTextField(
//                           controller: _backgroundImageUrlCtr,
//                           labelText: 'Background Image URL',
//                           prefixIcon: Icons.link,
//                           validator: (value) {
//                             if (value != null && value.isNotEmpty && !Uri.parse(value).isAbsolute) {
//                               return 'Please enter a valid URL';
//                             }
//                             return null; // No error if empty
//                           },
//                         ),
//                         const SizedBox(height: 70),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             ElevatedButton(
//                               onPressed: userProviderState.loading
//                                   ? null
//                                   : () async {
//                                 if (_formKey.currentState!.validate()) {
//                                   final userProviderNotifier = ref.read(userProvider.notifier);
//                                   userProviderNotifier.firstNameCtr.text = _firstNameCtr.text;
//                                   userProviderNotifier.lastNameCtr.text = _lastNameCtr.text;
//                                   userProviderNotifier.emailCtr.text = _emailCtr.text;
//                                   userProviderNotifier.profileImageUrlCtr.text = _profileImageUrlCtr.text;
//                                   userProviderNotifier.backgroundImageUrlCtr.text = _backgroundImageUrlCtr.text;
//                                   await userProviderNotifier.updateUserProfile();
//                                   if (userProviderState.error == null) {
//                                     Navigator.pop(context);
//                                   } else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(
//                                         content: Text('Error: ${userProviderState.error}'),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//                                   }
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                               ),
//                               child: userProviderState.loading
//                                   ? SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(color: Colors.white),
//                               )
//                                   : Text(
//                                 'Save',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.pushReplacementNamed(context, '/');
//                               },
//                               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                               child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, String hint, TextEditingController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: hint,
//             filled: true,
//             fillColor: Color(0xFFE7E7E7),
//           ),
//           validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPictureContainer(String imagePath, TextEditingController controller) {
//     return Container(
//       width: 140,
//       height: 140,
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: SizedBox(
//           width: 60,
//           height: 60,
//           child: Image.asset(imagePath),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/domain/model/userItem.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/user_view_model_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtr = TextEditingController();
  final _lastNameCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _profileImageUrlCtr = TextEditingController();
  final _backgroundImageUrlCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial setup with current user data
    final userProviderState = ref.read(userProvider);
    _updateControllers(userProviderState.user);
    // Fetch user profile if null, updating controllers after fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userProviderState.user == null) {
        ref.read(userProvider.notifier).fetchUserProfile().then((_) {
          final updatedUserProviderState = ref.read(userProvider);
          _updateControllers(updatedUserProviderState.user);
        });
      }
    });
  }

  void _updateControllers(UserItem? user) {
    if (user != null) {
      setState(() {
        _firstNameCtr.text = user.firstName ?? '';
        _lastNameCtr.text = user.lastName ?? '';
        _emailCtr.text = user.email ?? '';
        _profileImageUrlCtr.text = user.profileImageUrl ?? '';
        _backgroundImageUrlCtr.text = user.backgroundImageUrl ?? '';
      });
    }
  }

  @override
  void dispose() {
    _firstNameCtr.dispose();
    _lastNameCtr.dispose();
    _emailCtr.dispose();
    _profileImageUrlCtr.dispose();
    _backgroundImageUrlCtr.dispose();
    super.dispose();
  }

  Future<void> _openGoogleDrive() async {
    const driveUrl = 'https://drive.google.com/drive/my-drive';
    if (await canLaunchUrl(Uri.parse(driveUrl))) {
      await launchUrl(Uri.parse(driveUrl), mode: LaunchMode.externalApplication);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please copy and paste your shared photo link below.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProviderState = ref.watch(userProvider);
    final user = userProviderState.user;

    // Listen for changes in userProvider and update controllers
    ref.listen(userProvider, (previous, next) {
      if (previous?.user != next.user) {
        _updateControllers(next.user);
      }
    });

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 64.0),
        child: Column(
          children: [
            Container(
              height: 250.0,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200.0,
                        color: Color(0xFF8E8E8B),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 150.0,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_picture.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 4,
                color: Color(0xFFF9F9F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(22.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        Center(
                          child: Text(
                            user?.firstName != null && user?.lastName != null
                                ? '${user!.firstName} ${user.lastName}'
                                : 'Full Name',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Text(
                            user?.email ?? 'name@gmail.com',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 18),
                        CustomTextField(
                          controller: _firstNameCtr,
                          labelText: 'First Name',
                          prefixIcon: Icons.person,
                          validator: (value) => value == null || value.isEmpty ? 'Please enter First Name' : null,
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _lastNameCtr,
                          labelText: 'Last Name',
                          prefixIcon: Icons.person_outline,
                          validator: (value) => value == null || value.isEmpty ? 'Please enter Last Name' : null,
                        ),
                        const SizedBox(height: 4),
                        CustomTextField(
                          controller: _emailCtr,
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          validator: (value) => value == null || value.isEmpty ? 'Please enter Email' : null,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Profile Picture',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _openGoogleDrive,
                          child: _buildPictureContainer('assets/camera_icon.png', _profileImageUrlCtr),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _profileImageUrlCtr,
                          labelText: 'Profile Image URL',
                          prefixIcon: Icons.link,
                          validator: (value) {
                            if (value != null && value.isNotEmpty && !Uri.parse(value).isAbsolute) {
                              return 'Please enter a valid URL';
                            }
                            return null; // No error if empty
                          },
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Background Picture',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: _openGoogleDrive,
                          child: _buildPictureContainer('assets/camera_icon.png', _backgroundImageUrlCtr),
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _backgroundImageUrlCtr,
                          labelText: 'Background Image URL',
                          prefixIcon: Icons.link,
                          validator: (value) {
                            if (value != null && value.isNotEmpty && !Uri.parse(value).isAbsolute) {
                              return 'Please enter a valid URL';
                            }
                            return null; // No error if empty
                          },
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: userProviderState.loading
                                  ? null
                                  : () async {
                                if (_formKey.currentState!.validate()) {
                                  final userProviderNotifier = ref.read(userProvider.notifier);
                                  userProviderNotifier.firstNameCtr.text = _firstNameCtr.text;
                                  userProviderNotifier.lastNameCtr.text = _lastNameCtr.text;
                                  userProviderNotifier.emailCtr.text = _emailCtr.text;
                                  userProviderNotifier.profileImageUrlCtr.text = _profileImageUrlCtr.text;
                                  userProviderNotifier.backgroundImageUrlCtr.text = _backgroundImageUrlCtr.text;
                                  await userProviderNotifier.updateUserProfile();
                                  if (userProviderState.error == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'Profile updated successfully!',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.black,
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.only(bottom: 20.0, left: 16.0, right: 16.0),
                                        elevation: 6.0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Error: ${userProviderState.error}'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: userProviderState.loading
                                  ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(color: Colors.white),
                              )
                                  : Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/profile');
                              },
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: Text('Cancel', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPictureContainer(String imagePath, TextEditingController controller) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}