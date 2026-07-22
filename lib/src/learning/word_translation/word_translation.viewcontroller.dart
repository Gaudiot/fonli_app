import 'package:flutter/services.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/learning/word_translation/word_translation.viewmodel.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

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

    HapticFeedback.lightImpact();

    final isAnswerCorrect = checkAnswer(viewModel.currentAnswer, trimmedAnswer);
    if (!isAnswerCorrect) {
      viewModel.userMistakes.add(
        UserMistake(
          word: viewModel.currentQuestion,
          userAnswer: trimmedAnswer,
          correctAnswer: viewModel.currentAnswer,
        ),
      );
    }
    viewModel.isAnswerCorrect = isAnswerCorrect;

    viewModel.currentAnswerSubmitted = true;
    viewModel.notifyListeners();
  }

  void moveToNextQuestion() {
    viewModel.currentAnswerSubmitted = false;

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

  bool checkAnswer(String correctAnswer, String userAnswer) {
    const threshold = 90;
    final similarityScore = ratio(correctAnswer, userAnswer);

    return similarityScore >= threshold;
  }
}
