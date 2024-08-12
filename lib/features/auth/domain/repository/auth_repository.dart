import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });
}
