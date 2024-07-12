import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/usecases/jewelery_usecase.dart';
import 'package:gemchase_clean_arch/features/jewelery/presentation/state/jewelery_state.dart';
import 'package:gemchase_clean_arch/features/jewelery/presentation/viewmodel/jewelery_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/jewelery_test_data.dart';
import 'jewelery_unit_test.mocks.dart';




@GenerateNiceMocks([
  MockSpec<JeweleryUsecase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late JeweleryUsecase mockJeweleryUsecase;
  late List<JeweleryEntity> lstJewelerys;

  setUp(
    () {
      mockJeweleryUsecase = MockJeweleryUsecase();
      lstJewelerys = JeweleryTestData.getJeweleryTestData();
      container = ProviderContainer(
        overrides: [
          jeweleryViewModelProvider.overrideWith(
            (ref) => JeweleryViewModel(mockJeweleryUsecase),
          )
        ],
      );
    },
  );

  // Test initial state
  test('check product initial state', () async {
    // Arrage
    when(mockJeweleryUsecase.getAllJewelerys(1)) // 1 is the page number
        .thenAnswer((_) => Future.value(Right(lstJewelerys)));

    // Act
    // Get all products
    await container.read(jeweleryViewModelProvider.notifier).getAllJewelerys();

    // Store the state
    final JeweleryState = container.read(jeweleryViewModelProvider);

    // Assert
    // Check the state
    expect(JeweleryState.isLoading, false);
    expect(JeweleryState.error, isNull);
    expect(JeweleryState.lstJewelerys, isNotEmpty);
  });

  test('Failing test on expecting empty product list', () async {
    // Arrage
    when(mockJeweleryUsecase.getAllJewelerys(1)) // 1 is the page number
        .thenAnswer((_) => Future.value(Right(lstJewelerys)));

    // Act
    // Get all products
    await container.read(jeweleryViewModelProvider.notifier).getAllJewelerys();

    // Store the state
    final JeweleryState = container.read(jeweleryViewModelProvider);

    // Assert
    // Check the state
    expect(JeweleryState.isLoading, false);
    expect(JeweleryState.error, isNull);
    expect(JeweleryState.lstJewelerys, isNotEmpty);
  });

  tearDown(() {
    container.dispose();
  });
}