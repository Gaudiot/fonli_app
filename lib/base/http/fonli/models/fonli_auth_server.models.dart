part of '../fonli_server.dart';

final class LoginResponse {
  final String accessToken;
  final String refreshToken;

  LoginResponse({required this.accessToken, required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
  );
}

final class SignUpResponse {
  final String accessToken;
  final String refreshToken;

  SignUpResponse({required this.accessToken, required this.refreshToken});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    accessToken: json['access_token'],
    refreshToken: json['refresh_token'],
  );
}

final class RefreshRequest {
  final String refreshToken;

  RefreshRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refresh_token': refreshToken};
}

final class RefreshResponse {
  final String accessToken;
  final String refreshToken;

  RefreshResponse({required this.accessToken, required this.refreshToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) =>
      RefreshResponse(
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
      );
}
