import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';

enum AuthState { unknown, authenticated, unauthenticated }

class AuthSessionNotifier extends ChangeNotifier {
  AuthState _state = .unknown;
  AuthState get state => _state;

  AuthSessionNotifier._() {
    _init();
  }

  static final AuthSessionNotifier _instance = AuthSessionNotifier._();

  static AuthSessionNotifier get instance => _instance;

  bool get isAuthenticated => _state == AuthState.authenticated;

  Future<void> _init() async {
    final accessToken = await secureStorage.getString(.accessToken);
    final AuthState authState = (accessToken != null && accessToken.isNotEmpty)
        ? .authenticated
        : .unauthenticated;

    _setState(authState);
  }

  Future<String?> getAccessToken() async {
    return secureStorage.getString(.accessToken);
  }

  Future<String?> getRefreshToken() async {
    return secureStorage.getString(.refreshToken);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await secureStorage.setString(.accessToken, accessToken);
    await secureStorage.setString(.refreshToken, refreshToken);
  }

  Future<void> clear() async {
    await secureStorage.deleteKey(.accessToken);
    await secureStorage.deleteKey(.refreshToken);
    _setState(AuthState.unauthenticated);
  }

  void _setState(AuthState next) {
    if (_state == next) return;
    _state = next;
    notifyListeners();
  }
}
