part of 'fonli_server.dart';

class FonliAuthServer {
  static const String baseUrl = "http://localhost:8000";

  FonliAuthServer._();

  static Future<Result<SignUpResponse, Exception>> signUp(
    String username,
    String email,
    String password,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.post(
        '$baseUrl/auth/signup',
        data: {'username': username, 'email': email, 'password': password},
      );
      final data = SignUpResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<LoginResponse, Exception>> login(
    String emailOrUsername,
    String password,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: {'email_or_username': emailOrUsername, 'password': password},
      );
      final data = LoginResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<RefreshResponse, Exception>> refresh(
    String refreshToken,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.post(
        '$baseUrl/auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final data = RefreshResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
