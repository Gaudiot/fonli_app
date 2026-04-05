import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewmodel.dart';

enum WordTranslationExerciseType { nativeToForeign, foreignToNative }

class WordTranslationExerciseViewController {
  final WordTranslationExerciseViewModel viewModel =
      WordTranslationExerciseViewModel();

  void fetchWordTranslationExercise(
    WordTranslationExerciseType exerciseType,
  ) async {
    viewModel.isLoading = true;

    final t = {
      WordTranslationExerciseType.nativeToForeign:
          FonliExerciseServer.getWordTranslationNativeToForeignExercise,
      WordTranslationExerciseType.foreignToNative:
          FonliExerciseServer.getWordTranslationForeignToNativeExercise,
    };

    final result = await t[exerciseType]!(
      LanguageNotifier.instance.nativeLanguage,
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (exercise) {
        viewModel.questions = exercise.questions
            .map((q) => Question(word: q.word, translation: q.translation))
            .toList();
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
    String trimmedAnswer = answer.trim();
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
