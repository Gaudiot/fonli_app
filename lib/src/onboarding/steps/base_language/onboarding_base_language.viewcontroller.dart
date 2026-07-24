import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageViewController {
  final EventEmitter<OnboardingStepStatus> emitter;
  final viewModel = OnboardingBaseLanguageViewModel();

  OnboardingBaseLanguageViewController({required this.emitter});

  void onLanguageSelected(String languageCode) {
    viewModel.baseLanguage = languageCode;
  }

  void onNextPressed() {
    final selectedLanguage = viewModel.baseLanguage;
    if (selectedLanguage == null) return;
    localStorage.setString(.baseLanguage, selectedLanguage);
    emitter.emit(.completed);
  }

  void onSkipPressed() {
    emitter.emit(.completed);
  }
}
