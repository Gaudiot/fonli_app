import 'package:fonli_app/core/storage/impl/shared_preferences.local_storage.dart';

final ILocalStorage localStorage = SharedPreferencesLocalStorage();

enum LocalStorageKeys {
  nativeLanguage("native_language"),
  targetLanguage("target_language");

  final String key;

  const LocalStorageKeys(this.key);
}

abstract class ILocalStorage {
  void deleteKey(String key);

  Future<String?> getString(LocalStorageKeys key);
  Future<String> getStringWithDefault(
    LocalStorageKeys key,
    String defaultValue,
  );

  Future<String> setString(LocalStorageKeys key, String value);
}
