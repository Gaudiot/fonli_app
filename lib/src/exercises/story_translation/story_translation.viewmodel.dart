import 'package:fonli_app/core/components/base_viewstate.dart';

final class StoryTranslationExerciseViewModel extends BaseViewState {
  bool isInitialLoading = true;
  bool isSubmitButtonLoading = false;
  String storyText = "";
  bool isEvaluated = false;
  int score = 0;
  List<String> errorsList = [];
  String correctTranslationText = "";

  /// Set when generate/evaluate fails; consumed by the view to show the app snackbar.
  String? snackbarErrorMessage;

  void clearSnackbarError() {
    if (snackbarErrorMessage == null) return;
    snackbarErrorMessage = null;
    notifyListeners();
  }

  void reportSnackbarError(String message) {
    snackbarErrorMessage = message;
    notifyListeners();
  }
}
