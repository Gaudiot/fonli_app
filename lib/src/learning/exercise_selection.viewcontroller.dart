import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/learning/exercise_selection.viewmodel.dart';

class ExerciseSelectionViewController
    extends FViewController<ExerciseSelectionViewModel> {
  ExerciseSelectionViewController({required super.viewModel});

  void onSettingsTap(BuildContext context) {
    NavigationManager.goTo(context, .settings);
  }

  void onLanguageSelectorTap(BuildContext context) {
    NavigationManager.goTo(context, .languageLearningSettings);
  }
}
