import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:student_management_starter/core/navigator/navigator.dart';
import 'package:student_management_starter/features/auth/presentation/navigator/register_navigator.dart';
import 'package:student_management_starter/features/auth/presentation/view/login_view.dart';
import 'package:student_management_starter/features/home/presentation/navigator/home_navigator.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());
final homeViewNavigatorProvider = Provider((ref) => HomeViewNavigator());

class LoginViewNavigator with RegisterViewRoute {}

class HomeViewNavigator with HomeViewRoute {}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}
