import 'package:fonli_app/core/components/base_viewstate.dart';

final class StoryTranslationExerciseViewState extends BaseViewState {
  String story = "";
  bool isEvaluated = false;
  int score = 0;
  List<String> errors = [];
  String correctTranslation = "";

  @override
  void notifyListeners() => super.notifyListeners();
}
