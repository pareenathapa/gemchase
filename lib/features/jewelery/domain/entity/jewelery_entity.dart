import 'package:equatable/equatable.dart';

class JeweleryEntity extends Equatable {
  final String? jeweleryId;
  final String jeweleryName;
  final int jeweleryPrice;
  final String jeweleryDescription;
  final String jeweleryCategory;
  final String? jeweleryImage;
  final String? createdAt;


  const JeweleryEntity({
    this.jeweleryId, 
    required this.jeweleryName,
    required this.jeweleryPrice, 
    required this.jeweleryDescription,
    required this.jeweleryCategory, 
    required this.jeweleryImage,
    required this.createdAt, 
  });

  @override
  List<Object?> get props => [jeweleryId,jeweleryName,jeweleryPrice,jeweleryDescription,jeweleryCategory,jeweleryImage,createdAt];
}



