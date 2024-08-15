import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gemchase_clean_arch/features/cart/domain/entity/cart_entity.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class CartState {
  final bool isLoading;
  final bool isSuccess;
  final List<CartItemEntity> cartItems;

  CartState({
    required this.isLoading,
    required this.isSuccess,
    required this.cartItems,
  });

  factory CartState.initial() {
    return CartState(
      isLoading: false,
      isSuccess: false,
      cartItems: const [],
    );
  }

  CartState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<CartItemEntity>? cartItems,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  String toString() =>
      'CartState(isLoading: $isLoading, isSuccess: $isSuccess, cartItems: $cartItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^ isSuccess.hashCode ^ cartItems.hashCode;
}
