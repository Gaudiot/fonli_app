import 'package:flutter/material.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/components/snackbar/snackbar_messenger.interface.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/auth/auth.viewmodel.dart';

final class AuthViewController extends FViewController<AuthViewModel> {
  final SnackbarMessenger snackbarMessenger;

  final TextEditingController loginIdentifierController =
      TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController signUpUsernameController =
      TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
      TextEditingController();

  AuthViewController({
    required super.viewModel,
    required this.snackbarMessenger,
  });

  @override
  void dispose() {
    loginIdentifierController.dispose();
    loginPasswordController.dispose();
    signUpUsernameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    super.dispose();
  }

  void onToggleFormPressed() {
    if (value.isLoading) return;
    clearFormFields();
    value = value.copyWith(isLogin: !value.isLogin);
  }

  Future<void> onLoginSubmit(BuildContext context) async {
    if (value.isLoading) return;
    value = value.copyWith(isLoading: true);

    final result = await FonliAuthServer.login(
      loginIdentifierController.text,
      loginPasswordController.text,
    );

    value = value.copyWith(isLoading: false);

    if (result.isError) {
      if (context.mounted) {
        snackbarMessenger.showError(context, messageFromError(result.error!));
      }
      return;
    }

    await AuthSessionNotifier.instance.saveTokens(
      accessToken: result.data!.accessToken,
      refreshToken: result.data!.refreshToken,
    );

    if (context.mounted) await onFormSubmitted(context);
  }

  Future<void> onSignUpSubmit(BuildContext context) async {
    if (value.isLoading) return;
    value = value.copyWith(isLoading: true);

    final result = await FonliAuthServer.signUp(
      signUpUsernameController.text,
      signUpEmailController.text,
      signUpPasswordController.text,
    );

    value = value.copyWith(isLoading: false);

    if (result.isError) {
      if (context.mounted) {
        snackbarMessenger.showError(context, messageFromError(result.error!));
      }
      return;
    }

    await AuthSessionNotifier.instance.saveTokens(
      accessToken: result.data!.accessToken,
      refreshToken: result.data!.refreshToken,
    );

    if (context.mounted) await onFormSubmitted(context);
  }
}

// MARK: - Private Methods

extension on AuthViewController {
  Future<bool> checkIfUserHasCompletedOnboarding() async {
    final hasCompletedOnboarding = await localStorage.getBooleanWithDefault(
      .onboarded,
      false,
    );
    return hasCompletedOnboarding;
  }

  Future<void> onFormSubmitted(BuildContext context) async {
    final hasCompletedOnboarding = await checkIfUserHasCompletedOnboarding();
    if (hasCompletedOnboarding) {
      if (context.mounted) routeToHome(context);
    } else {
      if (context.mounted) routeToOnboarding(context);
    }
  }

  void clearFormFields() {
    loginIdentifierController.clear();
    loginPasswordController.clear();
    signUpUsernameController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();
  }

  String messageFromError(Object error) {
    const prefix = 'Exception: ';
    final message = error.toString();
    if (message.startsWith(prefix)) {
      return message.substring(prefix.length);
    }
    return message;
  }
}

// MARK: - Routing Methods

extension on AuthViewController {
  void routeToOnboarding(BuildContext context) {
    NavigationManager.pushNamedAndRemoveAll(context, .onboarding);
  }

  void routeToHome(BuildContext context) {
    NavigationManager.replaceWith(context, .exerciseSelection);
  }
}
