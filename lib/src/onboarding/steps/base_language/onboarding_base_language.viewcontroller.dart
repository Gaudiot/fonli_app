import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/components/snackbar/snackbar_messenger.interface.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/core/types/language_code.type.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageViewController
    extends FViewController<OnboardingBaseLanguageViewModel> {
  final SnackbarMessenger snackbarMessenger;
  final StreamSink<OnboardingStepStatus> eventStream;

  OnboardingBaseLanguageViewController({
    required this.eventStream,
    required this.snackbarMessenger,
    required super.viewModel,
  }) {
    _fetchTargetLanguage();
  }

  void _fetchTargetLanguage() async {
    final targetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      LanguageCode.pt_BR.code,
    );
    value = value.copyWith(
      targetLanguage: LanguageCode.fromString(targetLanguage),
    );
  }

  void onLanguageSelected(LanguageCode code) {
    value = value.copyWith(baseLanguage: code);
  }

  void onNextPressed(BuildContext context) {
    if (value.baseLanguage == value.targetLanguage) {
      snackbarMessenger.showInfo(
        context,
        "Base language and target language cannot be the same",
      );
      return;
    }

    localStorage.setString(.baseLanguage, value.baseLanguage.code);
    eventStream.add(.completed);
  }
}
