import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageViewController {
  final EventEmitter<OnboardingStepStatus> emitter;
  final viewModel = OnboardingTargetLanguageViewModel();

  OnboardingTargetLanguageViewController({required this.emitter});

  void onLanguageSelected(String languageCode) {
    viewModel.targetLanguage = languageCode;
  }

  void onNextPressed() {
    localStorage.setString(.targetLanguage, viewModel.targetLanguage);
    emitter.emit(.completed);
  }
}
