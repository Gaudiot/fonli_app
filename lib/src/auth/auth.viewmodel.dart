import 'package:fonli_app/core/components/base_viewstate.dart';

final class AuthViewModel extends BaseViewState {
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  set isAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  /// Set when login/signup fails; consumed by the view to show the app snackbar.
  String? authErrorMessage;

  void clearAuthError() {
    if (authErrorMessage == null) return;
    authErrorMessage = null;
    notifyListeners();
  }

  void reportAuthError(String message) {
    authErrorMessage = message;
    notifyListeners();
  }
}
