import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:gemchase_clean_arch/core/failure/failure.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class JewelryState {
  final bool isLoading;
  final bool isSuccess;
  final Failure? error;

  final List<JewelryEntity>? allJewelry;
  final List<String> categories;
  final JewelryEntity? selectedJewelry;
  final String selectedCategory;

  final bool isSearching;
  final TextEditingController searchController;
  final List<JewelryEntity> searchResults;

  JewelryState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    this.allJewelry,
    required this.categories,
    this.selectedJewelry,
    required this.selectedCategory,
    required this.isSearching,
    required this.searchController,
    required this.searchResults,
  });

  factory JewelryState.initial() {
    return JewelryState(
      isLoading: false,
      isSuccess: false,
      error: null,
      allJewelry: null,
      categories: const [
        'All',
        'Earings',
        'Bangles',
        'Nose Ring',
        'Necklaces',
        'Rings',
      ],
      selectedJewelry: null,
      selectedCategory: "All",
      isSearching: false,
      searchController: TextEditingController(),
      searchResults: const [],
    );
  }

  JewelryState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<Failure?>? error,
    ValueGetter<List<JewelryEntity>?>? allJewelry,
    List<String>? categories,
    ValueGetter<JewelryEntity?>? selectedJewelry,
    String? selectedCategory,
    bool? isSearching,
    TextEditingController? searchController,
    List<JewelryEntity>? searchResults,
  }) {
    return JewelryState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error != null ? error() : this.error,
      allJewelry: allJewelry != null ? allJewelry() : this.allJewelry,
      categories: categories ?? this.categories,
      selectedJewelry:
          selectedJewelry != null ? selectedJewelry() : this.selectedJewelry,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
      searchController: searchController ?? this.searchController,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  String toString() {
    return 'JewelryState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, allJewelry: $allJewelry, categories: $categories, selectedJewelry: $selectedJewelry, selectedCategory: $selectedCategory, isSearching: $isSearching, searchController: $searchController, searchResults: $searchResults)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JewelryState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        listEquals(other.allJewelry, allJewelry) &&
        listEquals(other.categories, categories) &&
        other.selectedJewelry == selectedJewelry &&
        other.selectedCategory == selectedCategory &&
        other.isSearching == isSearching &&
        other.searchController == searchController &&
        listEquals(other.searchResults, searchResults);
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        allJewelry.hashCode ^
        categories.hashCode ^
        selectedJewelry.hashCode ^
        selectedCategory.hashCode ^
        isSearching.hashCode ^
        searchController.hashCode ^
        searchResults.hashCode;
  }
}
