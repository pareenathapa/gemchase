import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import '../test/login_unit_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('Initial Login test with token', () {
    late MockAuthUseCase mockAuthUseCase;
    late LoginEntity mockUserEntity;
    setUpAll(() async {
      mockAuthUseCase = MockAuthUseCase();
      mockUserEntity = const LoginEntity(
        token: "mockToken",
        user: UserEntity(
          email: 'test@example.com',
          id: '1234567890',
          firstName: 'John',
          lastName: 'Doe',
          phone: '1234567890',
          isAdmin: false,
        ),
      );
      await HiveService().init();
    });

    testWidgets('test initial login with token', (WidgetTester tester) async {
      when(mockAuthUseCase.getSavedUser()).thenAnswer(
        (_) async => Right(mockUserEntity),
      );
      when(mockAuthUseCase.checkFingerprintLogin()).thenAnswer(
        (_) async => Right(true),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(mockAuthUseCase),
            ),
          ],
          child: ScreenUtilInit(
              designSize: const Size(390, 844),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, snapshot) {
                return MaterialApp(
                  title: "GemChase",
                  navigatorKey: AppNavigator.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  home: const SplashView(),
                );
              }),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsAny);
    });
    testWidgets('test initial login without token',
        (WidgetTester tester) async {
      when(mockAuthUseCase.getSavedUser()).thenAnswer(
        (_) async => Left(
          Failure(
            error: 'No user found',
          ),
        ),
      );
      when(mockAuthUseCase.checkFingerprintLogin()).thenAnswer(
        (_) async => Right(true),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(mockAuthUseCase),
            ),
          ],
          child: ScreenUtilInit(
              designSize: const Size(390, 844),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, snapshot) {
                return MaterialApp(
                  title: "GemChase",
                  navigatorKey: AppNavigator.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  home: const SplashView(),
                );
              }),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No user found'), findsAny);
    });
  });
}
