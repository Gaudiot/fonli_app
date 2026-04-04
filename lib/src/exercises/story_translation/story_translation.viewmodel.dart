import 'package:fonli_app/core/components/base_viewstate.dart';

final class StoryTranslationExerciseViewModel extends BaseViewState {
  bool isInitialLoading = true;
  bool isSubmitButtonLoading = false;
  String storyText = "";
  bool isEvaluated = false;
  int score = 0;
  List<String> errorsList = [];
  String correctTranslationText = "";
}
