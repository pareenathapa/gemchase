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
}
