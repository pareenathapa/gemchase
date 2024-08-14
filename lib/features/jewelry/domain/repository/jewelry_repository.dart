import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';

abstract class IJewelryRepository {
  Future<Either<Failure, JewelryEntity>> getById(String id);
  Future<Either<Failure, List<JewelryEntity>>> getAll();
  Future<Either<Failure, JewelryEntity>> create({
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  });
  Future<Either<Failure, JewelryEntity>> update({
    required String id,
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  });
  Future<Either<Failure, void>> delete(String id);
}
