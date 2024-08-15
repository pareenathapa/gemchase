import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KhaltiScope(
        enabledDebugging: true,
        publicKey: "test_public_key_bcbec49746364b548f9cf8ab6f0e097d",
        builder: (context, khaltiNavigation) {
          AppNavigator.navigatorKey = khaltiNavigation;
          return ScreenUtilInit(
            designSize: const Size(390, 844),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, snapshot) {
              return MaterialApp(
                navigatorKey: AppNavigator.navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.getApplicationTheme(false),
                home: const SplashView(),
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ne', 'NP'),
                ],
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
              );
            },
          );
        });
  }
}
