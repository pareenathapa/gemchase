import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
    ref.read(hiveServiceProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;
  final HiveService _hiveService;

  AuthUseCase(this._authRepository, this._hiveService);

  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return await _authRepository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    return result.fold(
      (l) => Left(l),
      (r) async {
        await _hiveService.saveUser(
          LoginHiveModel.fromMap(
            LoginEntity(
              token: r.token,
              user: r.user,
            ).toMap(),
          ),
        );
        return Right(r);
      },
    );
  }

  Future<Either<Failure, LoginEntity?>> getSavedUser() async {
    final result = await _hiveService.getUser();
    return result != null
        ? Right(
            LoginEntity.fromMap(result.toMap()),
          )
        : Left(
            Failure(
              error: 'No user found',
            ),
          );
  }
}
