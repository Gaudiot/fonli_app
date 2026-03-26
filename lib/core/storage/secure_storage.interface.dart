import 'package:fonli_app/core/storage/impl/flutter_secure.secure_storage.dart';

final ISecureStorage secureStorage = FlutterSecureStorageImpl();

enum SecureStorageKeys {
  accessToken("access_token"),
  refreshToken("refresh_token");

  final String key;

  const SecureStorageKeys(this.key);
}

abstract class ISecureStorage {
  Future<String?> getString(SecureStorageKeys key);
  Future<void> setString(SecureStorageKeys key, String value);
  Future<void> deleteKey(SecureStorageKeys key);
  Future<void> deleteAll();
}
