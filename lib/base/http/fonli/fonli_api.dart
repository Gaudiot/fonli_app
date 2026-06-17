part of 'fonli_server.dart';

class FonliPaths {
  FonliPaths._();

  static String userLifestyle = "/user/lifestyle";
}

class FonliApi {
  late final Dio dio;
  bool isInitialized = false;
  final logger = LogImpl(name: "FonliApi");

  // singleton instance
  static final FonliApi _instance = FonliApi._();

  FonliApi._();

  static Dio get instace {
    if (!_instance.isInitialized) {
      _instance.isInitialized = true;
      _instance.dio = Dio(BaseOptions(baseUrl: "https://gaudiot.com"));
      _instance.addInterceptors();
    }
    return _instance.dio;
  }

  void addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequestInterceptor,
        onResponse: _onResponseInterceptor,
        onError: _onErrorInterceptor,
      ),
    );
  }
}

// MARK: - Interceptors
extension on FonliApi {
  void _onRequestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await secureStorage.getString(.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  void _onResponseInterceptor(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final logMetadata = _getInfoLogMetadata(response);
    logger.info(logMetadata);
    handler.next(response);
  }

  void _onErrorInterceptor(DioException err, ErrorInterceptorHandler handler) {
    final errorMetadata = _getErrorLogMetadata(err);
    logger.error(errorMetadata);
    if (_isRequestAuthRetryable(err)) {
      _refreshUserSession();
    }
    handler.next(err);
  }

  bool _isRequestAuthRetryable(DioException err) {
    if (err.response?.statusCode != 401) return false;
    return true;
  }
}

// MARK: - Session refresh
extension on FonliApi {
  void _refreshUserSession() {
    // TODO - Implement refresh auth
    throw Exception("Not Implemented");
  }
}

// MARK: - Metadata Generator
extension on FonliApi {
  FonliServerLogMetadata _getInfoLogMetadata(Response response) {
    return FonliServerLogMetadata(
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode ?? 0,
    );
  }

  FonliServerLogMetadata _getErrorLogMetadata(DioException err) {
    return FonliServerLogMetadata(
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode ?? 0,
    );
  }
}

// const String _kRefreshAttemptedExtraKey = 'fonli_refresh_attempted';

// /// [Dio] configured for Fonli API calls. Adds `Authorization: Bearer <accessToken>`
// /// when a non-empty access token exists. On **401**, attempts a token refresh
// /// (deduplicated), saves new tokens, then retries the request once.
// Future<Dio> _fonliDio() async {
//   final dio = Dio();
//   dio.interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         final token = await secureStorage.getString(
//           SecureStorageKeys.accessToken,
//         );
//         if (token != null && token.isNotEmpty) {
//           options.headers['Authorization'] = 'Bearer $token';
//         }
//         handler.next(options);
//       },
//       onError: (DioException err, ErrorInterceptorHandler handler) async {
//         if (err.response?.statusCode != 401) {
//           return handler.next(err);
//         }
//         if (err.requestOptions.extra[_kRefreshAttemptedExtraKey] == true) {
//           return handler.next(err);
//         }
//         if (_isAuthPathWithoutRefreshRetry(err.requestOptions.uri)) {
//           return handler.next(err);
//         }

//         final refreshed = await _refreshAccessToken();
//         if (!refreshed) {
//           return handler.next(err);
//         }

//         try {
//           final opts = err.requestOptions;
//           opts.extra[_kRefreshAttemptedExtraKey] = true;
//           final token = await secureStorage.getString(
//             SecureStorageKeys.accessToken,
//           );
//           if (token != null && token.isNotEmpty) {
//             opts.headers['Authorization'] = 'Bearer $token';
//           }
//           final response = await dio.fetch(opts);
//           return handler.resolve(response);
//         } on DioException catch (retryErr) {
//           return handler.next(retryErr);
//         } catch (_) {
//           return handler.next(err);
//         }
//       },
//     ),
//   );
//   return dio;
// }

// bool _isAuthPathWithoutRefreshRetry(Uri uri) {
//   final path = uri.path;
//   return path.contains('/auth/login') ||
//       path.contains('/auth/signup') ||
//       path.contains('/auth/refresh');
// }

// Future<bool>? _activeRefreshFuture;

// Future<bool> _refreshAccessToken() async {
//   final existing = _activeRefreshFuture;
//   if (existing != null) {
//     return existing;
//   }
//   final future = _performRefresh();
//   _activeRefreshFuture = future;
//   try {
//     return await future;
//   } finally {
//     _activeRefreshFuture = null;
//   }
// }

// Future<bool> _performRefresh() async {
//   try {
//     final refreshToken = await secureStorage.getString(
//       SecureStorageKeys.refreshToken,
//     );
//     if (refreshToken == null || refreshToken.isEmpty) {
//       return false;
//     }

//     final plainDio = Dio();
//     final response = await plainDio.post<Map<String, dynamic>>(
//       '$baseUrl/auth/refresh',
//       data: {'refresh_token': refreshToken},
//     );

//     if (response.statusCode != 200 || response.data == null) {
//       return false;
//     }

//     final data = RefreshResponse.fromJson(response.data!);
//     await secureStorage.setString(
//       SecureStorageKeys.accessToken,
//       data.accessToken,
//     );
//     await secureStorage.setString(
//       SecureStorageKeys.refreshToken,
//       data.refreshToken,
//     );
//     return true;
//   } catch (_) {
//     return false;
//   }
// }
