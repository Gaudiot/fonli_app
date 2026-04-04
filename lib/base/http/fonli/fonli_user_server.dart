part of 'fonli_server.dart';

class FonliUserServer {
  FonliUserServer._();

  static Future<Result<GetUserLifestyleResponse, Exception>>
  getUserLifestyle() async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get('$baseUrl/user/lifestyle');
      final data = GetUserLifestyleResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<SaveUserLifestyleResponse, Exception>> saveUserLifestyle(
    String lifestyle,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.post(
        '$baseUrl/user/lifestyle',
        data: SaveUserLifestyleRequest(text: lifestyle).toJson(),
      );
      final data = SaveUserLifestyleResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
