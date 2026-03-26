import 'package:fonli_app/base/http/fonli/fonli_auth_server.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
import 'package:fonli_app/src/auth/auth.viewstate.dart';

final class AuthViewModel {
  final AuthViewState state = AuthViewState();

  void toggleForm() {
    if (state.isLoading) return;
    state.isLogin = !state.isLogin;
  }

  void submitSignUp(String username, String email, String password) async {
    state.isLoading = true;

    final result = await FonliAuthServer.signUp(username, email, password);

    if (result.isError) {
      state.isLoading = false;
      return;
    }

    await _saveTokens(result.data!.accessToken, result.data!.refreshToken);
    state.isAuthenticated = true;
  }

  void submitLogin(String emailOrUsername, String password) async {
    state.isLoading = true;

    final result = await FonliAuthServer.login(emailOrUsername, password);

    if (result.isError) {
      state.isLoading = false;
      return;
    }

    await _saveTokens(result.data!.accessToken, result.data!.refreshToken);
    state.isAuthenticated = true;
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await secureStorage.setString(
      SecureStorageKeys.accessToken,
      accessToken,
    );
    await secureStorage.setString(
      SecureStorageKeys.refreshToken,
      refreshToken,
    );
  }
}
