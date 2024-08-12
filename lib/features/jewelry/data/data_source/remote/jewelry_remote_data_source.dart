import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/jewelry/data/models/jewelry_model.dart';

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
          (response.data as List)
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
}
