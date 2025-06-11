import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/basicInterviewItemCard.dart';
import 'package:junior_flutter/features/crud/presentation/components/specialInterviewItemCard.dart';
import 'package:junior_flutter/features/crud/presentation/components/wishListItemCard.dart';
import 'package:junior_flutter/features/crud/presentation/components/invitationItemCard.dart';
import '../view_model/user_view_model_provider.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/basic_interview_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/special_interview_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/wish_list_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/invitation_view_model.dart';

final userProvider = ChangeNotifierProvider<UserProvider>((ref) => UserProvider(ref));

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // Track hidden items by ID for each entity type
  final Set<int> _hiddenBasicInterviewIds = {};
  final Set<int> _hiddenSpecialInterviewIds = {};
  final Set<int> _hiddenWishListIds = {};
  final Set<int> _hiddenInvitationIds = {};

  @override
  void initState() {
    super.initState();
    // Fetch user profile when the screen is first loaded, deferred to post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProvider).user;
      if (user == null) {
        ref.read(userProvider.notifier).fetchUserProfile();
      }
    });
  }

  void _handleDelete({
    required int id,
    required String itemType,
    required Future<void> Function(int) deleteMethod,
  }) {
    setState(() {
      // Hide the item by adding its ID to the appropriate set
      switch (itemType) {
        case 'basic':
          _hiddenBasicInterviewIds.add(id);
          break;
        case 'special':
          _hiddenSpecialInterviewIds.add(id);
          break;
        case 'wishlist':
          _hiddenWishListIds.add(id);
          break;
        case 'invitation':
          _hiddenInvitationIds.add(id);
          break;
      }
    });

    // Show styled SnackBar with Undo action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item deleted'),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              // Unhide the item by removing its ID
              switch (itemType) {
                case 'basic':
                  _hiddenBasicInterviewIds.remove(id);
                  break;
                case 'special':
                  _hiddenSpecialInterviewIds.remove(id);
                  break;
                case 'wishlist':
                  _hiddenWishListIds.remove(id);
                  break;
                case 'invitation':
                  _hiddenInvitationIds.remove(id);
                  break;
              }
            });
            // Refresh user to ensure consistency
            ref.read(userProvider.notifier).fetchUserProfile();
          },
        ),
      ),
    ).closed.then((reason) {
      // If SnackBar closes without Undo, perform permanent deletion
      if (reason != SnackBarClosedReason.action) {
        deleteMethod(id).then((_) {
          print('Permanently deleted $itemType id: $id');
          // Refresh user after deletion
          ref.read(userProvider.notifier).fetchUserProfile();
        }).catchError((e) {
          print('Error during permanent deletion of $itemType: $e');
          // Unhide item on error and refresh user
          setState(() {
            switch (itemType) {
              case 'basic':
                _hiddenBasicInterviewIds.remove(id);
                break;
              case 'special':
                _hiddenSpecialInterviewIds.remove(id);
                break;
              case 'wishlist':
                _hiddenWishListIds.remove(id);
                break;
              case 'invitation':
                _hiddenInvitationIds.remove(id);
                break;
            }
          });
          ref.read(userProvider.notifier).fetchUserProfile();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete item: $e'),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16.0),
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProviderState = ref.watch(userProvider);
    final user = userProviderState.user;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background header (scrolls with content)
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: const Color(0xFF8E8E8B), // Default solid color
                image: user != null && user.backgroundImageUrl != null && user.backgroundImageUrl!.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(user.backgroundImageUrl!),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => null, // Fallback to color on error
                )
                    : null,
              ),
            ),
            // Content with white background
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -50), // Move CircleAvatar up to overlap header
                    child: Center(
                      child: CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/profile_picture.jpg'),
                            image: user != null && user.profileImageUrl != null && user.profileImageUrl!.isNotEmpty
                                ? NetworkImage(user.profileImageUrl!)
                                : const AssetImage('assets/profile_picture.jpg') as ImageProvider,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/profile_picture.jpg', fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Reduced to account for overlap
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          user != null ? '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim() : 'Full Name',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          user?.email ?? 'name@gmail.com',
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/edit-profile').then((_) {
                                // Refresh user profile after returning from edit screen
                                ref.read(userProvider.notifier).fetchUserProfile();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFEDEDEB),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'My Application',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        // Basic Interview Card
                        if (user?.basicInterviews != null &&
                            user!.basicInterviews!.any((item) => !_hiddenBasicInterviewIds.contains(item.id!)))
                          BasicInterviewItemCard(
                            basicInterview: user.basicInterviews!.firstWhere(
                                  (item) => !_hiddenBasicInterviewIds.contains(item.id!),
                              orElse: () => user.basicInterviews!.first,
                            ),
                            onDeleteClick: () => _handleDelete(
                              id: user.basicInterviews!.firstWhere(
                                    (item) => !_hiddenBasicInterviewIds.contains(item.id!),
                                orElse: () => user.basicInterviews!.first,
                              ).id!,
                              itemType: 'basic',
                              deleteMethod: ref.read(basicInterviewProvider.notifier).deleteBasicInterview,
                            ),
                            onEditClick: () {
                              Navigator.pushNamed(
                                context,
                                '/basic-interview',
                                arguments: {
                                  'id': user.basicInterviews!.firstWhere(
                                        (item) => !_hiddenBasicInterviewIds.contains(item.id!),
                                    orElse: () => user.basicInterviews!.first,
                                  ).id,
                                },
                              ).then((_) {
                                // Refresh user profile after returning from edit screen
                                ref.read(userProvider.notifier).fetchUserProfile();
                              });
                            },
                          ),
                        const SizedBox(height: 15),
                        // Special Interview Card
                        if (user?.specialInterviews != null &&
                            user!.specialInterviews!.any((item) => !_hiddenSpecialInterviewIds.contains(item.id!)))
                          SpecialInterviewItemCard(
                            specialInterview: user.specialInterviews!.firstWhere(
                                  (item) => !_hiddenSpecialInterviewIds.contains(item.id!),
                              orElse: () => user.specialInterviews!.first,
                            ),
                            onDeleteClick: () => _handleDelete(
                              id: user.specialInterviews!.firstWhere(
                                    (item) => !_hiddenSpecialInterviewIds.contains(item.id!),
                                orElse: () => user.specialInterviews!.first,
                              ).id!,
                              itemType: 'special',
                              deleteMethod: ref.read(specialInterviewProvider.notifier).deleteSpecialInterview,
                            ),
                            onEditClick: () {
                              Navigator.pushNamed(
                                context,
                                '/special-interview',
                                arguments: {
                                  'id': user.specialInterviews!.firstWhere(
                                        (item) => !_hiddenSpecialInterviewIds.contains(item.id!),
                                    orElse: () => user.specialInterviews!.first,
                                  ).id,
                                },
                              ).then((_) {
                                // Refresh user profile after returning from edit screen
                                ref.read(userProvider.notifier).fetchUserProfile();
                              });
                            },
                          ),
                        const SizedBox(height: 15),
                        // Wishlist Card
                        if (user?.wishLists != null &&
                            user!.wishLists!.any((item) => !_hiddenWishListIds.contains(item.id!)))
                          WishlistItemCard(
                            wishlistItem: user.wishLists!.firstWhere(
                                  (item) => !_hiddenWishListIds.contains(item.id!),
                              orElse: () => user.wishLists!.first,
                            ),
                            onDeleteClick: () => _handleDelete(
                              id: user.wishLists!.firstWhere(
                                    (item) => !_hiddenWishListIds.contains(item.id!),
                                orElse: () => user.wishLists!.first,
                              ).id!,
                              itemType: 'wishlist',
                              deleteMethod: ref.read(wishListProvider.notifier).deleteWishList,
                            ),
                            onEditClick: () {
                              Navigator.pushNamed(
                                context,
                                '/wishList',
                                arguments: {
                                  'id': user.wishLists!.firstWhere(
                                        (item) => !_hiddenWishListIds.contains(item.id!),
                                    orElse: () => user.wishLists!.first,
                                  ).id,
                                },
                              ).then((_) {
                                // Refresh user profile after returning from edit screen
                                ref.read(userProvider.notifier).fetchUserProfile();
                              });
                            },
                          ),
                        const SizedBox(height: 15),
                        // Invitation Card
                        if (user?.invitations != null &&
                            user!.invitations!.any((item) => !_hiddenInvitationIds.contains(item.id!)))
                          InvitationItemCard(
                            invitation: user.invitations!.firstWhere(
                                  (item) => !_hiddenInvitationIds.contains(item.id!),
                              orElse: () => user.invitations!.first,
                            ),
                            onDeleteClick: () => _handleDelete(
                              id: user.invitations!.firstWhere(
                                    (item) => !_hiddenInvitationIds.contains(item.id!),
                                orElse: () => user.invitations!.first,
                              ).id!,
                              itemType: 'invitation',
                              deleteMethod: ref.read(invitationProvider.notifier).deleteInvitation,
                            ),
                            onEditClick: () {
                              Navigator.pushNamed(
                                context,
                                '/invitation',
                                arguments: {
                                  'id': user.invitations!.firstWhere(
                                        (item) => !_hiddenInvitationIds.contains(item.id!),
                                    orElse: () => user.invitations!.first,
                                  ).id,
                                },
                              ).then((_) {
                                // Refresh user profile after returning from edit screen
                                ref.read(userProvider.notifier).fetchUserProfile();
                              });
                            },
                          ),
                        const SizedBox(height: 20), // Extra padding at the bottom
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}