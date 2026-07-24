import 'package:flutter/material.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageViewController {
  final viewModel = OnboardingTargetLanguageViewModel();

  OnboardingTargetLanguageViewController();

  void onLanguageSelected(String languageCode) {
    viewModel.targetLanguage = languageCode;
  }

  void onNextPressed(BuildContext context) {
    localStorage.setString(.targetLanguage, "en_US");
    // onNext(context);
  }

  void onSkipPressed(BuildContext context) {
    // onNext(context);
  }
}
