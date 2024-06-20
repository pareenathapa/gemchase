import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/presentation/navigator/login_navigator.dart';


// Provider
final splashViewNavigatorProvider = Provider((ref) => SplashViewNavigator());

// Route (navigating to login view)
class SplashViewNavigator with LoginViewRoute {}

// Mixin
mixin SplashViewRoute {}
