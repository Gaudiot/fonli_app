abstract class DynamicConfig<T> {
  final String _key;
  final T _defaultValue;

  DynamicConfig(this._key, T fallback) : _defaultValue = fallback;

  Future<T> value() async {
    await Future.delayed(Duration(seconds: 3));
    return _defaultValue;
  }
}

class IntegerDynamicConfig extends DynamicConfig<int> {
  IntegerDynamicConfig(super.key, super.fallback);

  static IntegerDynamicConfig minimumBuildNumber = IntegerDynamicConfig(
    "minimum-build-number",
    1,
  );
}
