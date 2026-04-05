import 'package:fonli_app/core/components/base_viewstate.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';

class Question {
  final String word;
  final String translation;

  Question({required this.word, required this.translation});
}

final class WordTranslationExerciseViewModel extends BaseViewState {
  int currentQuestionIndex = 0;
  List<Question> _questions = [];
  List<String> userAnswers = [];
  bool isExerciseFinished = false;

  /// Set when fetch fails; consumed by the view to show the app snackbar.
  String? snackbarErrorMessage;

  set questions(List<Question> value) {
    _questions = value;
  }

  void clearSnackbarError() {
    if (snackbarErrorMessage == null) return;
    snackbarErrorMessage = null;
    notifyListeners();
  }

  void reportSnackbarError(String message) {
    snackbarErrorMessage = message;
    notifyListeners();
  }

  int get questionsLength => _questions.length;
  String get currentQuestion => _questions[currentQuestionIndex].word;

  List<Pair<String, String>> get mistakes {
    List<Pair<String, String>> userMistakes = [];
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] != _questions[i].translation) {
        userMistakes.add(
          Pair(first: userAnswers[i], second: _questions[i].translation),
        );
      }
    }

    return userMistakes;
  }
}
