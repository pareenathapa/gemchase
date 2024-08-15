import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/order/data/repository/order_repository_impl.dart';
import 'package:gemchase_clean_arch/features/order/domain/entities/order_entity.dart';
import 'package:gemchase_clean_arch/features/order/domain/repository/order_repository.dart';
import 'package:gemchase_clean_arch/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:gemchase_clean_arch/features/wishlist/domain/repository/wishlist_repository.dart';

final wishListUseCaseProvider = Provider((ref) {
  return WishListUsecase(
    ref.read(wishListRepositoryProvider),
  );
});

class WishListUsecase {
  final IWishlistRepository _wishListRepository;

  WishListUsecase(this._wishListRepository);

  Future<Either<Failure, List<JewelryEntity>>> getUserWishlist() async {
    return await _wishListRepository.getUserWishlist();
  }

  Future<Either<Failure, bool>> addJewelryToWishlist({
    required String jewelryId,
  }) async {
    return await _wishListRepository.addJewelryToWishlist(
      jewelryId: jewelryId,
    );
  }

  Future<Either<Failure, bool>> removeJewelryFromWishlist({
    required String jewelryId,
  }) async {
    return await _wishListRepository.removeJewelryFromWishlist(
      jewelryId: jewelryId,
    );
  }
}
