import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/order/data/repository/order_repository_impl.dart';
import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';
import 'package:gemchase_clean_arch/features/order/domain/repository/order_repository.dart';

final orderUseCaseProvider = Provider((ref) {
  return OrderUseCase(
    ref.read(orderRepositoryProvider),
  );
});

class OrderUseCase {
  final IOrderRepository _orderRepository;

  OrderUseCase(this._orderRepository);

  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    return await _orderRepository.getAllOrders();
  }

  Future<Either<Failure, OrderEntity>> getOrderById(String id) async {
    return await _orderRepository.getOrderById(id);
  }

  Future<Either<Failure, bool>> createOrder({
    required String jewelryId,
    required int quantity,
  }) async {
    return await _orderRepository.createOrder(
      jewelryId: jewelryId,
      quantity: quantity,
    );
  }

  Future<Either<Failure, bool>> deleteOrder(String id) async {
    return await _orderRepository.deleteOrder(id);
  }
}
