import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../core/failure/failure.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/local/auth_local_data_source.dart';



final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> login(String email, String password) {
    return _authLocalDataSource.login(email, password);
  }

  @override
  Future<Either<Failure, bool>> register(AuthEntity user) {
    return _authLocalDataSource.register(user);
  }

  // @override
  // Future<Either<Failure, String>> uploadProfilePicture(File file) async {
  //   return const Right("");
  // }
}