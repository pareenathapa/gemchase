import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/entity/auth_entity.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/navigator/login_navigator.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/view_model/auth_view_model.dart';
import 'package:mockito/annotations.dart';
 import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';




// flutter pub run test
// test_cov_console
// flutter test --coverage
// flutter test .\test\unit_test\ --coverage
// Final Command: flutter pub run test_cov_console

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(
    () {
      mockAuthUsecase = MockAuthUseCase();
      mockLoginViewNavigator = MockLoginViewNavigator();
      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUsecase),
          )
        ],
      );
    },
  );

  test('check for the inital state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);
  });

  group('Login Test', () {
    test('login test with invalid email and password', () async {
      // Arrange
      when(mockAuthUsecase.login('test@gmail.com', 'tester'))
          .thenAnswer((_) => Future.value(const Right(true)));

      when(mockAuthUsecase.login('test@gmail.com', '123456'))
          .thenAnswer((_) => Future.value(
                Left(
                  Failure(error: 'Invalid Credentails'),
                ),
              ));

      // Act
      await container
          .read(authViewModelProvider.notifier)
          .login('test@gmail.com', 'tester');

      final authState = container.read(authViewModelProvider);

      // Assert
      expect(authState.error, isNull);
    });

    test('login test with valid email and password', () async {
      // Arrange
      const email = 'test@gmail.com';
      const password = 'tester';

      when(mockAuthUsecase.login(email, password)).thenAnswer((invocation) {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(email == email && password == password
            ? const Right(true)
            : Left(Failure(error: 'Invalid')));
      });

      // Act
      await container
          .read(authViewModelProvider.notifier)
          .login('test@gmail.com', 'tester');

      final authState = container.read(authViewModelProvider);

      // Assert
      expect(authState.error, isNull);
    });
  });

  test('Register User', () async {
    // Arrange
    const firstName = 'Parina';
    const lastName='Thapa';
    const phone = '+9889515012';
    const email = 'parina@gmail.com';
    const password = 'password';

    const user = AuthEntity(
        firstName: firstName,lastName: lastName, phone: phone, email: email, password: password);

    when(mockAuthUsecase.register(user))
        .thenAnswer((_) => Future.value(const Right(true)));

    // Act
    await container.read(authViewModelProvider.notifier).register(user);

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
  });

  tearDown(
    () {
      container.dispose();
    },
  );
}