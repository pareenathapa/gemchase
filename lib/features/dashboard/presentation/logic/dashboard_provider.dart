import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/logic/dashboard_state.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/logic/dashboard_view_model.dart';

final dashBoardViewModelProvider =
    StateNotifierProvider<DashBoardViewModel, DashboardState>((ref) {
  return DashBoardViewModel(
    ref: ref,
  );
});