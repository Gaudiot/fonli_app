import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';

class FlutterSecureStorageImpl implements ISecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<String?> getString(SecureStorageKeys key) async {
    return await _storage.read(key: key.key);
  }

  @override
  Future<void> setString(SecureStorageKeys key, String value) async {
    await _storage.write(key: key.key, value: value);
  }

  @override
  Future<void> deleteKey(SecureStorageKeys key) async {
    await _storage.delete(key: key.key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
