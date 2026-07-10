import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/src/auth/auth.viewmodel.dart';

final class AuthViewController {
  final AuthViewModel viewModel = AuthViewModel();

  void toggleForm() {
    if (viewModel.isLoading) return;
    viewModel.authErrorMessage = null;
    viewModel.isLogin = !viewModel.isLogin;
  }

  void submitSignUp(String username, String email, String password) async {
    viewModel.authErrorMessage = null;
    viewModel.isLoading = true;

    final result = await FonliAuthServer.signUp(username, email, password);

    if (result.isError) {
      viewModel.isLoading = false;
      viewModel.reportAuthError(_messageFromAuthError(result.error!));
      return;
    }

    await AuthSessionNotifier.instance.saveTokens(
      accessToken: result.data!.accessToken,
      refreshToken: result.data!.refreshToken,
    );
    viewModel.isLoading = false;
    viewModel.isAuthenticated = true;
  }

  void submitLogin(String emailOrUsername, String password) async {
    viewModel.authErrorMessage = null;
    viewModel.isLoading = true;

    final result = await FonliAuthServer.login(emailOrUsername, password);

    if (result.isError) {
      viewModel.isLoading = false;
      viewModel.reportAuthError(_messageFromAuthError(result.error!));
      return;
    }

    await AuthSessionNotifier.instance.saveTokens(
      accessToken: result.data!.accessToken,
      refreshToken: result.data!.refreshToken,
    );
    viewModel.isLoading = false;
    viewModel.isAuthenticated = true;
  }

  String _messageFromAuthError(Object error) {
    final s = error.toString();
    const prefix = 'Exception: ';
    if (s.startsWith(prefix)) {
      return s.substring(prefix.length);
    }
    return s;
  }
}
