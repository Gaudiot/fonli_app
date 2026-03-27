import 'package:flutter/material.dart';
import 'package:fonli_app/base/http/fonli/fonli_auth_server.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';

final class SplashViewModel {
  void onInit(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    final isAuthenticated = await _isUserAuthenticated();

    if (!context.mounted) return;

    isAuthenticated
        ? _navigateToExerciseSelection(context)
        : _navigateToAuth(context);
  }

  Future<bool> _isUserAuthenticated() async {
    final refreshToken = await _getStoredRefreshToken();
    if (refreshToken == null) return false;

    final result = await FonliAuthServer.refresh(refreshToken);
    if (result.isError || result.data == null) return false;

    await _saveTokens(result.data!.accessToken, result.data!.refreshToken);
    return true;
  }

  Future<String?> _getStoredRefreshToken() {
    return secureStorage.getString(SecureStorageKeys.refreshToken);
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await secureStorage.setString(SecureStorageKeys.accessToken, accessToken);
    await secureStorage.setString(SecureStorageKeys.refreshToken, refreshToken);
  }

  void _navigateToAuth(BuildContext context) {
    NavigationManager.replaceWith(context, NavigationRoutes.auth);
  }

  void _navigateToExerciseSelection(BuildContext context) {
    NavigationManager.replaceWith(context, NavigationRoutes.exerciseSelection);
  }
}
