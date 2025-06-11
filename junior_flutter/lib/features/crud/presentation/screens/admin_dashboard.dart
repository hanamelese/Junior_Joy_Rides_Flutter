import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junior_flutter/features/crud/presentation/components/shared_dashboard_components.dart';
import 'package:junior_flutter/features/crud/presentation/components/dashboard_state.dart';
import 'package:junior_flutter/features/crud/presentation/components/stat_card.dart';
import 'package:junior_flutter/features/crud/presentation/components/birthday_management.dart';
import 'package:junior_flutter/features/crud/presentation/components/interview_management.dart';
import 'package:junior_flutter/features/crud/presentation/components/management_section.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardStateProvider);

    return Scaffold(
      body: Column(
        children: [
          // Shared components
          SharedDashboardComponents(
            onTimeRangeSelected: (range) {
              ref.read(dashboardStateProvider.notifier).setSelectedTimeframe(range);
            },
          ),
          // Navigation section
          ManagementSection(
            onSectionSelected: (section) {
              ref.read(dashboardStateProvider.notifier).setSelectedScreen(section);
            },
          ),
          Expanded(
            child: ListView(
              children: [
                const StatisticCards(),
                const SizedBox(height: 16),
                // Weekly Activities Report
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'WEEKLY ACTIVITY REPORT',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  color: Colors.grey[200],
                  child: const Center(child: Text('Chart Placeholder')),
                ),
                const SizedBox(height: 16),
                // NavHost content
                dashboardState.selectedScreen == "Interview Management"
                    ? const InterviewManagementScreen()
                    : const BirthdayManagementScreen(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}