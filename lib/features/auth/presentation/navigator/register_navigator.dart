
import 'package:student_management_starter/core/navigator/navigator.dart';
import 'package:student_management_starter/features/auth/presentation/view/register_view.dart';

class RegisterViewNavigator{}

mixin RegisterViewRoute {
  openRegisterView() {
    NavigateRoute.pushRoute(const RegisterView());
  }
}

