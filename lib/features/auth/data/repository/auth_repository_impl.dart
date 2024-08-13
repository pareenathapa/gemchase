import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required File? image,
  }) async {
    return await remoteDataSource.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
    );
  }

  @override
  Future<Either<Failure, LoginModel>> getUserById({
    required String userId,
  }) async {
    return await remoteDataSource.getUserById(userId: userId);
  }

  @override
  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required File? image,
  }) async {
    return await remoteDataSource.updateUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      image: image,
    );
  }

  @override
  Future<Either<Failure, bool>> deleteUser({
    required String userId,
  }) async {
    return await remoteDataSource.deleteUser(userId: userId);
  }
}
