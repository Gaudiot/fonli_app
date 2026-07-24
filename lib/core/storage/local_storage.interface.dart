import 'package:fonli_app/core/storage/impl/shared_preferences.local_storage.dart';

final ILocalStorage localStorage = SharedPreferencesLocalStorage();

enum LocalStorageKeys {
  baseLanguage("base_language"),
  targetLanguage("target_language"),
  onboarded("onboarded");

  final String key;

  const LocalStorageKeys(this.key);
}

abstract class ILocalStorage {
  void deleteKey(String key);

  // MARK: - String
  Future<String?> getString(LocalStorageKeys key);
  Future<String> getStringWithDefault(
    LocalStorageKeys key,
    String defaultValue,
  );
  Future<String> setString(LocalStorageKeys key, String value);

  // MARK: - Boolean
  Future<bool?> getBoolean(LocalStorageKeys key);
  Future<bool> getBooleanWithDefault(LocalStorageKeys key, bool defaultValue);
  Future<bool> setBoolean(LocalStorageKeys key, bool value);
}
