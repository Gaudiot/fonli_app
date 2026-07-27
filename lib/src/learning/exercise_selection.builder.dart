import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/learning/exercise_selection.view.dart';
import 'package:fonli_app/src/learning/exercise_selection.viewcontroller.dart';
import 'package:fonli_app/src/learning/exercise_selection.viewmodel.dart';

class ExerciseSelectionBuilder extends FViewBuilder {
  const ExerciseSelectionBuilder();

  @override
  Widget build() {
    final viewModel = ExerciseSelectionViewModel();
    final viewController = ExerciseSelectionViewController(
      viewModel: viewModel,
    );

    return ExerciseSelectionViewV2(viewController: viewController);
  }
}
