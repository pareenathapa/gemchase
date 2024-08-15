import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static NavigatorState? get navigator => _navigatorKey.currentState;

  static set navigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey.currentState?.dispose();
    // This will override the existing key, which is not recommended.
    // If you want to replace the key, ensure you understand the implications.
    _navigatorKey = key;
  }
}
