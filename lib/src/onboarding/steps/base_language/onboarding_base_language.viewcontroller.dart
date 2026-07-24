import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageViewController {
  final viewModel = OnboardingBaseLanguageViewModel();

  OnboardingBaseLanguageViewController();

  void onLanguageSelected(String languageCode) {
    viewModel.setSelectedLanguage(languageCode);
  }

  void onNextPressed() {}

  void onSkipPressed() {}
}
