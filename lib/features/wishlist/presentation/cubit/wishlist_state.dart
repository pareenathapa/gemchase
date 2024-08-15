import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:gemchase_clean_arch/core/common/exports.dart';

class WishlistState {
  final bool isLoading;
  final bool isSuccess;
  final Failure? error;

  final List<JewelryEntity> wishlist;
  final JewelryEntity? selectedJewelry;
  WishlistState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    required this.wishlist,
    this.selectedJewelry,
  });

  factory WishlistState.initial() {
    return WishlistState(
      isLoading: false,
      isSuccess: false,
      error: null,
      wishlist: const [],
      selectedJewelry: null,
    );
  }

  WishlistState copyWith({
    bool? isLoading,
    bool? isSuccess,
    ValueGetter<Failure?>? error,
    List<JewelryEntity>? wishlist,
    ValueGetter<JewelryEntity?>? selectedJewelry,
  }) {
    return WishlistState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error != null ? error() : this.error,
      wishlist: wishlist ?? this.wishlist,
      selectedJewelry:
          selectedJewelry != null ? selectedJewelry() : this.selectedJewelry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'is_loading': isLoading,
      'is_success': isSuccess,
      'error': error?.toMap(),
      'wishlist': wishlist.map((x) => x.toMap()).toList(),
      'selected_jewelry': selectedJewelry?.toMap(),
    };
  }

  factory WishlistState.fromMap(Map<String, dynamic> map) {
    return WishlistState(
      isLoading: map['is_loading'] ?? false,
      isSuccess: map['is_success'] ?? false,
      error: map['error'] != null ? Failure.fromMap(map['error']) : null,
      wishlist: List<JewelryEntity>.from(
          map['wishlist']?.map((x) => JewelryEntity.fromMap(x)) ?? const []),
      selectedJewelry: map['selected_jewelry'] != null
          ? JewelryEntity.fromMap(map['selected_jewelry'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistState.fromJson(String source) =>
      WishlistState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WishlistState(isLoading: $isLoading, isSuccess: $isSuccess, error: $error, wishlist: $wishlist, selectedJewelry: $selectedJewelry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WishlistState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.error == error &&
        listEquals(other.wishlist, wishlist) &&
        other.selectedJewelry == selectedJewelry;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        error.hashCode ^
        wishlist.hashCode ^
        selectedJewelry.hashCode;
  }
}
