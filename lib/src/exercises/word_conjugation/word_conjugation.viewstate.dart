import 'package:flutter/material.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';
import 'package:fonli_app/core/types/exercises.type.dart';

class BaseViewState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

final class WordConjugationExerciseViewState extends BaseViewState {
  String word = "";
  String tense = "";
  List<Conjugation> _conjugations = [];
  int currentQuestionIndex = 0;
  List<String> userAnswers = [];
  bool isExerciseFinished = false;

  set conjugations(List<Conjugation> value) {
    _conjugations = value;
  }

  int get questionsLength => _conjugations.length;
  Conjugation get currentConjugation => _conjugations[currentQuestionIndex];
  String get currentPrompt =>
      '${_conjugations[currentQuestionIndex].person} (${_conjugations[currentQuestionIndex].number})';

  List<Pair<String, String>> get mistakes {
    List<Pair<String, String>> userMistakes = [];
    for (int i = 0; i < userAnswers.length && i < _conjugations.length; i++) {
      if (userAnswers[i].trim().toLowerCase() !=
          _conjugations[i].conjugation.trim().toLowerCase()) {
        userMistakes.add(
          Pair(first: userAnswers[i], second: _conjugations[i].conjugation),
        );
      }
    }
    return userMistakes;
  }

  @override
  void notifyListeners() => super.notifyListeners();
}
