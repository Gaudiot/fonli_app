part of '../fonli_server.dart';

final class GetUserLifestyleResponse {
  String lifestyle;

  GetUserLifestyleResponse({required this.lifestyle});

  factory GetUserLifestyleResponse.fromJson(Map<String, dynamic> json) =>
      GetUserLifestyleResponse(lifestyle: json['lifestyle']);
}

final class SaveUserLifestyleRequest {
  String text;

  SaveUserLifestyleRequest({required this.text});

  Map<String, dynamic> toJson() => {'text': text};
}

final class SaveUserLifestyleResponse {
  String lifestyle;

  SaveUserLifestyleResponse({required this.lifestyle});

  factory SaveUserLifestyleResponse.fromJson(Map<String, dynamic> json) =>
      SaveUserLifestyleResponse(lifestyle: json['lifestyle']);
}
