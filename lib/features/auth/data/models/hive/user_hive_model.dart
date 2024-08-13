import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:gemchase_clean_arch/app/constants/hive_table_constant.dart';

part 'user_hive_model.g.dart';

final userHiveModelProvider = Provider(
  (ref) => UserHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? email;
  @HiveField(5)
  final bool isAdmin;
  @HiveField(6)
  final String? image;

  const UserHiveModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.isAdmin = false,
    this.image,
  });

  UserHiveModel.empty()
      : this(
          id: '',
          firstName: '',
          lastName: '',
          phone: '',
          email: '',
          isAdmin: false,
          image: '',
        );

  UserHiveModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? phone,
    ValueGetter<String?>? email,
    bool? isAdmin,
    ValueGetter<String?>? image,
  }) {
    return UserHiveModel(
      id: id != null ? id() : this.id,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      phone: phone != null ? phone() : this.phone,
      email: email != null ? email() : this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      image: image != null ? image() : this.image,
    );
  }

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

  factory UserHiveModel.fromMap(Map<String, dynamic> map) {
    return UserHiveModel(
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

  factory UserHiveModel.fromJson(String source) =>
      UserHiveModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserHiveModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, isAdmin: $isAdmin, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserHiveModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.email == email &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        isAdmin.hashCode;
  }
}
