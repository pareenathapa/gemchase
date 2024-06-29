import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/my_snackbar.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/usecases/jewelery_usecase.dart';
import 'package:gemchase_clean_arch/features/jewelery/presentation/state/jewelery_state.dart';



final jeweleryViewModelProvider =
    StateNotifierProvider<JeweleryViewModel, JeweleryState>((ref) {
  return JeweleryViewModel(ref.read(jeweleryUsecaseProvider));
});
 
class JeweleryViewModel extends StateNotifier<JeweleryState> {
  JeweleryViewModel(this.jeweleryUsecase) : super(JeweleryState.initial()) {
    getAllJewelerys();
  }
  final JeweleryUsecase jeweleryUsecase;
 
  Future resetState() async {
    state = JeweleryState.initial();
    getAllJewelerys();
  }
 
  getAllJewelerys() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final jewelerys = currentState.lstJewelerys;
    final hasReachedMax = currentState.hasReachedMax;
 
    if (!hasReachedMax) {
      var data = await jeweleryUsecase.getAllJewelerys(page);
      data.fold((l) {
        state = state.copyWith(
            isLoading: false, error: l.error, hasReachedMax: true);
        showMySnackBar(message: l.error, color: Colors.red[800]);
      }, (r) {
        if (r.isEmpty) {
          state = state.copyWith(hasReachedMax: true, error: null);
        }
        else{
          state = state.copyWith(isLoading: false, lstJewelerys: [...jewelerys, ...r], error: null, page: page);
        }
      });
    }
  }
}