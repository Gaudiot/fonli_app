import 'dart:async';

import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageViewController {
  final StreamSink<OnboardingStepStatus> eventStream;
  final viewModel = OnboardingTargetLanguageViewModel();

  OnboardingTargetLanguageViewController({required this.eventStream});

  void onLanguageSelected(String languageCode) {
    viewModel.targetLanguage = languageCode;
  }

  void onNextPressed() {
    localStorage.setString(.targetLanguage, viewModel.targetLanguage);
    eventStream.add(.completed);
  }
}
