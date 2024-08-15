import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';

abstract class IOrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, OrderEntity>> getOrderById(String id);
  Future<Either<Failure, bool>> createOrder({
    required String jewelryId,
    required int quantity,
  });
  Future<Either<Failure, bool>> deleteOrder(String id);
}
