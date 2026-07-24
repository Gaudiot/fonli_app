import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageViewController {
  final EventEmitter<OnboardingStepStatus> emitter;
  final viewModel = OnboardingBaseLanguageViewModel();

  OnboardingBaseLanguageViewController({required this.emitter}) {
    _fetchTargetLanguage();
  }

  void _fetchTargetLanguage() async {
    viewModel.targetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      "en_US",
    );
  }

  void onLanguageSelected(String languageCode) {
    viewModel.baseLanguage = languageCode;
  }

  void onNextPressed() {
    final baseLanguage = viewModel.baseLanguage;
    final targetLanguage = viewModel.targetLanguage;
    if (baseLanguage == targetLanguage) return;

    localStorage.setString(.baseLanguage, viewModel.baseLanguage);
    emitter.emit(.completed);
  }
}
