import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/cart/domain/entity/cart_entity.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';
import 'cart_state.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(),
);

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel() : super(CartState.initial());

  void addToCart(JewelryEntity jewelry) {
    final cartItems = state.cartItems;
    final index = cartItems.indexWhere((element) => element.jewelry == jewelry);

    if (index == -1) {
      state = state.copyWith(
        cartItems: [
          ...cartItems,
          CartItemEntity(jewelry: jewelry, quantity: 1),
        ],
      );
    } else {
      final updatedCartItems = cartItems.map((e) {
        if (e.jewelry == jewelry) {
          return e.copyWith(quantity: e.quantity + 1);
        }
        return e;
      }).toList();

      state = state.copyWith(cartItems: updatedCartItems);
    }
  }

  void removeFromCart(JewelryEntity jewelry) {
    final cartItems = state.cartItems;
    final index = cartItems.indexWhere((element) => element.jewelry == jewelry);

    if (index == -1) {
      return;
    }

    if (cartItems[index].quantity == 1) {
      final updatedCartItems =
          cartItems.where((element) => element.jewelry != jewelry).toList();
      state = state.copyWith(cartItems: updatedCartItems);
    } else {
      final updatedCartItems = cartItems.map((e) {
        if (e.jewelry == jewelry) {
          return e.copyWith(quantity: e.quantity - 1);
        }
        return e;
      }).toList();

      state = state.copyWith(cartItems: updatedCartItems);
    }
  }

  void clearCart() {
    state = state.copyWith(cartItems: []);
  }
}
