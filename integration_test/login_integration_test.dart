import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import '../test/login_unit_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

    when(
      mockAuthUseCase.login(
        email: 'test@example.com',
        password: '@ppleWas01',
      ),
    ).thenAnswer(
      (_) async => Right(mockUserEntity),
    );
    when(
      mockAuthUseCase.login(
        email: 'test@test.com',
        password: '@ppleWas01',
      ),
    ).thenAnswer(
      (_) async => Left(
        Failure(
          error: 'Invalid email or password',
        ),
      ),
    );
  });

  testWidgets('test login with proper credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase),
          ),
        ],
        child: MaterialApp(
          title: "GemChase",
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter correct email and password
    await tester.enterText(
      find
          .byType(
            TextFormField,
          )
          .at(0),
      'test@example.com',
    );

    await tester.enterText(
      find
          .byType(
            TextFormField,
          )
          .at(1),
      '@ppleWas01',
    );

    // Hide the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
    // Tap the LOGIN button
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check for the success message in the SnackBar
    expect(find.text('Login Success'), findsOneWidget);
  });

  testWidgets('test login with wrong credentials', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase),
          ),
        ],
        child: MaterialApp(
          title: "GemChase",
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const LoginView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter correct email and password
    await tester.enterText(
      find
          .byType(
            TextFormField,
          )
          .at(0),
      'test@test.com',
    );

    await tester.enterText(
      find
          .byType(
            TextFormField,
          )
          .at(1),
      '@ppleWas01',
    );

    // Hide the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
    // Tap the LOGIN button
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check for the success message in the SnackBar
    expect(find.text('Invalid email or password'), findsOneWidget);
  });
}
