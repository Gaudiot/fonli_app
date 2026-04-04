import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/exercises/word_conjugation/word_conjugation.viewmodel.dart';

class WordConjugationExerciseViewController {
  final WordConjugationExerciseViewModel viewModel =
      WordConjugationExerciseViewModel();

  void fetchWordConjugationExercise() async {
    viewModel.isLoading = true;

    final result = await FonliServer.getWordConjugationExercise(
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (exercise) {
        viewModel.word = exercise.word;
        viewModel.tense = exercise.tense;
        viewModel.conjugations = exercise.conjugations;
      },
      onError: (_) {},
    );
    viewModel.isLoading = false;
  }

  void submitAnswer(String answer) {
    final trimmedAnswer = answer.trim();
    if (trimmedAnswer.isEmpty) {
      return;
    }

    viewModel.userAnswers.add(trimmedAnswer);

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
