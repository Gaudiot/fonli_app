import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';

class LanguageNotifier extends ChangeNotifier {
  LanguageNotifier._() {
    _loadFromStorage();
  }

  static final LanguageNotifier _instance = LanguageNotifier._();

  static LanguageNotifier get instance => _instance;

  factory LanguageNotifier() => _instance;

  String _baseLanguage = "pt_BR";
  String _targetLanguage = "en_US";

  Future<void> _loadFromStorage() async {
    _baseLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.baseLanguage,
      "pt_BR",
    );
    _targetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      "en_US",
    );
    notifyListeners();
  }

  String get nativeLanguage => _baseLanguage;
  String get targetLanguage => _targetLanguage;

  set nativeLanguage(String value) {
    if (_baseLanguage == value) return;
    _baseLanguage = value;
    localStorage.setString(.baseLanguage, value);
    notifyListeners();
  }

  set targetLanguage(String value) {
    if (_targetLanguage == value) return;
    _targetLanguage = value;
    localStorage.setString(.targetLanguage, value);
    notifyListeners();
  }
}
