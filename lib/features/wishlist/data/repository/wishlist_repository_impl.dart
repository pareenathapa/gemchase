import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:gemchase_clean_arch/core/failure/failure.dart';

import '../data_source/remote/wishlist_remote_data_source.dart';
import '../../domain/repository/wishlist_repository.dart';

final wishListRepositoryProvider = Provider<IWishlistRepository>(
  (ref) => WishlistRepositoryImpl(
    remoteDataSource: ref.read(wishListRemoteDataSourceProvider),
  ),
);

class WishlistRepositoryImpl implements IWishlistRepository {
  final WishListRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> addJewelryToWishlist(
      {required String jewelryId}) async {
    return await remoteDataSource.addJewelryToWishlist(jewelryId: jewelryId);
  }

  @override
  Future<Either<Failure, List<JewelryModel>>> getUserWishlist() async {
    return await remoteDataSource.getUserWishlist();
  }

  @override
  Future<Either<Failure, bool>> removeJewelryFromWishlist(
      {required String jewelryId}) async {
    return await remoteDataSource.removeJewelryFromWishlist(
        jewelryId: jewelryId);
  }
}
