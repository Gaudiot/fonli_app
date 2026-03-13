import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocalStorage implements ILocalStorage {
  final SharedPreferencesAsync _sp = SharedPreferencesAsync();

  @override
  Future<void> deleteKey(String key) async {
    await _sp.remove(key);
  }

  @override
  Future<String?> getString(LocalStorageKeys key) async {
    final containsKey = await _sp.containsKey(key.key);

    if (!containsKey) {
      return null;
    }

    final value = await _sp.getString(key.key);

    return value;
  }

  @override
  Future<String> getStringWithDefault(
    LocalStorageKeys key,
    String defaultValue,
  ) async {
    final value = await getString(key);

    if (value == null) {
      return defaultValue;
    }

    return value;
  }

  @override
  Future<String> setString(LocalStorageKeys key, String value) async {
    await _sp.setString(key.key, value);

    return value;
  }
}
