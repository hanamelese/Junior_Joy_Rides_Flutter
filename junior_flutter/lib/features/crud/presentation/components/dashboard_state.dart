import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the state class to hold both selectedScreen and selectedTimeframe
class DashboardStateData {
  final String selectedScreen;
  final String selectedTimeframe;

  DashboardStateData({
    required this.selectedScreen,
    required this.selectedTimeframe,
  });

  DashboardStateData copyWith({String? selectedScreen, String? selectedTimeframe}) {
    return DashboardStateData(
      selectedScreen: selectedScreen ?? this.selectedScreen,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
    );
  }
}

// StateNotifier to manage dashboard state
class DashboardState extends StateNotifier<DashboardStateData> {
  DashboardState()
      : super(DashboardStateData(
    selectedScreen: "Interview Management",
    selectedTimeframe: "Month",
  ));

  void setSelectedScreen(String screen) {
    state = state.copyWith(selectedScreen: screen);
  }

  void setSelectedTimeframe(String timeframe) {
    state = state.copyWith(selectedTimeframe: timeframe);
  }
}

// Riverpod provider for DashboardState
final dashboardStateProvider = StateNotifierProvider<DashboardState, DashboardStateData>(
      (ref) => DashboardState(),
);