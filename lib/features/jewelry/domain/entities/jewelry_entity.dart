import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class JewelryEntity extends Equatable {
  final String? id;
  final String? jewelryName;
  final double? jewelryPrice;
  final String? jewelryDescription;
  final String? jewelryCategory;
  final String? jewelryImage;
  final String? createdAt;
  const JewelryEntity({
    this.id,
    this.jewelryName,
    this.jewelryPrice,
    this.jewelryDescription,
    this.jewelryCategory,
    this.jewelryImage,
    this.createdAt,
  });

  JewelryEntity copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? jewelryName,
    ValueGetter<double?>? jewelryPrice,
    ValueGetter<String?>? jewelryDescription,
    ValueGetter<String?>? jewelryCategory,
    ValueGetter<String?>? jewelryImage,
    ValueGetter<String?>? createdAt,
  }) {
    return JewelryEntity(
      id: id != null ? id() : this.id,
      jewelryName: jewelryName != null ? jewelryName() : this.jewelryName,
      jewelryPrice: jewelryPrice != null ? jewelryPrice() : this.jewelryPrice,
      jewelryDescription: jewelryDescription != null
          ? jewelryDescription()
          : this.jewelryDescription,
      jewelryCategory:
          jewelryCategory != null ? jewelryCategory() : this.jewelryCategory,
      jewelryImage: jewelryImage != null ? jewelryImage() : this.jewelryImage,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'jewelryName': jewelryName,
      'jewelryPrice': jewelryPrice,
      'jewelryDescription': jewelryDescription,
      'jewelryCategory': jewelryCategory,
      'jewelryImage': jewelryImage,
      'createdAt': createdAt,
    };
  }

  factory JewelryEntity.fromMap(Map<String, dynamic> map) {
    return JewelryEntity(
      id: map['_id'],
      jewelryName: map['jewelryName'],
      jewelryPrice: double.parse("${map['jewelryPrice'] ?? 0.0}"),
      jewelryDescription: map['jewelryDescription'],
      jewelryCategory: map['jewelryCategory'],
      jewelryImage: map['jewelryImage'],
      createdAt: map['createdAt'] != null ? (map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JewelryEntity.fromJson(String source) =>
      JewelryEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JewelryEntity(id: $id, jewelryName: $jewelryName, jewelryPrice: $jewelryPrice, jewelryDescription: $jewelryDescription, jewelryCategory: $jewelryCategory, jewelryImage: $jewelryImage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JewelryEntity &&
        other.id == id &&
        other.jewelryName == jewelryName &&
        other.jewelryPrice == jewelryPrice &&
        other.jewelryDescription == jewelryDescription &&
        other.jewelryCategory == jewelryCategory &&
        other.jewelryImage == jewelryImage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jewelryName.hashCode ^
        jewelryPrice.hashCode ^
        jewelryDescription.hashCode ^
        jewelryCategory.hashCode ^
        jewelryImage.hashCode ^
        createdAt.hashCode;
  }

  @override
  List<Object?> get props => [
        id,
        jewelryName,
        jewelryPrice,
        jewelryDescription,
        jewelryCategory,
        jewelryImage,
        createdAt,
      ];
}
