import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/navigator/navigator.dart';
import 'package:gemchase_clean_arch/features/dashboard/navigator/dashboard_navigator.dart';
import '../view/login_view.dart';
import 'register_navigator.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());


class LoginViewNavigator with RegisterViewRoute,DashboardViewRoute {}



mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}
