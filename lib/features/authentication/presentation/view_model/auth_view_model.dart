
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/my_snackbar.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../navigator/login_navigator.dart';
import '../state/auth_state.dart';



final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(loginViewNavigatorProvider),
    ref.read(authUseCaseProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.navigator, this.authUseCase) : super(AuthState.initial());
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
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        //openHomeView();
        showMySnackBar(message: "Successfully logged in!");
      },
    );
  }

  void openRegisterView() {
    navigator.openRegisterView();
  }

  // void openHomeView() {
  //   navigator.openHomeView();
  // }
}