import 'dart:convert';

import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class CartItemEntity {
  final JewelryEntity jewelry;
  final int quantity;

  CartItemEntity({
    required this.jewelry,
    required this.quantity,
  });

  CartItemEntity copyWith({
    JewelryEntity? jewelry,
    int? quantity,
  }) {
    return CartItemEntity(
      jewelry: jewelry ?? this.jewelry,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jewelry': jewelry.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      jewelry: JewelryEntity.fromMap(map['jewelry']),
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemEntity.fromJson(String source) =>
      CartItemEntity.fromMap(json.decode(source));

  @override
  String toString() => 'CartItemEntity(jewelry: $jewelry, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemEntity &&
        other.jewelry == jewelry &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => jewelry.hashCode ^ quantity.hashCode;
}
