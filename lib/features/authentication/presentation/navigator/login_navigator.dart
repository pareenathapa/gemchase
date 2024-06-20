import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/navigator/navigator.dart';
import '../view/login_view.dart';
import 'register_navigator.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());


class LoginViewNavigator with RegisterViewRoute {}



mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}
