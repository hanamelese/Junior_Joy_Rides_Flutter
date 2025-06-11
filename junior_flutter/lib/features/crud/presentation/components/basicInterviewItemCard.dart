import 'package:flutter/material.dart';
import 'package:junior_flutter/features/crud/domain/model/basicInterviewItem.dart';

class BasicInterviewItemCard extends StatelessWidget {
  final BasicInterviewItem basicInterview;
  final VoidCallback onDeleteClick;
  final VoidCallback onEditClick;

  const BasicInterviewItemCard({
    super.key,
    required this.basicInterview,
    required this.onDeleteClick,
    required this.onEditClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: const Color(0xFFF9F8F8),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.event_outlined,
                          size: 32.0,
                          color: Theme.of(context).colorScheme.onBackground,
                          semanticLabel: 'Event icon',
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Interview',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Chip(
                    label: Text(
                      basicInterview.upcoming == true ? 'PENDING' : 'SCHEDULED',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    backgroundColor: basicInterview.upcoming == true
                        ? const Color(0xFFE4851C)
                        : const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Child Name: ${basicInterview.childName ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Guardian Name: ${basicInterview.guardianName ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Age: ${basicInterview.age?.toString() ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              'Guardian Phone: ${basicInterview.guardianPhone?.toString().replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d{4})'), (Match m) => '${m[1]}-${m[2]}-${m[3]}') ?? 'N/A'}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: Theme.of(context).colorScheme.outline,
                thickness: 1.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: onEditClick,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 32.0,
                          color: Theme.of(context).colorScheme.onBackground,
                          semanticLabel: 'Edit icon',
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: onDeleteClick,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          size: 32.0,
                          color: Theme.of(context).colorScheme.error,
                          semanticLabel: 'Delete icon',
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

