import 'package:fonli_app/src/exercises/word_translation/word_translation.viewstate.dart';

final class AuthViewState extends BaseViewState {
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
}
