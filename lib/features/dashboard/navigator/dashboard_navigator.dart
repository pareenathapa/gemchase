import 'package:gemchase_clean_arch/app/navigator/navigator.dart';
import 'package:gemchase_clean_arch/features/dashboard/presentation/view/dashboard_base_view.dart';

class DashboardViewNavigator {}

mixin DashboardViewRoute {
  openDashboardView() {
    NavigateRoute.pushRoute(const DashboardBaseView());
  }
}