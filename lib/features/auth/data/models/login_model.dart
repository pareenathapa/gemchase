import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    super.token,
    super.user,
  });

  LoginModel copyWith({
    ValueGetter<String?>? token,
    ValueGetter<UserModel?>? user,
  }) {
    return LoginModel(
      token: token != null ? token() : this.token,
      user: user != null ? user() : this.user,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'data': (user as UserModel).toMap(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map['token'],
      user: map['data'] != null ? UserModel.fromMap(map['data']) : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source));

  @override
  String toString() => 'LoginModel(token: $token, user: $user)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel && other.token == token && other.user == user;
  }

  @override
  int get hashCode => token.hashCode ^ user.hashCode;
}
