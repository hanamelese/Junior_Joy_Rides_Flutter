import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/dashboard_state.dart';

class SharedDashboardComponents extends ConsumerWidget {
  final Function(String) onTimeRangeSelected;

  const SharedDashboardComponents({super.key, required this.onTimeRangeSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardStateProvider);

    return Column(
      children: [
        // "Admin Dashboard" text
        Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            "Admin Dashboard",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Time range selector
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Week", "Month", "Year"].map((timeframe) {
              return GestureDetector(
                onTap: () {
                  ref.read(dashboardStateProvider.notifier).setSelectedTimeframe(timeframe);
                  onTimeRangeSelected(timeframe);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: dashboardState.selectedTimeframe == timeframe
                        ? const Color(0xFFC5AE3D)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    timeframe,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dashboardState.selectedTimeframe == timeframe
                          ? Colors.black
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}