import 'package:fonli_app/base/http/fonli_server.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewstate.dart';

enum WordTranslationExerciseType { nativeToForeign, foreignToNative }

class WordTranslationExerciseViewModel {
  final WordTranslationExerciseViewState state =
      WordTranslationExerciseViewState();

  void fetchWordTranslationExercise() async {
    state.isLoading = true;
    // final result =
    //     await FonliServer.getWordTranslationForeignToNativeExercise();

    // result.when(
    //   onOk: (exercise) {
    //     state.questions = exercise.questions
    //         .map((q) => Question(word: q.word, translation: q.translation))
    //         .toList();
    //   },
    // );
    state.isLoading = false;
  }

  void submitAnswer(String answer) {
    String trimmedAnswer = answer.trim();
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
