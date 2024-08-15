import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/order/data/models/order_model.dart';

import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';

import '../data_source/remote/order_remote_data_source.dart';
import '../../domain/repository/order_repository.dart';

final orderRepositoryProvider = Provider<IOrderRepository>(
  (ref) => OrderRepositoryImpl(
    remoteDataSource: ref.read(orderRemoteDataSourceProvider),
  ),
);

class OrderRepositoryImpl implements IOrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> createOrder({
    required String jewelryId,
    required int quantity,
  }) async {
    return await remoteDataSource.createOrder(
        jewelryId: jewelryId, quantity: quantity);
  }

  @override
  Future<Either<Failure, bool>> deleteOrder(String id) async {
    return await remoteDataSource.deleteOrder(id);
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders() async {
    return await remoteDataSource.getAllOrders();
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderById(String id) async {
    return await remoteDataSource.getOrderById(id);
  }
}
