import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/base/http/fonli_server.dart';
import 'package:fonli_app/src/exercises/word_conjugation/word_conjugation.viewstate.dart';

class WordConjugationExerciseViewModel {
  final WordConjugationExerciseViewState state =
      WordConjugationExerciseViewState();

  void fetchWordConjugationExercise() async {
    state.isLoading = true;

    final result = await FonliServer.getWordConjugationExercise(
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (exercise) {
        state.word = exercise.word;
        state.tense = exercise.tense;
        state.conjugations = exercise.conjugations;
      },
      onError: (_) {},
    );
    state.isLoading = false;
  }

  void submitAnswer(String answer) {
    final trimmedAnswer = answer.trim();
    if (trimmedAnswer.isEmpty) {
      return;
    }

    state.userAnswers.add(trimmedAnswer);

    final hasNextQuestion =
        (state.currentQuestionIndex + 1) < state.questionsLength;
    if (!hasNextQuestion) {
      finishExercise();
      return;
    }

    state.currentQuestionIndex++;
    state.notifyListeners();
  }

  void finishExercise() {
    state.isExerciseFinished = true;
    state.notifyListeners();
  }
}
