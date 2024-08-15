import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'jewelry_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<JewelryUseCase>(),
])
void main() {
  late MockJewelryUseCase jewelryUseCase;

  setUp(() {
    jewelryUseCase = MockJewelryUseCase();
  });

  group('JewelryUseCase - getAll', () {
    final List<JewelryEntity> jewelryList = [
      JewelryEntity(
        id: '1',
        jewelryName: 'Ring',
        jewelryImage: 'image1.jpg',
        jewelryPrice: 100.0,
      ),
      JewelryEntity(
        id: '2',
        jewelryName: 'Necklace',
        jewelryImage: 'image2.jpg',
        jewelryPrice: 200.0,
      ),
    ];

    test('should return list of JewelryEntity when getAll is successful',
        () async {
      // Arrange
      when(jewelryUseCase.getAll()).thenAnswer((_) async => Right(jewelryList));

      // Act
      final result = await jewelryUseCase.getAll();

      // Assert
      expect(result, Right(jewelryList));
      verify(jewelryUseCase.getAll()).called(1);
    });

    test('should return Failure when getAll fails', () async {
      // Arrange
      final failure = Failure(error: 'Failed to load jewelry');
      when(jewelryUseCase.getAll()).thenAnswer((_) async => Left(failure));

      // Act
      final result = await jewelryUseCase.getAll();

      // Assert
      expect(result, Left(failure));
      verify(jewelryUseCase.getAll()).called(1);
    });
  });
}
