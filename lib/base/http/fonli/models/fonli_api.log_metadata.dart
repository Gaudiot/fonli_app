part of '../fonli_server.dart';

class FonliServerLogMetadata implements LoggableMetadata {
  final String url;
  final int statusCode;

  FonliServerLogMetadata({required this.url, required this.statusCode});

  @override
  String toLogString() {
    return "{URL: $url, StatusCode: $statusCode}";
  }
}
