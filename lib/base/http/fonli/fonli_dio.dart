part of 'fonli_server.dart';

/// [Dio] configured for Fonli API calls. Adds `Authorization: Bearer <accessToken>`
/// when a non-empty access token exists in secure storage.
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
    ),
  );
  return dio;
}
