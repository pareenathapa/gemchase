import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelery/data/repository/jewelery_remote_repository.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';

 
final jeweleryRepositoryProvider = Provider<IJeweleryRepository>(
  (ref) {
    // return ref.read(productLocalRepositoryProvider);
    return ref.read(jeweleryRemoteRepositoryProvider);
  },
);
 
abstract class IJeweleryRepository {              //yesbhitra ko properties or functions independent huncha ani aru class ley yo abstract class lai implement or extend garera properties or function use garna milcha
  Future<Either<Failure, List<JeweleryEntity>>> getAllJewelerys(int page);
}
