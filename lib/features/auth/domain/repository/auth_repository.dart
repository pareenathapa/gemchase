import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required File? image,
  });
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, LoginEntity>> getUserById({
    required String userId,
  });
  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required File? image,
  });
  Future<Either<Failure, bool>> deleteUser({
    required String userId,
  });
}
