import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/jewelery/domain/entity/jewelery_entity.dart';
 
///model vaneko database ko replica
import 'package:json_annotation/json_annotation.dart';

 
final jeweleryApiModelProvider =
    Provider<JeweleryApiModel>((ref) => JeweleryApiModel.empty());
 
@JsonSerializable()
class JeweleryApiModel {
  @JsonKey(name: '_id')
   final String? jeweleryId;
  final String jeweleryName;
  final int jeweleryPrice;
  final String jeweleryDescription;
  final String jeweleryCategory;
  final String? jeweleryImage;
  final String? createdAt;
 
  JeweleryApiModel(
      {this.jeweleryId,
      required this.jeweleryName,
      required this.jeweleryPrice,
      required this.jeweleryDescription,
      required this.jeweleryCategory,
      this.jeweleryImage,
      required this.createdAt});
      
  // Empty constructor
  JeweleryApiModel.empty()
      : jeweleryId = '',
        jeweleryName = '',
        jeweleryPrice = 0,
        jeweleryDescription = '',
        jeweleryCategory = '',
        jeweleryImage = '',
        createdAt = '';
 
  //From Json, write full code without generator
  factory JeweleryApiModel.fromJson(Map<String, dynamic> json) {
    return JeweleryApiModel(
      jeweleryId: json['jeweleryId'],
      jeweleryName: json['jeweleryName'],
      jeweleryPrice: json['jeweleryPrice'],
      jeweleryDescription: json['jeweleryDescription'],
      jeweleryCategory: json['jeweleryCategory'],
      jeweleryImage: json['jeweleryImage'],
      createdAt: json['createdAt'],
    );
  }
 
  //toJson
 
  Map<String, dynamic> toJson() {
    return {
      'jeweleryId': jeweleryId,
      'jeweleryName': jeweleryName,
      'jeweleryPrice': jeweleryPrice,
      'jeweleryDescription':jeweleryDescription,
      'jeweleryCategory':jeweleryCategory,
      'jeweleryImage':jeweleryImage,
      'createAt': createdAt
    };
  }
 
  // Convert remote to entity
  JeweleryEntity toEntity() =>
      JeweleryEntity(jeweleryId: jeweleryId, jeweleryName:jeweleryName, jeweleryPrice: jeweleryPrice,jeweleryDescription: jeweleryDescription, jeweleryCategory: jeweleryCategory, jeweleryImage:jeweleryImage,createdAt: createdAt, buyCount: 0);
 
  //Convert entity to remote
  JeweleryApiModel fromEntity(JeweleryEntity entity) => JeweleryApiModel(
      jeweleryId: entity.jeweleryId, jeweleryName: entity.jeweleryName,jeweleryPrice: entity.jeweleryPrice, jeweleryDescription: entity.jeweleryDescription, jeweleryCategory: entity.jeweleryCategory, jeweleryImage: entity.jeweleryImage,  createdAt: entity.createdAt);
 
  // Convert remote list to entity list
  List<JeweleryEntity> toEntityList(List<JeweleryApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  fromJson(jewelery) {}
}