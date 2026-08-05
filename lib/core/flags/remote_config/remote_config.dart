import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/flags/remote_config/remote_config.interface.dart';

abstract class _RemoteConfig<T> {
  final String _key;
  final T _fallback;

  const _RemoteConfig(this._key, this._fallback);

  @visibleForOverriding
  T? parse(Object? raw);

  Future<T> value() async {
    try {
      return parse(await remoteConfig.getValue(_key)) ?? _fallback;
    } catch (_) {
      return _fallback;
    }
  }
}

final class IntegerRemoteConfig extends _RemoteConfig<int> {
  const IntegerRemoteConfig(super.key, super.fallback);

  @override
  @protected
  int? parse(Object? raw) => switch (raw) {
    final int v => v,
    final num v => v.toInt(),
    final String v => int.tryParse(v),
    _ => null,
  };

  static const IntegerRemoteConfig minimumBuildNumber = IntegerRemoteConfig(
    "minimum-build-number",
    2,
  );
}
