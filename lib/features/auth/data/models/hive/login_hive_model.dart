import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

part 'login_hive_model.g.dart';

final loginHiveModelProvider = Provider(
  (ref) => LoginHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.loginTableId)
class LoginHiveModel {
  @HiveField(0)
  final String? token;
  @HiveField(1)
  final UserHiveModel? user;

  const LoginHiveModel({
    this.token,
    this.user,
  });

  LoginHiveModel.empty()
      : this(
          token: '',
          user: UserHiveModel.empty(),
        );

  LoginHiveModel copyWith({
    ValueGetter<String?>? token,
    ValueGetter<UserHiveModel?>? user,
  }) {
    return LoginHiveModel(
      token: token != null ? token() : this.token,
      user: user != null ? user() : this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'data': user?.toMap(),
    };
  }

  factory LoginHiveModel.fromMap(Map<String, dynamic> map) {
    return LoginHiveModel(
      token: map['token'],
      user: map['data'] != null ? UserHiveModel.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginHiveModel.fromJson(String source) =>
      LoginHiveModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginHiveModel(token: $token, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginHiveModel &&
        other.token == token &&
        other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ user.hashCode;
}
