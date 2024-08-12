import 'package:gemchase_clean_arch/core/common/exports.dart';

import 'package:flutter/widgets.dart';


class AuthState {
  final bool isLoading;
  final bool isSuccess;
  final bool isAdmin;
  final Failure? error;

  final LoginEntity? loginEntity;
  AuthState({
    required this.isLoading,
    required this.isSuccess,
    required this.isAdmin,
    this.error,
    this.loginEntity,
  });

  AuthState.initial()
      : isLoading = false,
        isSuccess = false,
        isAdmin = false,
        error = null,
        loginEntity = null;

  AuthState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isAdmin,
    ValueGetter<Failure?>? error,
    ValueGetter<LoginEntity?>? loginEntity,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isAdmin: isAdmin ?? this.isAdmin,
      error: error != null ? error() : this.error,
      loginEntity: loginEntity != null ? loginEntity() : this.loginEntity,
    );
  }

  @override
  String toString() {
    return 'AuthState(isLoading: $isLoading, isSuccess: $isSuccess, isAdmin: $isAdmin, error: $error, loginEntity: $loginEntity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isSuccess == isSuccess &&
        other.isAdmin == isAdmin &&
        other.error == error &&
        other.loginEntity == loginEntity;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        isSuccess.hashCode ^
        isAdmin.hashCode ^
        error.hashCode ^
        loginEntity.hashCode;
  }
}
