import 'package:flutter/material.dart';

class BaseViewState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

final class StoryTranslationExerciseViewState extends BaseViewState {
  String story = "";
  bool isEvaluated = false;
  int score = 0;
  List<String> errors = [];
  String correctTranslation = "";

  @override
  void notifyListeners() => super.notifyListeners();
}
