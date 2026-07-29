import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  final String _version;
  final String _buildNumber;

  AppInfo._({required String version, required String buildNumber})
    : _version = version,
      _buildNumber = buildNumber;

  static AppInfo? _instance;

  /// Static getters to access the version
  /// Returns 'Version not available' if the version is not available or not initialized
  static String get version => _instance?._version ?? 'Version not available';

  /// Static getter to access the build number
  /// Returns 0 if the build number is not available or not initialized
  static int get buildNumber {
    final stringBuildNumber = _instance?._buildNumber;
    if (stringBuildNumber == null) return 0;
    final appBuildNumber = int.tryParse(stringBuildNumber);
    return appBuildNumber ?? 0;
  }

  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    _instance = AppInfo._(version: info.version, buildNumber: info.buildNumber);
  }
}
