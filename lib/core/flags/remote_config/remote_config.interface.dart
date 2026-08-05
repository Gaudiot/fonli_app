import 'package:fonli_app/core/flags/remote_config/impl/posthog.remote_config.dart';

final IRemoteConfigService remoteConfig = PosthogRemoteConfig();

abstract class IRemoteConfigService {
  Future<void> init();
  Future<Object?> getValue(String key);
}
