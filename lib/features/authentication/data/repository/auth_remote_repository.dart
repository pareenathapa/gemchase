import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/remote/auth_remote_datasource.dart';
 
final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});
 
class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
 
  AuthRemoteRepository(this._authRemoteDataSource);
 
  @override
  Future<Either<Failure, bool>> login(String email, String password) {
    return _authRemoteDataSource.login(email, password);
  }
 
  @override
  Future<Either<Failure, bool>> register(AuthEntity user) {
    return _authRemoteDataSource.register(user);
  }
 
 
}