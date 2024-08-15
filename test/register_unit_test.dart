import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'login_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
])
void main() {
  late MockAuthUseCase authUseCase;

  setUp(() {
    authUseCase = MockAuthUseCase();
  });

  group('AuthUseCase - register', () {
    const String firstName = 'Test';
    const String lastName = 'User';
    const String email = 'test@example.com';
    const String password = 'password123';
    const String confirmPassword = 'password123';
    final File? image = null;

    test('should return true when registration is successful', () async {
      // Arrange
      when(authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      )).thenAnswer((_) async => const Right(true));

      // Act
      final result = await authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      );

      // Assert
      expect(result, const Right(true));
      verify(authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      )).called(1);
    });

    test('should return Failure when registration fails', () async {
      // Arrange
      final failure = Failure(error: 'Registration failed');
      when(authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      );

      // Assert
      expect(result, Left(failure));
      verify(authUseCase.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        image: image,
      )).called(1);
    });
  });
}
