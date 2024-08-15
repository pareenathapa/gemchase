import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({
    required this.dio,
  });

  // Register user
  Future<Either<Failure, bool>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "image": image != null
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              )
            : null,
      });

      Response response = await dio.post(
        ApiEndpoints.register,
        data: formData,
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Login user
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return Right(LoginModel.fromMap(response.data));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          error: 'failed',
          statusCode: '0',
        ),
      );
    }
  }

  // Get user by ID
  Future<Either<Failure, LoginModel>> getUserById({
    required String userId,
  }) async {
    try {
      Response response = await dio.get(
        '${ApiEndpoints.getUser}/$userId',
      );
      if (response.statusCode == 200) {
        return Right(LoginModel.fromMap(response.data));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    } catch (e) {
      return Left(
        Failure(
          error: 'failed',
          statusCode: '0',
        ),
      );
    }
  }

  // Update user
  Future<Either<Failure, bool>> updateUser({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "image": image != null
            ? await MultipartFile.fromFile(
                image.path,
                filename: image.path.split('/').last,
              )
            : null,
      });

      Response response = await dio.put(
        '${ApiEndpoints.updateUser}/$userId',
        data: formData,
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Delete user
  Future<Either<Failure, bool>> deleteUser({
    required String userId,
  }) async {
    try {
      Response response = await dio.delete(
        '${ApiEndpoints.getUser}/$userId',
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
