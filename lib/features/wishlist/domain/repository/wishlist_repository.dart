import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';

abstract class IWishlistRepository {
  Future<Either<Failure, List<JewelryEntity>>> getUserWishlist();
  Future<Either<Failure, bool>> addJewelryToWishlist({
    required String jewelryId,
  });
  Future<Either<Failure, bool>> removeJewelryFromWishlist({
    required String jewelryId,
  });
}
