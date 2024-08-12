import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(
    this.authUseCase,
  ) : super(AuthState.initial());
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
}
