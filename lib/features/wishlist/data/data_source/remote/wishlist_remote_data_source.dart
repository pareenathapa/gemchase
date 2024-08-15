import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishListRemoteDataSourceProvider = Provider(
  (ref) => WishListRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class WishListRemoteDataSource {
  final Dio dio;

  WishListRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, List<JewelryModel>>> getUserWishlist() async {
    try {
      Response response = await dio.get(
        ApiEndpoints.wishlist,
      );
      if (response.statusCode == 200) {
        return Right(
          (response.data['data']['jewelry'] as List)
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

  // Add jewelry to wishlist
  Future<Either<Failure, bool>> addJewelryToWishlist({
    required String jewelryId,
  }) async {
    try {
      Response response = await dio.post(
        "${ApiEndpoints.wishlist}/add",
        data: {
          "jewelryId": jewelryId,
        },
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

  // Remove jewelry from wishlist
  Future<Either<Failure, bool>> removeJewelryFromWishlist({
    required String jewelryId,
  }) async {
    try {
      Response response = await dio.post(
        "${ApiEndpoints.wishlist}/remove",
        data: {
          "jewelryId": jewelryId,
        },
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
