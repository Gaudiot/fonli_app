import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/snackbar/snackbar_messenger.interface.dart';
import 'package:fonli_app/src/auth/auth.view.dart';
import 'package:fonli_app/src/auth/auth.viewcontroller.dart';
import 'package:fonli_app/src/auth/auth.viewmodel.dart';

class AuthBuilder extends FViewBuilder {
  final SnackbarMessenger snackbarMessenger;

  const AuthBuilder({required this.snackbarMessenger});

  @override
  Widget build() {
    final viewModel = AuthViewModel();
    final viewController = AuthViewController(
      viewModel: viewModel,
      snackbarMessenger: snackbarMessenger,
    );

    return AuthView(viewController: viewController);
  }
}
