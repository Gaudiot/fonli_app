import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.view.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.viewcontroller.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.viewmodel.dart';

class LanguageLearningSettingsBuilder extends FViewBuilder {
  @override
  Widget build() {
    final viewModel = LanguageLearningSettingsViewModel();
    final viewController = LanguageLearningSettingsViewController(
      viewModel: viewModel,
    );
    return LanguageLearningSettingsView(viewController: viewController);
  }
}
