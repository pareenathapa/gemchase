import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelry/data/models/jewelry_model.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

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

  @override
  Future<Either<Failure, JewelryModel>> create(
      {required String name,
      required String description,
      required String price,
      required String image,
      required String category}) async {
    return await remoteDataSource.create(
      name: name,
      description: description,
      price: price,
      image: image,
      category: category,
    );
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    return await remoteDataSource.delete(id);
  }

  @override
  Future<Either<Failure, JewelryModel>> update(
      {required String id,
      required String name,
      required String description,
      required String price,
      required String image,
      required String category}) async {
    return await remoteDataSource.update(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      category: category,
    );
  }
}
