import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/order/domain/usecase/order_usecase.dart';
import 'package:gemchase_clean_arch/features/order/presentation/view_model/order_state.dart';
import 'package:gemchase_clean_arch/features/wishlist/domain/usecase/wishlist_usecase.dart';
import 'package:gemchase_clean_arch/features/wishlist/presentation/cubit/wishlist_state.dart';

final wishListViewModelProvider =
    StateNotifierProvider<WishListViewModel, WishlistState>(
  (ref) => WishListViewModel(
    ref.read(wishListUseCaseProvider),
  ),
);

class WishListViewModel extends StateNotifier<WishlistState> {
  WishListViewModel(
    this.wishListUsecase,
  ) : super(WishlistState.initial()) {
    getAllWishlist();
  }

  final WishListUsecase wishListUsecase;

  Future<void> getAllWishlist({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: () => null,
      wishlist: [],
    );
    final result = await wishListUsecase.getUserWishlist();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
          wishlist: [],
        );
        onError?.call(failure.error);
      },
      (wishlist) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          wishlist: wishlist,
          error: () => null,
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> addToWishlist({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String jewelryId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: () => null,
      wishlist: [],
    );
    final result =
        await wishListUsecase.addJewelryToWishlist(jewelryId: jewelryId);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
          wishlist: [],
        );
        onError?.call(failure.error);
      },
      (wishlist) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
      },
    );
  }

  Future<void> removeFromWishlist({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String jewelryId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      error: () => null,
      wishlist: [],
    );
    final result =
        await wishListUsecase.removeJewelryFromWishlist(jewelryId: jewelryId);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
          wishlist: [],
        );
        onError?.call(failure.error);
      },
      (wishlist) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
      },
    );
  }
}
