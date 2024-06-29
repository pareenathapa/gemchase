import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';

class JeweleryState {
  final List<JeweleryEntity> lstJewelerys;
  final bool isLoading;
  final String? error;
  final bool hasReachedMax;
  final int page;
 
  JeweleryState({required this.lstJewelerys, required this.isLoading, this.error, required this.hasReachedMax, required this.page});
 
  factory JeweleryState.initial() {
    return JeweleryState(lstJewelerys: [], isLoading: false, hasReachedMax: false,
      page: 0,
    );
  }
 
  JeweleryState copyWith({
    final List<JeweleryEntity>? lstJewelerys,
    final bool? isLoading,
    final String? error,
    final bool? hasReachedMax,
    final int? page,
  }) {
    return JeweleryState(
        lstJewelerys: lstJewelerys ?? this.lstJewelerys,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax?? this.hasReachedMax,
        page: page?? this.page
        );
  }
}
