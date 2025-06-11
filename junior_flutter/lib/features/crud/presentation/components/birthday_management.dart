import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/invitation_view_model.dart';
import 'package:junior_flutter/features/crud/presentation/view_model/wish_list_view_model.dart';

class BirthdayManagementScreen extends ConsumerStatefulWidget {
  const BirthdayManagementScreen({super.key});

  @override
  ConsumerState<BirthdayManagementScreen> createState() => _BirthdayManagementScreenState();
}

class _BirthdayManagementScreenState extends ConsumerState<BirthdayManagementScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data once when the widget is initialized
    Future.microtask(() {
      ref.read(invitationProvider.notifier).fetchAllInvitations();
      ref.read(wishListProvider.notifier).fetchAllWishLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the invitation and wishlist providers
    final invitationState = ref.watch(invitationProvider);
    final wishListState = ref.watch(wishListProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          // New Birthday Invitation
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEW BIRTHDAY INVITATION",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (invitationState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (invitationState.error != null)
                    Text(
                      'Error: ${invitationState.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else if (invitationState.invitations.isEmpty)
                      const Text('No new invitations')
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: invitationState.invitations.length,
                        itemBuilder: (context, index) {
                          final invitation = invitationState.invitations[index];
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("${invitation.childName}'s Birthday"),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "${invitation.childName} booked a birthday celebration on ${invitation.date}",
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
                              if (index < invitationState.invitations.length - 1)
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
          // Next Week Wishlist
          Card(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NEXT WEEK WISHLIST",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (wishListState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (wishListState.error != null)
                    Text(
                      'Error: ${wishListState.error}',
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  else if (wishListState.wishLists.isEmpty)
                      const Text('No wishlists for next week')
                    else
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Monday 🎉"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: wishListState.wishLists
                                    .asMap()
                                    .entries
                                    .map((entry) => _buildPersonColumn(
                                  entry.value.childName ?? 'Unknown',
                                  entry.value.imageUrl ?? '',
                                ))
                                    .toList(),
                              ),
                            ],
                          ),
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

  Widget _buildPersonColumn(String name, String imagePath) {
    // Check if the imagePath is a valid network URL (starts with http:// or https://)
    final isNetworkImage = imagePath.startsWith('http://') || imagePath.startsWith('https://');
    final isValidImage = isNetworkImage && !imagePath.contains('drive.google.com');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isValidImage
            ? Image.network(
          imagePath,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.person,
            size: 50,
          ),
        )
            : const Icon(
          Icons.person,
          size: 50,
        ),
        Text(name),
      ],
    );
  }
}