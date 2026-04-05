import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/snackbar/snackbar.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/components/ui/text_input.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/auth/auth.viewcontroller.dart';

part 'auth.components.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthViewController viewController = AuthViewController();

  @override
  void initState() {
    super.initState();
    viewController.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    viewController.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    final vm = viewController.viewModel;

    final err = vm.authErrorMessage;
    if (err != null && mounted) {
      vm.clearAuthError();
      snackbarMessenger.showError(context, err);
    }

    if (vm.isAuthenticated && mounted) {
      NavigationManager.replaceWith(
        context,
        NavigationRoutes.exerciseSelection,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [FColors.secondary, FColors.primary],
          ),
        ),
        child: Center(
          child: ListenableBuilder(
            listenable: viewController.viewModel,
            builder: (context, _) {
              final vm = viewController.viewModel;

              return vm.isLogin
                  ? _LoginForm(
                      onSignUpTap: viewController.toggleForm,
                      onSubmit: viewController.submitLogin,
                      isLoading: vm.isLoading,
                    )
                  : _SignUpForm(
                      onLogInTap: viewController.toggleForm,
                      onSubmit: viewController.submitSignUp,
                      isLoading: vm.isLoading,
                    );
            },
          ),
        ),
      ),
    );
  }
}
