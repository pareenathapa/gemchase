import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jewelryUseCaseProvider = Provider((ref) {
  return JewelryUseCase(
    ref.read(jewelryRepositoryProvider),
  );
});

class JewelryUseCase {
  final IJewelryRepository _jewelryRepository;

  JewelryUseCase(this._jewelryRepository);

  Future<Either<Failure, List<JewelryEntity>>> getAll() async {
    return await _jewelryRepository.getAll();
  }

  Future<Either<Failure, JewelryEntity>> getById(String id) async {
    return await _jewelryRepository.getById(id);
  }

  Future<Either<Failure, JewelryEntity>> create({
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  }) async {
    return await _jewelryRepository.create(
      name: name,
      description: description,
      price: price,
      image: image,
      category: category,
    );
  }

  Future<Either<Failure, void>> delete(String id) async {
    return await _jewelryRepository.delete(id);
  }

  Future<Either<Failure, JewelryEntity>> update({
    required String id,
    required String name,
    required String description,
    required String price,
    required String image,
    required String category,
  }) async {
    return await _jewelryRepository.update(
      id: id,
      name: name,
      description: description,
      price: price,
      image: image,
      category: category,
    );
  }
}
