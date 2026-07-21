import 'package:fonli_app/base/http/fonli/fonli_server.dart';

class UserSettingsRepository {
  UserSettingsRepository();

  Future<String> loadLifestyle() async {
    final result = await FonliUserServer.getUserLifestyle();
    if (result.isError) {
      print(result.error!.toString());
      throw result.error!;
    }
    return result.data!.lifestyle;
  }

  Future<void> saveLifestyle(String lifestyle) async {
    if (lifestyle.length > 500) {
      throw Exception('Lifestyle must be at most 500 characters');
    }

    final result = await FonliUserServer.saveUserLifestyle(lifestyle);
    if (result.isError) {
      throw result.error!;
    }
  }
}
