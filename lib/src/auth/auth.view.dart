import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/components/ui/if_else_widget.component.dart';
import 'package:fonli_app/core/components/ui/text_input.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/auth/auth.viewcontroller.dart';
import 'package:fonli_app/src/auth/auth.viewmodel.dart';

part 'auth.components.dart';

class AuthView extends StatelessWidget {
  final AuthViewController viewController;

  const AuthView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<AuthViewModel, AuthViewController>(
      viewController: viewController,
      builder: (context, data) {
        return Container(
          color: FColors.primary,
          child: SafeArea(
            child: Center(
              child: IfElseWidget(
                condition: data.isLogin,
                ifChild: (_) => _LoginForm(
                  isLoading: data.isLoading,
                  emailOrUsernameController:
                      viewController.loginIdentifierController,
                  passwordController: viewController.loginPasswordController,
                  onSignUpTap: viewController.onToggleFormPressed,
                  onSubmit: () => viewController.onLoginSubmit(context),
                ),
                elseChild: (_) => _SignUpForm(
                  isLoading: data.isLoading,
                  usernameController: viewController.signUpUsernameController,
                  emailController: viewController.signUpEmailController,
                  passwordController: viewController.signUpPasswordController,
                  onLogInTap: viewController.onToggleFormPressed,
                  onSubmit: () => viewController.onSignUpSubmit(context),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
