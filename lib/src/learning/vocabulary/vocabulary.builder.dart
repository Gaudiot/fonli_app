import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.view.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.viewcontroller.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.viewmodel.dart';

class VocabularyExerciseBuilder extends FViewBuilder {
  @override
  Widget build() {
    final viewModel = VocabularyViewModel();
    final viewController = VocabularyViewController(viewModel: viewModel);
    return VocabularyExerciseView(viewController: viewController);
  }
}
