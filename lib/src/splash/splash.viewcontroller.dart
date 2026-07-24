import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/splash/splash.viewmodel.dart';

final class SplashViewController {
  final SplashViewModel viewModel = SplashViewModel();

  void onInit(BuildContext context) async {
    final isAuthenticated = await _hasUserAuthenticatedBefore();

    if (!context.mounted) return;

    isAuthenticated
        ? _navigateToExerciseSelection(context)
        : _navigateToAuth(context);
  }

  Future<bool> _hasUserAuthenticatedBefore() async {
    final accessToken = await AuthSessionNotifier.instance.getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }

  void _navigateToAuth(BuildContext context) {
    NavigationManager.replaceWith(context, NavigationRoutes.auth);
  }

  void _navigateToExerciseSelection(BuildContext context) async {
    final isOnboarded = await localStorage.getBooleanWithDefault(
      LocalStorageKeys.onboarded,
      false,
    );
    if (context.mounted) {
      if (!isOnboarded) {
        NavigationManager.replaceWith(context, NavigationRoutes.onboarding);
        return;
      }
      NavigationManager.replaceWith(
        context,
        NavigationRoutes.exerciseSelection,
      );
    }
  }
}
