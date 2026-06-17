part of 'fonli_server.dart';

class FonliUserServer {
  FonliUserServer._();

  static Future<Result<GetUserLifestyleResponse, Exception>>
  getUserLifestyle() async {
    final fonliApi = FonliApi.instace;
    try {
      final response = await fonliApi.get('/user/lifestyle');
      final data = GetUserLifestyleResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }

  static Future<Result<SaveUserLifestyleResponse, Exception>> saveUserLifestyle(
    String lifestyle,
  ) async {
    final fonliApi = FonliApi.instace;
    try {
      final response = await fonliApi.post(
        '/user/lifestyle',
        data: SaveUserLifestyleRequest(text: lifestyle).toJson(),
      );
      final data = SaveUserLifestyleResponse.fromJson(response.data);

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}
