import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

abstract class IJewelryRepository {
  Future<Either<Failure, JewelryEntity>> getById(String id);
  Future<Either<Failure, List<JewelryEntity>>> getAll();
}
