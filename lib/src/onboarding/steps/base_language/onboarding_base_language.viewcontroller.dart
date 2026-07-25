import 'dart:async';

import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageViewController
    extends FViewController<OnboardingBaseLanguageViewModel> {
  final StreamSink<OnboardingStepStatus> eventStream;

  OnboardingBaseLanguageViewController({
    required this.eventStream,
    required super.viewModel,
  }) {
    _fetchTargetLanguage();
  }

  void _fetchTargetLanguage() async {
    final targetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      "en_US",
    );
    value = value.copyWith(targetLanguage: targetLanguage);
  }

  void onLanguageSelected(String languageCode) {
    value = value.copyWith(baseLanguage: languageCode);
  }

  void onNextPressed() {
    if (value.baseLanguage == value.targetLanguage) return;

    localStorage.setString(.baseLanguage, value.baseLanguage);
    eventStream.add(.completed);
  }
}
