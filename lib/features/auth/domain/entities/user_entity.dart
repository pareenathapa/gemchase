import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final bool isAdmin;
  final String? image;

  const UserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.isAdmin = false,
    this.image,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, phone, email];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'isAdmin': isAdmin,
      'image': image,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      isAdmin: map['isAdmin'] ?? false,
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, isAdmin: $isAdmin, image: $image)';
  }
}
