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

  group('AuthUseCase - login', () {
    const String email = 'test@example.com';
    const String password = 'password123';
    final LoginEntity loginEntity = LoginEntity(
      token: 'token',
      user: UserEntity(
        id: "1",
        firstName: 'John',
        lastName: 'Doe',
        email: 'test@example.com',
      ),
    );

    test('should return LoginEntity when login is successful', () async {
      // Arrange
      when(authUseCase.login(email: email, password: password))
          .thenAnswer((_) async => Right(loginEntity));

      // Act
      final result = await authUseCase.login(email: email, password: password);

      // Assert
      expect(result, Right(loginEntity));
      verify(authUseCase.login(email: email, password: password)).called(1);
    });

    test('should return Failure when login fails', () async {
      // Arrange
      final failure = Failure(error: 'Login failed');
      when(authUseCase.login(email: email, password: password))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await authUseCase.login(email: email, password: password);

      // Assert
      expect(result, Left(failure));
      verify(authUseCase.login(email: email, password: password)).called(1);
    });
  });
}
