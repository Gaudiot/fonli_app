import 'package:flutter/services.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/learning/word_conjugation/word_conjugation.viewmodel.dart';

class WordConjugationExerciseViewController {
  final WordConjugationExerciseViewModel viewModel =
      WordConjugationExerciseViewModel();

  void fetchWordConjugationExercise() async {
    viewModel.isLoading = true;

    final result = await FonliExerciseServer.getWordConjugationExercise(
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (exercise) {
        viewModel.word = exercise.word;
        viewModel.tense = exercise.tense;
        viewModel.conjugations = exercise.conjugations;
      },
      onError: (e) {
        viewModel.reportSnackbarError(_messageFromExerciseError(e));
      },
    );
    viewModel.isLoading = false;
  }

  String _messageFromExerciseError(Object error) {
    final s = error.toString();
    const prefix = 'Exception: ';
    if (s.startsWith(prefix)) {
      return s.substring(prefix.length);
    }
    return s;
  }

  void submitAnswer(String answer) {
    final trimmedAnswer = answer.trim();
    if (trimmedAnswer.isEmpty) {
      return;
    }

    viewModel.userAnswers.add(trimmedAnswer);
    HapticFeedback.lightImpact();

    final hasNextQuestion =
        (viewModel.currentQuestionIndex + 1) < viewModel.questionsLength;
    if (!hasNextQuestion) {
      finishExercise();
      return;
    }

    viewModel.currentQuestionIndex++;
    viewModel.notifyListeners();
  }

  void finishExercise() {
    viewModel.isExerciseFinished = true;
    viewModel.notifyListeners();
  }
}
