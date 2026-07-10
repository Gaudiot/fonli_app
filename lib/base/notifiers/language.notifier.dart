import 'package:flutter/foundation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';

class LanguageNotifier extends ChangeNotifier {
  LanguageNotifier._() {
    _loadFromStorage();
  }

  static final LanguageNotifier _instance = LanguageNotifier._();

  static LanguageNotifier get instance => _instance;

  factory LanguageNotifier() => _instance;

  String _nativeLanguage = "BR";
  String _targetLanguage = "IT";

  Future<void> _loadFromStorage() async {
    _nativeLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.nativeLanguage,
      "BR",
    );
    _targetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      "IT",
    );
    notifyListeners();
  }

  String get nativeLanguage => _nativeLanguage;
  String get targetLanguage => _targetLanguage;

  set nativeLanguage(String value) {
    if (_nativeLanguage == value) return;
    _nativeLanguage = value;
    localStorage.setString(.nativeLanguage, value);
    notifyListeners();
  }

  set targetLanguage(String value) {
    if (_targetLanguage == value) return;
    _targetLanguage = value;
    localStorage.setString(.targetLanguage, value);
    notifyListeners();
  }
}
