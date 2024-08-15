import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jewelryRemoteDataSourceProvider = Provider(
  (ref) => JewelryRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class JewelryRemoteDataSource {
  final Dio dio;

  JewelryRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, List<JewelryModel>>> getAll() async {
    try {
      Response response = await dio.get(
        ApiEndpoints.getJewelry,
      );
      if (response.statusCode == 200) {
        return Right(
          (response.data['data'] as List)
              .map((e) => JewelryModel.fromMap(e))
              .toList(),
        );
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

  Future<Either<Failure, JewelryModel>> getById(String id) async {
    try {
      Response response = await dio.get(
        "${ApiEndpoints.getJewelry}/$id",
      );
      if (response.statusCode == 200) {
        return Right(JewelryModel.fromMap(response.data['data']));
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

  Future<Either<Failure, JewelryModel>> create({
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  }) async {
    try {
      final formData = FormData.fromMap({
        "jewelryName": name,
        "jewelryDescription": description,
        "jewelryPrice": price,
        "jewelryCategory": category,
        "jewelryImage": await MultipartFile.fromFile(image),
      });
      Response response = await dio.post(
        ApiEndpoints.getJewelry,
        data: formData,
      );
      if (response.statusCode == 201) {
        return Right(JewelryModel.fromMap(response.data['jewelry']));
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

  Future<Either<Failure, JewelryModel>> update({
    required String id,
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  }) async {
    try {
      final formData = FormData.fromMap({
        "jewelryName": name,
        "jewelryDescription": description,
        "jewelryPrice": price,
        "jewelryCategory": category,
        "jewelryImage": await MultipartFile.fromFile(image),
      });
      Response response = await dio.put(
        "${ApiEndpoints.getJewelry}/$id",
        data: formData,
      );
      if (response.statusCode == 200) {
        return Right(JewelryModel.fromMap(response.data['jewelry']));
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

  Future<Either<Failure, void>> delete(String id) async {
    try {
      Response response = await dio.delete(
        "${ApiEndpoints.getJewelry}/$id",
      );
      if (response.statusCode == 200) {
        return Right(null);
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
