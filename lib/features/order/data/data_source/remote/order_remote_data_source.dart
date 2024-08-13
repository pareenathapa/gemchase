import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/order/data/models/order_model.dart';

final orderRemoteDataSourceProvider = Provider(
  (ref) => OrderRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource({
    required this.dio,
  });

  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    try {
      Response response = await dio.get(
        "${ApiEndpoints.order}/user",
      );
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) => OrderModel.fromMap(e)).toList(),
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

  Future<Either<Failure, OrderModel>> getOrderById(String id) async {
    try {
      Response response = await dio.get(
        "${ApiEndpoints.order}/$id",
      );
      if (response.statusCode == 200) {
        return Right(OrderModel.fromMap(response.data['data']));
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

  Future<Either<Failure, bool>> createOrder({
    required String jewelryId,
    required int quantity,
  }) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.order,
        data: {
          "jewelryId": jewelryId,
          "quantity": quantity,
        },
      );
      if (response.statusCode == 201) {
        return Right(true);
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

  Future<Either<Failure, bool>> deleteOrder(String id) async {
    try {
      Response response = await dio.delete(
        "${ApiEndpoints.order}/$id",
      );
      if (response.statusCode == 200) {
        return Right(true);
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
