part of 'fonli_server.dart';

const String _kRefreshAttemptedExtraKey = 'fonli_refresh_attempted';

/// [Dio] configured for Fonli API calls. Adds `Authorization: Bearer <accessToken>`
/// when a non-empty access token exists. On **401**, attempts a token refresh
/// (deduplicated), saves new tokens, then retries the request once.
Future<Dio> _fonliDio() async {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await secureStorage.getString(
          SecureStorageKeys.accessToken,
        );
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException err, ErrorInterceptorHandler handler) async {
        if (err.response?.statusCode != 401) {
          return handler.next(err);
        }
        if (err.requestOptions.extra[_kRefreshAttemptedExtraKey] == true) {
          return handler.next(err);
        }
        if (_isAuthPathWithoutRefreshRetry(err.requestOptions.uri)) {
          return handler.next(err);
        }

        final refreshed = await _refreshAccessToken();
        if (!refreshed) {
          return handler.next(err);
        }

        try {
          final opts = err.requestOptions;
          opts.extra[_kRefreshAttemptedExtraKey] = true;
          final token = await secureStorage.getString(
            SecureStorageKeys.accessToken,
          );
          if (token != null && token.isNotEmpty) {
            opts.headers['Authorization'] = 'Bearer $token';
          }
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } on DioException catch (retryErr) {
          return handler.next(retryErr);
        } catch (_) {
          return handler.next(err);
        }
      },
    ),
  );
  return dio;
}

bool _isAuthPathWithoutRefreshRetry(Uri uri) {
  final path = uri.path;
  return path.contains('/auth/login') ||
      path.contains('/auth/signup') ||
      path.contains('/auth/refresh');
}

Future<bool>? _activeRefreshFuture;

Future<bool> _refreshAccessToken() async {
  final existing = _activeRefreshFuture;
  if (existing != null) {
    return existing;
  }
  final future = _performRefresh();
  _activeRefreshFuture = future;
  try {
    return await future;
  } finally {
    _activeRefreshFuture = null;
  }
}

Future<bool> _performRefresh() async {
  try {
    final refreshToken = await secureStorage.getString(
      SecureStorageKeys.refreshToken,
    );
    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    final plainDio = Dio();
    final response = await plainDio.post<Map<String, dynamic>>(
      '$baseUrl/auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    if (response.statusCode != 200 || response.data == null) {
      return false;
    }

    final data = RefreshResponse.fromJson(response.data!);
    await secureStorage.setString(
      SecureStorageKeys.accessToken,
      data.accessToken,
    );
    await secureStorage.setString(
      SecureStorageKeys.refreshToken,
      data.refreshToken,
    );
    return true;
  } catch (_) {
    return false;
  }
}
