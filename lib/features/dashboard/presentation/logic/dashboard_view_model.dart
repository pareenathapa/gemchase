import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/logic/dashboard_state.dart';

class DashBoardViewModel extends StateNotifier<DashboardState> {
  DashBoardViewModel({
    required this.ref,
  }) : super(const DashboardState());
  StateNotifierProviderRef ref;

  void onTabSelected(int index) {
    state = state.copyWith(
      index: index,
    );
  }
}