import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/app/app.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await HiveService().init();
  runApp(const ProviderScope(child: App()));
}