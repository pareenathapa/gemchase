import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/auth/domain/entities/user_entity.dart';

class LoginEntity extends Equatable {
  final String? token;
  final UserEntity? user;

  const LoginEntity({
    this.token,
    this.user,
  });

  @override
  List<Object?> get props => [token, user];

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user': user?.toMap(),
    };
  }

  factory LoginEntity.fromMap(Map<String, dynamic> map) {
    return LoginEntity(
      token: map['token'],
      user: map['user'] != null ? UserEntity.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginEntity.fromJson(String source) =>
      LoginEntity.fromMap(json.decode(source));
}
