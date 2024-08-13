import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:convert';

import 'package:flutter/widgets.dart';


class AuthState {
  final bool isLoading;
  final bool isSuccess;
  final bool isAdmin;
  final Failure? error;

  final LoginEntity? loginEntity;
  final bool allowFingerPrintLogin;
  AuthState({
    required this.isLoading,
    required this.isSuccess,
    required this.isAdmin,
    this.error,
    this.loginEntity,
    required this.allowFingerPrintLogin,
  });

  AuthState.initial()
      : isLoading = false,
        isSuccess = false,
        isAdmin = false,
        error = null,
        allowFingerPrintLogin = false,
        loginEntity = null;

  AuthState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isAdmin,
    ValueGetter<Failure?>? error,
    ValueGetter<LoginEntity?>? loginEntity,
    bool? allowFingerPrintLogin,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isAdmin: isAdmin ?? this.isAdmin,
      error: error != null ? error() : this.error,
      loginEntity: loginEntity != null ? loginEntity() : this.loginEntity,
      allowFingerPrintLogin:
          allowFingerPrintLogin ?? this.allowFingerPrintLogin,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isSuccess: $isSuccess, isAdmin: $isAdmin, error: $error, loginEntity: $loginEntity, allowFingerPrintLogin: $allowFingerPrintLogin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.isAdmin == isAdmin &&
        other.error == error &&
        other.loginEntity == loginEntity &&
        other.allowFingerPrintLogin == allowFingerPrintLogin;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        isAdmin.hashCode ^
        error.hashCode ^
        loginEntity.hashCode ^
        allowFingerPrintLogin.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'is_loading': isLoading,
      'is_success': isSuccess,
      'is_admin': isAdmin,
      'error': error?.toMap(),
      'login_entity': loginEntity?.toMap(),
      'allow_finger_print_login': allowFingerPrintLogin,
    };
  }

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      isLoading: map['is_loading'] ?? false,
      isSuccess: map['is_success'] ?? false,
      isAdmin: map['is_admin'] ?? false,
      error: map['error'] != null ? Failure.fromMap(map['error']) : null,
      loginEntity: map['login_entity'] != null
          ? LoginEntity.fromMap(map['login_entity'])
          : null,
      allowFingerPrintLogin: map['allow_finger_print_login'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthState.fromJson(String source) =>
      AuthState.fromMap(json.decode(source));
}
