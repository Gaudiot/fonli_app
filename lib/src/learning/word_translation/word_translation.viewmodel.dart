import 'package:fonli_app/core/components/base_viewstate.dart';

class Question {
  final String word;
  final String translation;

  Question({required this.word, required this.translation});
}

class UserMistake {
  final String word;
  final String userAnswer;
  final String correctAnswer;

  UserMistake({
    required this.word,
    required this.userAnswer,
    required this.correctAnswer,
  });
}

final class WordTranslationExerciseViewModel extends BaseViewState {
  int currentQuestionIndex = 0;
  List<Question> _questions = [];
  List<UserMistake> userMistakes = [];
  bool isExerciseFinished = false;

  bool currentAnswerSubmitted = false;
  bool isAnswerCorrect = false;

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
  String get currentAnswer => _questions[currentQuestionIndex].translation;

  List<UserMistake> get mistakes => userMistakes;
}
