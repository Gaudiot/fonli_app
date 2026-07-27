import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/types/language_code.type.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.viewmodel.dart';

class LanguageLearningSettingsViewController
    extends FViewController<LanguageLearningSettingsViewModel> {
  LanguageLearningSettingsViewController({required super.viewModel});

  @override
  void onInit(BuildContext context) {
    super.onInit(context);
    value = value.copyWith(
      baseLanguage: LanguageNotifier.instance.value.baseLanguage,
      targetLanguage: LanguageNotifier.instance.value.targetLanguage,
    );
  }

  Future<void> onBaseLanguageChanged(LanguageCode language) async {
    if (value.targetLanguage == language) return;
    await LanguageNotifier.instance.setBaseLanguage(language);
    value = value.copyWith(baseLanguage: language);
  }

  Future<void> onTargetLanguageChanged(LanguageCode language) async {
    if (value.baseLanguage == language) return;
    await LanguageNotifier.instance.setTargetLanguage(language);
    value = value.copyWith(targetLanguage: language);
  }
}
