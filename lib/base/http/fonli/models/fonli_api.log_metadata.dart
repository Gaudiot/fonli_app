part of '../fonli_server.dart';

class FonliServerLogMetadata implements LoggableMetadata {
  final String method;
  final String url;
  final int statusCode;

  FonliServerLogMetadata({
    required this.method,
    required this.url,
    required this.statusCode,
  });

  @override
  String toLogString() {
    return "{Method: $method, URL: $url, StatusCode: $statusCode}";
  }
}
