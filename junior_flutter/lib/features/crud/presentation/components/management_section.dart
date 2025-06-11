import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/dashboard_state.dart';

final timePeriodProvider = StateProvider<String>((ref) => 'Week');

class ManagementSection extends ConsumerWidget {
  final Function(String) onSectionSelected;

  const ManagementSection({super.key, required this.onSectionSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardStateProvider);
    final selectedTimePeriod = ref.watch(timePeriodProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            'Admin',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['Week', 'Month', 'Year']
                .map((label) => _buildToggleButton(label, selectedTimePeriod, ref))
                .toList(),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ManagementItem(
              title: "Birthday Management",
              isSelected: dashboardState.selectedScreen == "Birthday Management",
              onSectionSelected: onSectionSelected,
            ),
            ManagementItem(
              title: "Interview Management",
              isSelected: dashboardState.selectedScreen == "Interview Management",
              onSectionSelected: onSectionSelected,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String title, String selected, WidgetRef ref) {
    final isSelected = title == selected;
    return GestureDetector(
      onTap: () => ref.read(timePeriodProvider.notifier).state = title,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF4C430) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.black54,
          ),
        ),
      ),
    );
  }
}

class ManagementItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function(String) onSectionSelected;

  const ManagementItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final highlightColor = const Color(0xFFF4C430);
    final textColor = isSelected ? const Color(0xFF615517) : Colors.black87;

    return GestureDetector(
      onTap: () => onSectionSelected(title),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: isSelected ? highlightColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          )
        ],
      ),
    );
  }
}
