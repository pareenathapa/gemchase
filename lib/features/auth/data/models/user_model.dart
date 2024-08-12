import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:gemchase_clean_arch/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.firstName,
    super.lastName,
    super.phone,
    super.email,
    super.isAdmin = false,
  });

  UserModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? firstName,
    ValueGetter<String?>? lastName,
    ValueGetter<String?>? phone,
    ValueGetter<String?>? email,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id != null ? id() : this.id,
      firstName: firstName != null ? firstName() : this.firstName,
      lastName: lastName != null ? lastName() : this.lastName,
      phone: phone != null ? phone() : this.phone,
      email: email != null ? email() : this.email,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      email: map['email'],
      isAdmin: map['isAdmin'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, phone: $phone, email: $email, isAdmin: $isAdmin)';
  }
}
