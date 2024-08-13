import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';

abstract class IJewelryRepository {
  Future<Either<Failure, JewelryEntity>> getById(String id);
  Future<Either<Failure, List<JewelryEntity>>> getAll();
}
