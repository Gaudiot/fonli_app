import 'package:fonli_app/base/http/fonli_server.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewstate.dart';

enum WordTranslationExerciseType { nativeToForeign, foreignToNative }

class WordTranslationExerciseViewModel {
  final WordTranslationExerciseType exerciseType;
  final WordTranslationExerciseViewState state;

  WordTranslationExerciseViewModel({
    required this.exerciseType,
    required this.state,
  });

  Future<void> init() async {
    await fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    if (exerciseType == WordTranslationExerciseType.nativeToForeign) {
      await fetchNativeToForeignQuestions();
    } else {
      await fetchForeignToNativeQuestions();
    }
  }

  Future<void> fetchNativeToForeignQuestions() async {
    final questions =
        await FonliServer.getWordTranslationNativeToForeignExercise();

    questions.when(onOk: (p0) => state.questions = p0.questions);
  }

  Future<void> fetchForeignToNativeQuestions() async {
    final questions =
        await FonliServer.getWordTranslationForeignToNativeExercise();

    questions.when(onOk: (p0) => state.questions = p0.questions);
  }

  void evaluateAnswers() {
    state.evaluateAnswers();
  }
}
