import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/components/base_viewstate.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';

final class WordConjugationExerciseViewModel extends BaseViewState {
  String word = "";
  String tense = "";
  List<Conjugation> _conjugations = [];
  int currentQuestionIndex = 0;
  List<String> userAnswers = [];
  bool isExerciseFinished = false;

  /// Set when fetch fails; consumed by the view to show the app snackbar.
  String? snackbarErrorMessage;

  set conjugations(List<Conjugation> value) {
    _conjugations = value;
  }

  void clearSnackbarError() {
    if (snackbarErrorMessage == null) return;
    snackbarErrorMessage = null;
    notifyListeners();
  }

  void reportSnackbarError(String message) {
    snackbarErrorMessage = message;
    notifyListeners();
  }

  int get questionsLength => _conjugations.length;
  Conjugation get currentConjugation => _conjugations[currentQuestionIndex];
  String get currentPrompt =>
      '${_conjugations[currentQuestionIndex].person} (${_conjugations[currentQuestionIndex].number})';

  List<Pair<String, String>> get mistakes {
    List<Pair<String, String>> userMistakes = [];
    for (int i = 0; i < userAnswers.length && i < _conjugations.length; i++) {
      if (userAnswers[i].trim().toLowerCase() !=
          _conjugations[i].conjugation.trim().toLowerCase()) {
        userMistakes.add(Pair(userAnswers[i], _conjugations[i].conjugation));
      }
    }
    return userMistakes;
  }
}
