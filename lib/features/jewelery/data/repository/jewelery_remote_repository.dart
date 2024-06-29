import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelery/data/datasource/remote/jewelery_remote_datasouce.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/repository/jewelery_repository.dart';

 
final jeweleryRemoteRepositoryProvider = Provider<IJeweleryRepository>((ref) {
  return JeweleryRemoteRepository(
      jeweleryRemoteDataSource: ref.read(jeweleryRemoteDatasourceProvider));
});
 
class JeweleryRemoteRepository implements IJeweleryRepository {   //IJeweleryRepository is abstract class here
  final JeweleryRemoteDatasource jeweleryRemoteDataSource;
  JeweleryRemoteRepository({required this.jeweleryRemoteDataSource});
 
 
  @override
  Future<Either<Failure, List<JeweleryEntity>>> getAllJewelerys(int page) {   //real time ma navayera kehi time pachi gayera data aaucha ki vanera future use gareko
    return jeweleryRemoteDataSource.getAllJewelerys(page);
  }
}