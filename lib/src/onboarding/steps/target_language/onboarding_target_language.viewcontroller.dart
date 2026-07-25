import 'dart:async';

import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageViewController
    extends FViewController<OnboardingTargetLanguageViewModel> {
  final StreamSink<OnboardingStepStatus> eventStream;

  OnboardingTargetLanguageViewController({
    required this.eventStream,
    required super.viewModel,
  });

  void onLanguageSelected(String languageCode) {
    value = value.copyWith(targetLanguage: languageCode);
  }

  void onNextPressed() {
    localStorage.setString(.targetLanguage, value.targetLanguage);
    eventStream.add(.completed);
  }
}
