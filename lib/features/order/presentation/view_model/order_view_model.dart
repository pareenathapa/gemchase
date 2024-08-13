import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/order/domain/usecase/order_usecase.dart';
import 'package:gemchase_clean_arch/features/order/presentation/view_model/order_state.dart';

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>(
  (ref) => OrderViewModel(
    ref.read(orderUseCaseProvider),
  ),
);

class OrderViewModel extends StateNotifier<OrderState> {
  OrderViewModel(
    this.orderUseCase,
  ) : super(OrderState.initial()) {
    getAllOrders();
  }

  final OrderUseCase orderUseCase;

  Future<void> getAllOrders({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await orderUseCase.getAllOrders();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (orderList) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          allOrders: orderList,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> getOrderById({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String id,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await orderUseCase.getOrderById(id);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (order) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          selectedOrder: () => order,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> createOrder({
    required String jewelryId,
    required int quantity,
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await orderUseCase.createOrder(
      jewelryId: jewelryId,
      quantity: quantity,
    );
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> deleteOrder({
    required String id,
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await orderUseCase.deleteOrder(id);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }
}
