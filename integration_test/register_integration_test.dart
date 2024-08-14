import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import '../test/register_unit_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthUseCase mockAuthUseCase;

  setUpAll(() async {
    mockAuthUseCase = MockAuthUseCase();

    when(
      mockAuthUseCase.register(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'newuser@example.com',
        password: 'SecurePassword01',
        confirmPassword: 'SecurePassword01',
        image: anyNamed('image'),
      ),
    ).thenAnswer(
      (_) async => Right(true),
    );
    when(
      mockAuthUseCase.register(
        firstName: 'Jane',
        lastName: 'Doe',
        email: 'newuser@example.com',
        password: 'password123',
        confirmPassword: 'password123',
        image: anyNamed('image'),
      ),
    ).thenAnswer(
      (_) async => Left(
        Failure(
          error: 'Registration failed',
        ),
      ),
    );
  });

  testWidgets('test registration with proper credentials',
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
          home: const RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter correct registration details
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Jane',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Doe',
    );

    await tester.enterText(
      find.byType(TextFormField).at(2),
      'newuser@example.com',
    );

    await tester.enterText(
      find.byType(TextFormField).at(3),
      'SecurePassword01',
    );

    await tester.enterText(
      find.byType(TextFormField).at(4),
      'SecurePassword01',
    );

// Hide the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
    // Tap the REGISTER button
    await tester.tap(find.widgetWithText(ElevatedButton, 'REGISTER'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check for the success message in the SnackBar
    expect(find.text('Registration successful'), findsOneWidget);
  });

  testWidgets('test registration with incorrect details',
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
          home: const RegisterView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Enter incorrect registration details
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Jane',
    );

    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Doe',
    );

    await tester.enterText(
      find.byType(TextFormField).at(2),
      'newuser@example.com',
    );

    await tester.enterText(
      find.byType(TextFormField).at(3),
      'password123',
    );

    await tester.enterText(
      find.byType(TextFormField).at(4),
      'password123',
    );
// Hide the keyboard
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
    // Tap the REGISTER button
    await tester.tap(find.widgetWithText(ElevatedButton, 'REGISTER'));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Check for the error message in the SnackBar
    expect(find.text('Registration failed'), findsOneWidget);
  });
}
