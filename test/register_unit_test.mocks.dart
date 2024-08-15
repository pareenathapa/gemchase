// Mocks generated by Mockito 5.4.4 from annotations
// in gemchase_clean_arch/test/register_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:gemchase_clean_arch/core/common/exports.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AuthUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthUseCase extends _i1.Mock implements _i3.AuthUseCase {
  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> register({
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? password,
    required String? confirmPassword,
    required _i5.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #register,
          [],
          {
            #firstName: firstName,
            #lastName: lastName,
            #email: email,
            #password: password,
            #confirmPassword: confirmPassword,
            #image: image,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #register,
            [],
            {
              #firstName: firstName,
              #lastName: lastName,
              #email: email,
              #password: password,
              #confirmPassword: confirmPassword,
              #image: image,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #register,
            [],
            {
              #firstName: firstName,
              #lastName: lastName,
              #email: email,
              #password: password,
              #confirmPassword: confirmPassword,
              #image: image,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>> login({
    required String? email,
    required String? password,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [],
          {
            #email: email,
            #password: password,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
            _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
                _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #login,
            [],
            {
              #email: email,
              #password: password,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity?>> getSavedUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSavedUser,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity?>>.value(
                _FakeEither_0<_i3.Failure, _i3.LoginEntity?>(
          this,
          Invocation.method(
            #getSavedUser,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity?>>.value(
                _FakeEither_0<_i3.Failure, _i3.LoginEntity?>(
          this,
          Invocation.method(
            #getSavedUser,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity?>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #logout,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>> getUserById(
          {required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserById,
          [],
          {#userId: userId},
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
            _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #getUserById,
            [],
            {#userId: userId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
                _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #getUserById,
            [],
            {#userId: userId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> updateUser({
    required String? userId,
    required String? firstName,
    required String? lastName,
    required String? email,
    required _i5.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [],
          {
            #userId: userId,
            #firstName: firstName,
            #lastName: lastName,
            #email: email,
            #image: image,
          },
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #updateUser,
            [],
            {
              #userId: userId,
              #firstName: firstName,
              #lastName: lastName,
              #email: email,
              #image: image,
            },
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #updateUser,
            [],
            {
              #userId: userId,
              #firstName: firstName,
              #lastName: lastName,
              #email: email,
              #image: image,
            },
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> deleteUser(
          {required String? userId}) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
          {#userId: userId},
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #deleteUser,
            [],
            {#userId: userId},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #deleteUser,
            [],
            {#userId: userId},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> checkFingerprintLogin() =>
      (super.noSuchMethod(
        Invocation.method(
          #checkFingerprintLogin,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #checkFingerprintLogin,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #checkFingerprintLogin,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> saveFingerprintLogin(
          {required _i3.LoginEntity? user}) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveFingerprintLogin,
          [],
          {#user: user},
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #saveFingerprintLogin,
            [],
            {#user: user},
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #saveFingerprintLogin,
            [],
            {#user: user},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, bool>> removeFingerprintLogin() =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFingerprintLogin,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
            _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #removeFingerprintLogin,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, bool>>.value(
                _FakeEither_0<_i3.Failure, bool>(
          this,
          Invocation.method(
            #removeFingerprintLogin,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, bool>>);

  @override
  _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>> loginWithFingerprint() =>
      (super.noSuchMethod(
        Invocation.method(
          #loginWithFingerprint,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
            _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #loginWithFingerprint,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>.value(
                _FakeEither_0<_i3.Failure, _i3.LoginEntity>(
          this,
          Invocation.method(
            #loginWithFingerprint,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, _i3.LoginEntity>>);
}
