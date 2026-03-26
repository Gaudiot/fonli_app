part of 'fonli_auth_server.dart';

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
