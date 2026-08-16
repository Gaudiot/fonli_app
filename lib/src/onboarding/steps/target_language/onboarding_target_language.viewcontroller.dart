import 'dart:async';

import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/types/language_code.type.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageViewController
    extends FViewController<OnboardingTargetLanguageViewModel> {
  final StreamSink<OnboardingStepStatus> eventStream;

  OnboardingTargetLanguageViewController({
    required this.eventStream,
    required super.viewModel,
  });

  void onLanguageSelected(LanguageCode languageCode) {
    value = value.copyWith(targetLanguage: languageCode);
  }

  void onNextPressed() {
    LanguageNotifier.instance.setTargetLanguage(value.targetLanguage);
    eventStream.add(.completed);
  }
}
