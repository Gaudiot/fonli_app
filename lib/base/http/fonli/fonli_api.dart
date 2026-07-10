part of 'fonli_server.dart';

class FonliPaths {
  FonliPaths._();

  static String userLifestyle = "/user/lifestyle";
}

const String _refreshAttemptedExtraKey = 'fonli_refresh_attempted';

class FonliApi {
  late final Dio dio;
  bool isInitialized = false;
  final logger = LogImpl(name: "FonliApi");

  // Refresh data
  Future<bool>? _activeRefreshFuture;

  // singleton instance
  static final FonliApi _instance = FonliApi._();

  FonliApi._();

  static Dio get instace {
    if (!_instance.isInitialized) {
      _instance.isInitialized = true;
      _instance.dio = Dio(BaseOptions(baseUrl: "https://fonli.gaudiot.com"));
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

  Future<void> _onErrorInterceptor(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logger.error(_getErrorLogMetadata(err));
    if (!_isRequestAuthRetryable(err)) return handler.next(err);

    final refreshed = await _refreshUserSession();
    if (!refreshed) return handler.next(err);

    try {
      final opts = err.requestOptions;
      opts.extra[_refreshAttemptedExtraKey] = true;
      final newToken = await secureStorage.getString(.accessToken);
      if (newToken != null && newToken.isNotEmpty) {
        opts.headers['Authorization'] = 'Bearer $newToken';
      }
      final response = await dio.fetch(opts);
      return handler.resolve(response);
    } on DioException catch (retryErr) {
      return handler.next(retryErr);
    } catch (_) {
      return handler.next(err);
    }
  }
}

// MARK: - Session refresh
extension on FonliApi {
  bool _isRequestAuthRetryable(DioException err) {
    if (err.response?.statusCode != 401) return false;
    if (err.requestOptions.extra[_refreshAttemptedExtraKey] == true) {
      return false;
    }
    final path = err.requestOptions.uri.path;
    if (path.startsWith('/auth/')) return false;

    return true;
  }

  Future<bool> _refreshUserSession() async {
    final existing = _activeRefreshFuture;
    if (existing != null) return existing;

    final future = _performRefresh();
    _activeRefreshFuture = future;
    return future.whenComplete(() => _activeRefreshFuture = null);
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await secureStorage.getString(.refreshToken);
    if (refreshToken == null || refreshToken.isEmpty) return false;

    final result = await FonliAuthServer.refresh(refreshToken);
    if (result.isError) return false;

    final data = result.data;
    if (data == null) return false;

    Future.wait([
      secureStorage.setString(.accessToken, data.accessToken),
      secureStorage.setString(.refreshToken, data.refreshToken),
    ]);

    return true;
  }
}

// MARK: - Metadata Generator
extension on FonliApi {
  FonliServerLogMetadata _getInfoLogMetadata(Response response) {
    return FonliServerLogMetadata(
      method: response.requestOptions.method,
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode ?? 0,
    );
  }

  FonliServerLogMetadata _getErrorLogMetadata(DioException err) {
    return FonliServerLogMetadata(
      method: err.requestOptions.method,
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode ?? 0,
    );
  }
}
