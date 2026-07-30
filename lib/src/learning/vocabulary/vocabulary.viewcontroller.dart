import 'package:flutter/material.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.viewmodel.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class VocabularyViewController extends FViewController<VocabularyViewModel> {
  final TextEditingController userAnswerController = TextEditingController();

  VocabularyViewController({required super.viewModel});

  @override
  void onInit(BuildContext context) {
    _getVocabularyExercise();
    super.onInit(context);
  }

  @override
  void dispose() {
    userAnswerController.dispose();
    super.dispose();
  }

  Future<void> _getVocabularyExercise() async {
    value = VocabularyViewModel();
    final baseLanguageCode = LanguageNotifier().value.baseLanguage.code;
    final targetLanguageCode = LanguageNotifier().value.targetLanguage.code;
    final result = await FonliExerciseServer.getVocabularyExercise(
      baseLanguageCode,
      targetLanguageCode,
    );

    result.when(
      onOk: (data) {
        value = value.copyWith(
          questions: data.questions
              .map(
                (question) => VocabularyQuestion(
                  word: question.word,
                  answer: question.translation,
                ),
              )
              .toList(),
          isLoading: false,
        );
      },
      onError: (error) {
        value = value.copyWith(
          errorMessage: error.toString(),
          isLoading: false,
        );
      },
    );
  }

  void onBackPressed(BuildContext context) {
    NavigationManager.pop(context);
  }

  void onRetryPressed() {
    _getVocabularyExercise();
  }

  void onUserAnswerSubmit() {
    final answer = userAnswerController.text.trim();
    if (answer.isEmpty) return;

    final isAnswerCorrect = evaluateAnswer(
      value.questions[value.currentQuestionIndex].answer,
      answer,
    );

    var wrongUserAnswers = List<VocabularyMistake>.from(value.wrongUserAnswers);
    if (!isAnswerCorrect) {
      wrongUserAnswers.add(
        VocabularyMistake(
          word: value.questions[value.currentQuestionIndex].word,
          userAnswer: answer,
          correctAnswer: value.questions[value.currentQuestionIndex].answer,
        ),
      );
    }

    value = value.copyWith(
      didUserSubmitAnswer: true,
      isUserAnswerCorrect: isAnswerCorrect,
      wrongUserAnswers: wrongUserAnswers,
    );
  }

  void onNextQuestion() {
    userAnswerController.clear();
    final nextQuestionIndex = value.currentQuestionIndex + 1;

    value = value.copyWith(
      currentQuestionIndex: nextQuestionIndex,
      didUserSubmitAnswer: false,
      isUserAnswerCorrect: false,
    );
  }

  void onCompletePressed(BuildContext context) {
    NavigationManager.pop(context);
  }
}

// MARK: - Private Methods

extension on VocabularyViewController {
  bool evaluateAnswer(String correctAnswer, String userAnswer) {
    const threshold = 90;
    final similarityScore = ratio(correctAnswer, userAnswer);
    return similarityScore >= threshold;
  }
}
