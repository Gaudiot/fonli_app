import 'package:fonli_app/core/components/base_viewmodel.dart';

class VocabularyViewModel extends FViewModel {
  // Screen data
  final bool isLoading;
  final int currentQuestionIndex;
  final List<VocabularyQuestion> questions;
  final String errorMessage;
  final List<VocabularyMistake> wrongUserAnswers;

  // Exercise data
  final bool isUserAnswerCorrect;
  final bool didUserSubmitAnswer;

  // Getters

  bool get hasError => errorMessage.isNotEmpty;
  bool get hasCompletedExercise => currentQuestionIndex >= questions.length;
  double get progressPercentage {
    final questionsLength = questions.length;
    if (questionsLength == 0) return 1;
    final completedQuestions =
        currentQuestionIndex + (didUserSubmitAnswer ? 1 : 0);
    return completedQuestions / questionsLength;
  }

  VocabularyViewModel({
    this.isLoading = true,
    this.currentQuestionIndex = 0,
    this.questions = const [],
    this.isUserAnswerCorrect = false,
    this.didUserSubmitAnswer = false,
    this.errorMessage = "",
    this.wrongUserAnswers = const [],
  });

  VocabularyViewModel copyWith({
    bool? isLoading,
    int? currentQuestionIndex,
    bool? isUserAnswerCorrect,
    String? errorMessage,
    List<VocabularyQuestion>? questions,
    bool? didUserSubmitAnswer,
    List<VocabularyMistake>? wrongUserAnswers,
  }) {
    return VocabularyViewModel(
      isLoading: isLoading ?? this.isLoading,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isUserAnswerCorrect: isUserAnswerCorrect ?? this.isUserAnswerCorrect,
      errorMessage: errorMessage ?? this.errorMessage,
      questions: questions ?? this.questions,
      didUserSubmitAnswer: didUserSubmitAnswer ?? this.didUserSubmitAnswer,
      wrongUserAnswers: wrongUserAnswers ?? this.wrongUserAnswers,
    );
  }
}

// MARK: - Models

class VocabularyQuestion {
  final String word;
  final String answer;

  VocabularyQuestion({required this.word, required this.answer});
}

class VocabularyMistake {
  final String word;
  final String userAnswer;
  final String correctAnswer;

  VocabularyMistake({
    required this.word,
    required this.userAnswer,
    required this.correctAnswer,
  });
}
