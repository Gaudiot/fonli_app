import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/core/types/language_code.type.dart';

class _UserLanguage {
  final LanguageCode baseLanguage;
  final LanguageCode targetLanguage;

  _UserLanguage({required this.baseLanguage, required this.targetLanguage});

  _UserLanguage copyWith({
    LanguageCode? baseLanguage,
    LanguageCode? targetLanguage,
  }) {
    return _UserLanguage(
      baseLanguage: baseLanguage ?? this.baseLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}

class LanguageNotifier extends ValueNotifier<_UserLanguage> {
  LanguageNotifier._()
    : super(_UserLanguage(baseLanguage: .pt_BR, targetLanguage: .en_US)) {
    _loadFromStorage();
  }

  static final LanguageNotifier _instance = LanguageNotifier._();

  static LanguageNotifier get instance => _instance;

  factory LanguageNotifier() => _instance;

  Future<void> _loadFromStorage() async {
    final baseLanguage = await localStorage.getStringWithDefault(
      .baseLanguage,
      LanguageCode.pt_BR.code,
    );
    final targetLanguage = await localStorage.getStringWithDefault(
      .targetLanguage,
      LanguageCode.en_US.code,
    );

    setLanguages(
      LanguageCode.fromString(baseLanguage),
      LanguageCode.fromString(targetLanguage),
    );
  }

  Future<void> setBaseLanguage(LanguageCode language) async {
    value = value.copyWith(baseLanguage: language);
    await localStorage.setString(.baseLanguage, language.code);
  }

  Future<void> setTargetLanguage(LanguageCode language) async {
    value = value.copyWith(targetLanguage: language);
    await localStorage.setString(.targetLanguage, language.code);
  }

  Future<void> setLanguages(
    LanguageCode baseLanguage,
    LanguageCode targetLanguage,
  ) async {
    value = value.copyWith(
      baseLanguage: baseLanguage,
      targetLanguage: targetLanguage,
    );
    await localStorage.setString(.baseLanguage, baseLanguage.code);
    await localStorage.setString(.targetLanguage, targetLanguage.code);
  }
}
