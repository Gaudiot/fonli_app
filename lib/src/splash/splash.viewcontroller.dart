import 'package:flutter/material.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
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
    final accessToken = await _getAccessToken();
    if (accessToken == null) return false;

    return true;
  }

  Future<String?> _getAccessToken() {
    return secureStorage.getString(.accessToken);
  }

  void _navigateToAuth(BuildContext context) {
    NavigationManager.replaceWith(context, NavigationRoutes.auth);
  }

  void _navigateToExerciseSelection(BuildContext context) {
    NavigationManager.replaceWith(context, NavigationRoutes.exerciseSelection);
  }
}
