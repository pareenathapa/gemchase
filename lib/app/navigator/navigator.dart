import 'package:flutter/material.dart';
import 'package:gemchase_clean_arch/app/navigator_key/navigator_key.dart';

class NavigateRoute {
  NavigateRoute._();

  // Open another Screen
  static void pushRoute(Widget view) {
    Navigator.push(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // Close the current Screen and Open another Screen
  static void popAndPushRoute(Widget view) {
    Navigator.pushReplacement(
      AppNavigator.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => view),
    );
  }

  // Just Go Back
  static void pop() {
    Navigator.pop(
      AppNavigator.navigatorKey.currentState!.context,
    );
  }
}
