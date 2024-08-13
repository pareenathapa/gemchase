import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(
    this.authUseCase,
  ) : super(AuthState.initial()) {}
  final AuthUseCase authUseCase;

  Future<void> getSavedUser({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isAdmin: false,
      isSuccess: false,
    );
    final result = await authUseCase.getSavedUser();
    log('getSavedUser: $result');
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isAdmin: false,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (loginEntity) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          isAdmin: loginEntity?.user?.isAdmin ?? false,
          error: () => null,
          loginEntity: () => loginEntity,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> register({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    File? image,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isAdmin: false,
      isSuccess: false,
    );
    final result = await authUseCase.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      image: image,
    );
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isAdmin: false,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          isAdmin: false,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> login({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isAdmin: false,
      isSuccess: false,
    );
    final result = await authUseCase.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isAdmin: false,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (loginEntity) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          isAdmin: loginEntity.user?.isAdmin ?? false,
          error: () => null,
          loginEntity: () => loginEntity,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> logout({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isAdmin: false,
      isSuccess: false,
    );
    final result = await authUseCase.logout();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isAdmin: false,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          isAdmin: false,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> getUserById({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String userId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.getUserById(userId: userId);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (userEntity) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          loginEntity: () =>
              userEntity, // assuming userEntity maps to loginEntity
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> updateUser({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    File? image,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.updateUser(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      image: image,
    );
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> deleteUser({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required String userId,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.deleteUser(userId: userId);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> checkFingerPrint({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.checkFingerprintLogin();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          allowFingerPrintLogin: true,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> saveFingerPrint({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
    required LoginEntity user,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.saveFingerprintLogin(user: user);
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          allowFingerPrintLogin: true,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> removeFingerprint({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isSuccess: false,
    );
    final result = await authUseCase.removeFingerprintLogin();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          error: () => null,
          allowFingerPrintLogin: false,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }

  Future<void> allowFingerprintLogin({
    void Function(String)? onError,
    void Function()? onSuccess,
    void Function()? navigation,
  }) async {
    state = state.copyWith(
      isLoading: true,
      error: () => null,
      isAdmin: false,
      isSuccess: false,
    );
    final result = await authUseCase.loginWithFingerprint();
    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: () => failure,
          isAdmin: false,
          isSuccess: false,
        );
        onError?.call(failure.error);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          isAdmin: false,
          error: () => null,
          loginEntity: () => success,
        );
        onSuccess?.call();
        navigation?.call();
      },
    );
  }
}
