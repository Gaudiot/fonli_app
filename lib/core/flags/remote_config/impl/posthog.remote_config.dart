import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/flags/remote_config/remote_config.interface.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

final class PosthogRemoteConfig implements IRemoteConfigService {
  @override
  Future<void> init() async {
    final config = PostHogConfig(
      'phc_AQ7Lbj4NBCWw2wgVnV7GPteXSpykHUxwZ5xSTJAfBaru',
    );
    config.debug = kDebugMode;
    config.host = 'https://us.i.posthog.com';
    await Posthog().setup(config);
    await Posthog().reloadFeatureFlags();
  }

  @override
  Future<Object?> getValue(String key) async {
    final result = await Posthog().getFeatureFlagResult(key);
    return result?.payload;
  }
}
