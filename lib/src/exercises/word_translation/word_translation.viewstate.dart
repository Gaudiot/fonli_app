import 'package:fonli_app/core/components/base_viewstate.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';

class Question {
  final String word;
  final String translation;

  Question({required this.word, required this.translation});
}

final class WordTranslationExerciseViewState extends BaseViewState {
  int currentQuestionIndex = 0;
  List<Question> _questions = [
    Question(word: "1", translation: "2"),
    Question(word: "3", translation: "4"),
    Question(word: "5", translation: "6"),
  ];
  List<String> userAnswers = [];
  bool isExerciseFinished = false;

  set questions(List<Question> value) {
    _questions = value;
  }

  int get questionsLength => _questions.length;
  String get currentQuestion => _questions[currentQuestionIndex].word;

  List<Pair<String, String>> get mistakes {
    List<Pair<String, String>> userMistakes = [];
    for (int i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i] != _questions[i].translation) {
        userMistakes.add(
          Pair(first: userAnswers[i], second: _questions[i].translation),
        );
      }
    }

    return userMistakes;
  }

  @override
  void notifyListeners() => super.notifyListeners();
}
