import 'package:fonli_app/core/storage/impl/shared_preferences.local_storage.dart';

final ILocalStorage localStorage = SharedPreferencesLocalStorage();

abstract class ILocalStorage {
  void deleteKey(String key);

  Future<String?> getString(String key);
  Future<String> getStringWithDefault(String key, String defaultValue);

  Future<String> setString(String key, String value);
}
