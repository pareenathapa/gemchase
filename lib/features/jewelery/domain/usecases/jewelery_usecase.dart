import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/repository/jewelery_repository.dart';

 
final jeweleryUsecaseProvider = Provider<JeweleryUsecase>(
    (ref) => JeweleryUsecase(jeweleryRepository: ref.read(jeweleryRepositoryProvider)));
 
class JeweleryUsecase {
  final IJeweleryRepository jeweleryRepository;
  JeweleryUsecase({required this.jeweleryRepository});   //dependency injection
 
  Future<Either<Failure, List<JeweleryEntity>>> getAllJewelerys(int page) {
    return jeweleryRepository.getAllJewelerys(page);
  }
}
