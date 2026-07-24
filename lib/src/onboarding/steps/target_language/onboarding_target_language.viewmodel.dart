import 'package:fonli_app/core/components/base_viewstate.dart';

class OnboardingTargetLanguageViewModel extends BaseViewState {
  String? _targetLanguage;

  OnboardingTargetLanguageViewModel();

  String? get targetLanguage => _targetLanguage;
  set targetLanguage(String value) {
    _targetLanguage = value;
    notifyListeners();
  }
}
