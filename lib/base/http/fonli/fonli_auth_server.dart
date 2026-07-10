part of 'fonli_server.dart';

class FonliAuthServer {
  FonliAuthServer._();

  static Future<Result<SignUpResponse, Exception>> signUp(
    String username,
    String email,
    String password,
  ) async {
    final fonliApi = FonliApi.instance;
    try {
      final response = await fonliApi.post(
        '/auth/signup',
        data: {'username': username, 'email': email, 'password': password},
      );
      final data = SignUpResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final response = e.response!;
        return Result.error(Exception(response.data['error']));
      }
      return Result.error(Exception("Failed to sign up. Try again later."));
    }
  }

  static Future<Result<LoginResponse, Exception>> login(
    String emailOrUsername,
    String password,
  ) async {
    final fonliApi = FonliApi.instance;
    try {
      final response = await fonliApi.post(
        '/auth/login',
        data: {'email_or_username': emailOrUsername, 'password': password},
      );
      final data = LoginResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final response = e.response!;
        return Result.error(Exception(response.data['error']));
      }
      return Result.error(Exception("Failed to login. Try again later."));
    }
  }

  static Future<Result<RefreshResponse, Exception>> refresh(
    String refreshToken,
  ) async {
    try {
      final fonliApi = FonliApi.instance;
      final response = await fonliApi.post(
        '/auth/refresh',
        data: RefreshRequest(refreshToken: refreshToken).toJson(),
      );
      if (response.statusCode != 200 || response.data == null) {
        return Result.error(Exception('Refresh failed'));
      }
      final data = RefreshResponse.fromJson(response.data!);

      return Result.ok(data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final response = e.response!;
        return Result.error(Exception(response.data['error']));
      }
      return Result.error(Exception("Failed to refresh. Try again later."));
    }
  }

  static Future<Result<void, Exception>> logout() async {
    final fonliApi = FonliApi.instance;
    try {
      await fonliApi.post('/auth/logout');
      return Result.ok(null);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final response = e.response!;
        return Result.error(Exception(response.data['error']));
      }
      return Result.error(Exception("Failed to logout. Try again later."));
    }
  }
}
