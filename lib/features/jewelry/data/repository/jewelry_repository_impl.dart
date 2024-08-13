import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelry/data/models/jewelry_model.dart';


import '../data_source/remote/jewelry_remote_data_source.dart';
import '../../domain/repository/jewelry_repository.dart';

final jewelryRepositoryProvider = Provider<IJewelryRepository>(
  (ref) => JewelryRepositoryImpl(
    remoteDataSource: ref.read(jewelryRemoteDataSourceProvider),
  ),
);

class JewelryRepositoryImpl implements IJewelryRepository {
  final JewelryRemoteDataSource remoteDataSource;

  JewelryRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<JewelryModel>>> getAll() async {
    return await remoteDataSource.getAll();
  }

  @override
  Future<Either<Failure, JewelryModel>> getById(String id) async {
    return await remoteDataSource.getById(id);
  }
}
