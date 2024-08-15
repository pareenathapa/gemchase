import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';

class OrderState {
  final bool isLoading;
  final bool isSuccess;
  final Failure? error;
  final List<OrderEntity> allOrders;
  final OrderEntity? selectedOrder;
  final List<OrderEntity> userOrders;
  final List<OrderEntity> pendingOrders;
  final List<OrderEntity> completedOrders;
  final List<OrderEntity> cancelledOrders;
  OrderState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    required this.allOrders,
    this.selectedOrder,
    required this.userOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.cancelledOrders,
  });

  factory OrderState.initial() {
    return OrderState(
      isLoading: false,
      isSuccess: false,
      error: null,
      allOrders: const [],
      selectedOrder: null,
      userOrders: const [],
      pendingOrders: const [],
      completedOrders: const [],
      cancelledOrders: const [],
    );
  }

  OrderState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<Failure?>? error,
    List<OrderEntity>? allOrders,
    ValueGetter<OrderEntity?>? selectedOrder,
    List<OrderEntity>? userOrders,
    List<OrderEntity>? pendingOrders,
    List<OrderEntity>? completedOrders,
    List<OrderEntity>? cancelledOrders,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error != null ? error() : this.error,
      allOrders: allOrders ?? this.allOrders,
      selectedOrder:
          selectedOrder != null ? selectedOrder() : this.selectedOrder,
      userOrders: userOrders ?? this.userOrders,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_loading': isLoading,
      'is_success': isSuccess,
      'error': error?.toMap(),
      'all_orders': allOrders.map((x) => x.toMap()).toList(),
      'selected_order': selectedOrder?.toMap(),
      'user_orders': userOrders.map((x) => x.toMap()).toList(),
      'pending_orders': pendingOrders.map((x) => x.toMap()).toList(),
      'completed_orders': completedOrders.map((x) => x.toMap()).toList(),
      'cancelled_orders': cancelledOrders.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderState.fromMap(Map<String, dynamic> map) {
    return OrderState(
      isLoading: map['is_loading'] ?? false,
      isSuccess: map['is_success'] ?? false,
      error: map['error'] != null ? Failure.fromMap(map['error']) : null,
      allOrders: List<OrderEntity>.from(
          map['all_orders']?.map((x) => OrderEntity.fromMap(x)) ?? const []),
      selectedOrder: map['selected_order'] != null
          ? OrderEntity.fromMap(map['selected_order'])
          : null,
      userOrders: List<OrderEntity>.from(
          map['user_orders']?.map((x) => OrderEntity.fromMap(x)) ?? const []),
      pendingOrders: List<OrderEntity>.from(
          map['pending_orders']?.map((x) => OrderEntity.fromMap(x)) ??
              const []),
      completedOrders: List<OrderEntity>.from(
          map['completed_orders']?.map((x) => OrderEntity.fromMap(x)) ??
              const []),
      cancelledOrders: List<OrderEntity>.from(
          map['cancelled_orders']?.map((x) => OrderEntity.fromMap(x)) ??
              const []),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderState.fromJson(String source) =>
      OrderState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, allOrders: $allOrders, selectedOrder: $selectedOrder, userOrders: $userOrders, pendingOrders: $pendingOrders, completedOrders: $completedOrders, cancelledOrders: $cancelledOrders)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        listEquals(other.allOrders, allOrders) &&
        other.selectedOrder == selectedOrder &&
        listEquals(other.userOrders, userOrders) &&
        listEquals(other.pendingOrders, pendingOrders) &&
        listEquals(other.completedOrders, completedOrders) &&
        listEquals(other.cancelledOrders, cancelledOrders);
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        allOrders.hashCode ^
        selectedOrder.hashCode ^
        userOrders.hashCode ^
        pendingOrders.hashCode ^
        completedOrders.hashCode ^
        cancelledOrders.hashCode;
  }
}
