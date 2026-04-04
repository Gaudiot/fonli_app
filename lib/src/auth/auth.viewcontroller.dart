import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
import 'package:fonli_app/src/auth/auth.viewmodel.dart';

final class AuthViewController {
  final AuthViewModel viewModel = AuthViewModel();

  void toggleForm() {
    if (viewModel.isLoading) return;
    viewModel.isLogin = !viewModel.isLogin;
  }

  void submitSignUp(String username, String email, String password) async {
    viewModel.isLoading = true;

    final result = await FonliAuthServer.signUp(username, email, password);

    if (result.isError) {
      viewModel.isLoading = false;
      return;
    }

    await _saveTokens(result.data!.accessToken, result.data!.refreshToken);
    viewModel.isLoading = false;
    viewModel.isAuthenticated = true;
  }

  void submitLogin(String emailOrUsername, String password) async {
    viewModel.isLoading = true;

    final result = await FonliAuthServer.login(emailOrUsername, password);

    if (result.isError) {
      viewModel.isLoading = false;
      return;
    }

    await _saveTokens(result.data!.accessToken, result.data!.refreshToken);
    viewModel.isLoading = false;
    viewModel.isAuthenticated = true;
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await secureStorage.setString(SecureStorageKeys.accessToken, accessToken);
    await secureStorage.setString(SecureStorageKeys.refreshToken, refreshToken);
  }
}
