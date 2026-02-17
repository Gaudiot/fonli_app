import 'package:flutter/material.dart';
import 'package:fonli_app/core/types/exercises.type.dart';

final class WordTranslationExerciseViewState extends ChangeNotifier {
  List<WordTranslationExerciseQuestion> _questions = [];

  List<WordTranslationExerciseQuestion> get questions => _questions;

  set questions(List<WordTranslationExerciseQuestion> value) {
    _questions = value;
    _initializeControllers();
    notifyListeners();
  }

  bool areAnswersHidden = true;
  List<bool?> isCorrect =
      []; // null = não verificado, true = correto, false = incorreto
  List<TextEditingController> answerControllers = [];

  WordTranslationExerciseViewState() {
    _initializeControllers();
  }

  void _initializeControllers() {
    // Dispose dos controllers antigos
    for (var controller in answerControllers) {
      controller.dispose();
    }
    // Criar novos controllers baseado no tamanho atual de questions
    answerControllers = List.generate(
      _questions.length,
      (index) => TextEditingController(),
    );
    isCorrect = List.filled(_questions.length, null);
  }

  void toggleAnswersVisibility() {
    areAnswersHidden = !areAnswersHidden;
    notifyListeners();
  }

  void evaluateAnswers() {
    for (int i = 0; i < questions.length; i++) {
      final userAnswer = answerControllers[i].text.trim().toLowerCase();
      final correctAnswer = questions[i].translation.trim().toLowerCase();
      isCorrect[i] = userAnswer == correctAnswer;
    }
    toggleAnswersVisibility();
  }

  @override
  void dispose() {
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
