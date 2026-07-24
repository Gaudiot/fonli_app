import 'package:fonli_app/core/components/base_viewstate.dart';

class OnboardingBaseLanguageViewModel extends BaseViewState {
  String? selectedLanguage;

  setSelectedLanguage(String languageCode) {
    selectedLanguage = languageCode;
    notifyListeners();
  }
}
