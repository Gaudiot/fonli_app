import 'package:fonli_app/core/components/base_viewstate.dart';

class OnboardingBaseLanguageViewModel extends BaseViewState {
  String? _baseLanguage;

  String? get baseLanguage => _baseLanguage;
  set baseLanguage(String languageCode) {
    _baseLanguage = languageCode;
    notifyListeners();
  }
}
