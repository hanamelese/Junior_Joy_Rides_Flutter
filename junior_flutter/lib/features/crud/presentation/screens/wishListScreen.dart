import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/customTextField.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/wish_list_view_model.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      final int? id = args != null && args is Map<String, dynamic> ? args['id'] as int? : null;
      if (id != null) {
        ref.read(wishListProvider.notifier).fetchWishListById(id).then((_) {
          if (!mounted) return;
          final state = ref.read(wishListProvider);
          print('Fetched wishlist data: childName=${state.childNameCtr.text}, imageUrl=${state.imageUrlCtr.text}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishListState = ref.watch(wishListProvider);

    ref.listen<WishListProvider>(wishListProvider, (previous, next) {
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
      body: SafeArea(
        child: wishListState.loading && wishListState.currentWishList == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 64.0),
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
                          'Invite Etopis',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
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
                          'Wishlist',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC5AE3D),
                          ),
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
                      const Text(
                        "Join The Birthday Wishlist",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "Select a photo from Google Drive to feature your child on our TV show this week!",
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
                            icon: const Icon(Icons.photo_camera, size: 40, color: Colors.black),
                            onPressed: () async {
                              await _openGoogleDrive();
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please copy and paste your shared photo link below.'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: wishListState.imageUrlCtr,
                        labelText: 'Google Drive Photo Link',
                        prefixIcon: Icons.link,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Google Drive link';
                          }
                          if (!Uri.parse(value).isAbsolute) {
                            return 'Please enter a valid URL';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: wishListState.childNameCtr,
                        labelText: 'Child\'s Name',
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the child\'s name';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        controller: wishListState.ageCtr,
                        labelText: 'Age',
                        prefixIcon: Icons.cake,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the child\'s age';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Please enter a valid age';
                          }
                          return null;
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null && mounted) {
                            wishListState.dateCtr.text = pickedDate.toIso8601String().split('T')[0];
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextField(
                            controller: wishListState.dateCtr,
                            labelText: 'Date Of Celebration',
                            prefixIcon: Icons.calendar_today,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                            enabled: false,
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: wishListState.specialRequestsCtr,
                        labelText: 'Special Requests',
                        prefixIcon: Icons.note,
                      ),
                      CustomTextField(
                        controller: wishListState.guardianEmailCtr,
                        labelText: 'Guardian\'s Email',
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
                      const SizedBox(height: 70),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: wishListState.loading
                              ? null
                              : () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                await ref.read(wishListProvider.notifier).saveWishList();
                                if (!mounted) return;
                                final state = ref.read(wishListProvider);
                                if (state.error == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Wishlist ${ModalRoute.of(context)!.settings.arguments is Map<String, dynamic> && (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['id'] != null ? 'updated' : 'added'} successfully',
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
                                  ref.read(wishListProvider.notifier).clear();
                                  if (ModalRoute.of(context)!.settings.arguments is Map<String, dynamic> &&
                                      (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)['id'] != null) {
                                    Navigator.pop(context);
                                  }
                                }
                              } catch (e) {
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
                                        borderRadius: BorderRadius.circular(12),
                                      ),
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
                          child: wishListState.loading
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
                            'Submit Request',
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
        ),
      ),
    )
    ;
  }

  Future<void> _openGoogleDrive() async {
    const driveUrl = 'https://drive.google.com/drive/my-drive';
    if (await canLaunchUrl(Uri.parse(driveUrl))) {
      await launchUrl(Uri.parse(driveUrl), mode: LaunchMode.externalApplication);
    }
  }
}