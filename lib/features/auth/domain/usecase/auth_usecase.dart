import 'dart:io';

import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:local_auth/local_auth.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
    ref.read(settingsHiveServiceProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;
  final SettingsHiveService _hiveService;

  AuthUseCase(this._authRepository, this._hiveService);

  // Register user
  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required File? image,
  }) async {
    return await _authRepository.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
    );
  }

  // Login user and save to Hive
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
        await _hiveService.updateSettings(
          AppSettingsHiveModel(
            user: LoginHiveModel.fromMap(r.toMap()),
          ),
        );
        return Right(r);
      },
    );
  }

  // Get saved user from Hive
  Future<Either<Failure, LoginEntity?>> getSavedUser() async {
    final result = await _hiveService.getSettings();
    return result.user != null
        ? Right(
            LoginEntity.fromMap(result.user!.toMap()),
          )
        : Left(
            Failure(
              error: 'No user found',
            ),
          );
  }

  // Logout user by clearing Hive data
  Future<Either<Failure, bool>> logout() async {
    try {
      final result = await _hiveService.getSettings();
      await _hiveService.updateSettings(
        result.copyWith(
          user: () => null,
        ),
      );
      return const Right(true);
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }

  // Get user by ID
  Future<Either<Failure, LoginEntity>> getUserById({
    required String userId,
  }) async {
    return await _authRepository.getUserById(userId: userId);
  }

  // Update user and save to Hive
  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required File? image,
  }) async {
    final result = await _authRepository.updateUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      image: image,
    );

    return result.fold(
      (l) => Left(l),
      (r) async {
        // If successful, update Hive with the new user data
        final updatedUserResult =
            await _authRepository.getUserById(userId: userId);
        return updatedUserResult.fold(
          (l) => Left(l),
          (updatedUser) async {
            await _hiveService.updateSettings(
              AppSettingsHiveModel(
                user: LoginHiveModel.fromMap(updatedUser.toMap()),
              ),
            );
            return const Right(true);
          },
        );
      },
    );
  }

  // Delete user
  Future<Either<Failure, bool>> deleteUser({
    required String userId,
  }) async {
    return await _authRepository.deleteUser(userId: userId);
  }

  // Check fingerprint login status
  Future<Either<Failure, bool>> checkFingerprintLogin() async {
    final result = await _hiveService.getSettings();
    return result.fingerPrintUser != null
        ? const Right(true)
        : Left(Failure(error: 'No fingerprint user found'));
  }

  // Save fingerprint login status
  Future<Either<Failure, bool>> saveFingerprintLogin({
    required LoginEntity user,
  }) async {
    final result = await _hiveService.getSettings();
    await _hiveService.updateSettings(
      result.copyWith(
        fingerPrintUser: () => LoginHiveModel.fromMap(user.toMap()),
      ),
    );
    return const Right(true);
  }

  // Remove fingerprint login status
  Future<Either<Failure, bool>> removeFingerprintLogin() async {
    final result = await _hiveService.getSettings();
    await _hiveService.updateSettings(
      result.copyWith(
        fingerPrintUser: () => null,
      ),
    );
    return const Right(false);
  }

  // Login user with fingerprint
  Future<Either<Failure, LoginEntity>> loginWithFingerprint() async {
    bool isAuthorized = await LocalAuthentication().authenticate(
      localizedReason: "Authenticate to login",
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
    );

    if (isAuthorized) {
      final result = await _hiveService.getSettings();
      return result.fingerPrintUser != null
          ? Right(
              LoginEntity.fromMap(result.fingerPrintUser!.toMap()),
            )
          : Left(
              Failure(
                error: 'No fingerprint user found',
              ),
            );
    } else {
      return Left(
        Failure(
          error: 'Fingerprint authentication failed',
        ),
      );
    }
  }
}
