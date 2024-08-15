import 'package:flutter_test/flutter_test.dart';
import 'package:gemchase_clean_arch/features/order/domain/usecase/order_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';
import 'package:gemchase_clean_arch/features/order/domain/repository/order_repository.dart';

import 'order_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<OrderUseCase>(),
])
void main() {
  late MockOrderUseCase orderUseCase;

  setUp(() {
    orderUseCase = MockOrderUseCase();
  });

  group('OrderUseCase - getAllOrders', () {
    final List<OrderEntity> orders = [
      OrderEntity(
        id: '1',
        jewelry: JewelryEntity(
          id: '1',
          jewelryName: 'Ring',
          jewelryImage: 'image1.jpg',
          jewelryPrice: 100.0,
        ),
        quantity: 2,
        orderDate: DateTime.now().toString(),
      ),
      OrderEntity(
        id: '2',
        jewelry: JewelryEntity(
          id: '2',
          jewelryName: 'Necklace',
          jewelryImage: 'image2.jpg',
          jewelryPrice: 200.0,
        ),
        quantity: 1,
        orderDate: DateTime.now().toString(),
      ),
    ];

    test('should return list of OrderEntity when getAllOrders is successful',
        () async {
      // Arrange
      when(orderUseCase.getAllOrders()).thenAnswer((_) async => Right(orders));

      // Act
      final result = await orderUseCase.getAllOrders();

      // Assert
      expect(result, Right(orders));
      verify(orderUseCase.getAllOrders()).called(1);
    });

    test('should return Failure when getAllOrders fails', () async {
      // Arrange
      final failure = Failure(error: 'Failed to load orders');
      when(orderUseCase.getAllOrders()).thenAnswer((_) async => Left(failure));

      // Act
      final result = await orderUseCase.getAllOrders();

      // Assert
      expect(result, Left(failure));
      verify(orderUseCase.getAllOrders()).called(1);
    });
  });

  group('OrderUseCase - getOrderById', () {
    const String orderId = '1';
    final OrderEntity order = OrderEntity(
      id: orderId,
      jewelry: JewelryEntity(
        id: '1',
        jewelryName: 'Ring',
        jewelryImage: 'image1.jpg',
        jewelryPrice: 100.0,
      ),
      quantity: 2,
      orderDate: DateTime.now().toString(),
    );

    test('should return OrderEntity when getOrderById is successful', () async {
      // Arrange
      when(orderUseCase.getOrderById(orderId))
          .thenAnswer((_) async => Right(order));

      // Act
      final result = await orderUseCase.getOrderById(orderId);

      // Assert
      expect(result, Right(order));
      verify(orderUseCase.getOrderById(orderId)).called(1);
    });

    test('should return Failure when getOrderById fails', () async {
      // Arrange
      final failure = Failure(error: 'Order not found');
      when(orderUseCase.getOrderById(orderId))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await orderUseCase.getOrderById(orderId);

      // Assert
      expect(result, Left(failure));
      verify(orderUseCase.getOrderById(orderId)).called(1);
    });
  });

  group('OrderUseCase - createOrder', () {
    const String jewelryId = 'jewel1';
    const int quantity = 2;

    test('should return true when createOrder is successful', () async {
      // Arrange
      when(orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      )).thenAnswer((_) async => const Right(true));

      // Act
      final result = await orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      );

      // Assert
      expect(result, const Right(true));
      verify(orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      )).called(1);
    });

    test('should return Failure when createOrder fails', () async {
      // Arrange
      final failure = Failure(error: 'Failed to create order');
      when(orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      )).thenAnswer((_) async => Left(failure));

      // Act
      final result = await orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      );

      // Assert
      expect(result, Left(failure));
      verify(orderUseCase.createOrder(
        jewelryId: jewelryId,
        quantity: quantity,
      )).called(1);
    });
  });

  group('OrderUseCase - deleteOrder', () {
    const String orderId = '1';

    test('should return true when deleteOrder is successful', () async {
      // Arrange
      when(orderUseCase.deleteOrder(orderId))
          .thenAnswer((_) async => const Right(true));

      // Act
      final result = await orderUseCase.deleteOrder(orderId);

      // Assert
      expect(result, const Right(true));
      verify(orderUseCase.deleteOrder(orderId)).called(1);
    });

    test('should return Failure when deleteOrder fails', () async {
      // Arrange
      final failure = Failure(error: 'Failed to delete order');
      when(orderUseCase.deleteOrder(orderId))
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await orderUseCase.deleteOrder(orderId);

      // Assert
      expect(result, Left(failure));
      verify(orderUseCase.deleteOrder(orderId)).called(1);
    });
  });
}
