import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gemchase_clean_arch/features/jewelry/domain/entities/jewelry_entity.dart';

class JewelryModel extends JewelryEntity {
  const JewelryModel({
    super.id,
    super.jewelryName,
    super.jewelryPrice,
    super.jewelryDescription,
    super.jewelryCategory,
    super.jewelryImage,
    super.createdAt,
  });

  JewelryModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? jewelryName,
    ValueGetter<double?>? jewelryPrice,
    ValueGetter<String?>? jewelryDescription,
    ValueGetter<String?>? jewelryCategory,
    ValueGetter<String?>? jewelryImage,
    ValueGetter<String?>? createdAt,
  }) {
    return JewelryModel(
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
      'id': id,
      'jewelryName': jewelryName,
      'jewelryPrice': jewelryPrice,
      'jewelryDescription': jewelryDescription,
      'jewelryCategory': jewelryCategory,
      'jewelryImage': jewelryImage,
      'createdAt': createdAt,
    };
  }

  factory JewelryModel.fromMap(Map<String, dynamic> map) {
    return JewelryModel(
      id: map['id'],
      jewelryName: map['jewelryName'],
      jewelryPrice: double.parse("${map['jewelryPrice'] ?? 0.0}"),
      jewelryDescription: map['jewelryDescription'],
      jewelryCategory: map['jewelryCategory'],
      jewelryImage: map['jewelryImage'],
      createdAt: map['createdAt'] != null ? (map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JewelryModel.fromJson(String source) =>
      JewelryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JewelryModel(id: $id, jewelryName: $jewelryName, jewelryPrice: $jewelryPrice, jewelryDescription: $jewelryDescription, jewelryCategory: $jewelryCategory, jewelryImage: $jewelryImage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JewelryModel &&
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
}
