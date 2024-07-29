import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/my_snackbar.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/entity/auth_entity.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/navigator/login_navigator.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/state/auth_state.dart';



final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(
    this.navigator,
    this.authUseCase,
  ) : super(AuthState.initial());
  final AuthUseCase authUseCase;
  final LoginViewNavigator navigator;

  // Future<void> uploadImage(File? file) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await authUseCase.uploadProfilePicture(file!);
  //   data.fold(
  //     (l) {
  //       state = state.copyWith(isLoading: false, error: l.error);
  //     },
  //     (imageName) {
  //       state =
  //           state.copyWith(isLoading: false, error: null, imageName: imageName);
  //     },
  //   );
  // }

  Future<void> register(AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.register(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  login(
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.login(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print('you are failure');
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        print('you are success:');
        openHomeView();
        // showMySnackBar(message: "Successfully logged in!");
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  void openHomeView() {
    print('you are navigating');
    navigator.openDashboardView();
  }
// void openHomeView() {
//   navigator.openHomeView();
// }
}