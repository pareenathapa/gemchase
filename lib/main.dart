import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp (const ProviderScope(child: App()));
}