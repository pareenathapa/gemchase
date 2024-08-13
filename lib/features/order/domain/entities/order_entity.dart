import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class OrderEntity {
  final String? id;
  final JewelryEntity? jewelry;
  final int? quantity;
  final double? totalPrice;
  final String? status;
  final String? orderDate;
  final UserEntity? user;
  OrderEntity({
    this.id,
    this.jewelry,
    this.quantity,
    this.totalPrice,
    this.status,
    this.orderDate,
    this.user,
  });

  OrderEntity copyWith({
    ValueGetter<String?>? id,
    ValueGetter<JewelryEntity?>? jewelry,
    ValueGetter<int?>? quantity,
    ValueGetter<double?>? totalPrice,
    ValueGetter<String?>? status,
    ValueGetter<String?>? orderDate,
    ValueGetter<UserEntity?>? user,
  }) {
    return OrderEntity(
      id: id != null ? id() : this.id,
      jewelry: jewelry != null ? jewelry() : this.jewelry,
      quantity: quantity != null ? quantity() : this.quantity,
      totalPrice: totalPrice != null ? totalPrice() : this.totalPrice,
      status: status != null ? status() : this.status,
      orderDate: orderDate != null ? orderDate() : this.orderDate,
      user: user != null ? user() : this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '-id': id,
      'jewelry': jewelry?.toMap(),
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
      'orderDate': orderDate,
      'user': user?.toMap(),
    };
  }

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['-id'],
      jewelry:
          map['jewelry'] != null ? JewelryEntity.fromMap(map['jewelry']) : null,
      quantity: map['quantity']?.toInt(),
      totalPrice: map['totalPrice']?.toDouble(),
      status: map['status'],
      orderDate: map['orderDate'],
      user: map['user'] != null ? UserEntity.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderEntity.fromJson(String source) =>
      OrderEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderEntity(id: $id, jewelry: $jewelry, quantity: $quantity, totalPrice: $totalPrice, status: $status, orderDate: $orderDate, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderEntity &&
        other.id == id &&
        other.jewelry == jewelry &&
        other.quantity == quantity &&
        other.totalPrice == totalPrice &&
        other.status == status &&
        other.orderDate == orderDate &&
        other.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jewelry.hashCode ^
        quantity.hashCode ^
        totalPrice.hashCode ^
        status.hashCode ^
        orderDate.hashCode ^
        user.hashCode;
  }
}
