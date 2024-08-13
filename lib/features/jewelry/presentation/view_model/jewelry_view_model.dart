
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/usecase/jewelry_usecase.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view_model/jewelry_state.dart';

final jewelryViewModelProvider =
    StateNotifierProvider<JewelryViewModel, JewelryState>(
  (ref) => JewelryViewModel(
    ref.read(jewelryUseCaseProvider),
  ),
);

class JewelryViewModel extends StateNotifier<JewelryState> {
  JewelryViewModel(
    this.jewelryUseCase,
  ) : super(JewelryState.initial()) {
    getAll();
  }
  final JewelryUseCase jewelryUseCase;

  Future<void> getAll({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await jewelryUseCase.getAll();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (jewelryList) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          allJewelry: () => jewelryList,
          searchResults: jewelryList,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> getById({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String id,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await jewelryUseCase.getById(id);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (jewelry) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          selectedJewelry: () => jewelry,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  void getByCategory(String category) {
    // Filter the jewelry list by category ALSO CHAEK NULL SAFETY
    if (state.allJewelry != null) {
      if (category.toLowerCase() == "all") {
        state = state.copyWith(
          selectedCategory: category,
          searchResults: state.allJewelry,
        );
        return;
      }
      final filteredJewelry = state.allJewelry!
          .where((jewelry) =>
              jewelry.jewelryCategory?.toLowerCase() == category.toLowerCase())
          .toList();
      state = state.copyWith(
        selectedCategory: category,
        searchResults: filteredJewelry,
      );
    } else {
      state = state.copyWith(
        selectedCategory: category,
        searchResults: [],
      );
    }
  }
}
