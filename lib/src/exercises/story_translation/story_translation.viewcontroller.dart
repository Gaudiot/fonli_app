import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/exercises/story_translation/story_translation.viewmodel.dart';

class StoryTranslationExerciseViewController {
  final StoryTranslationExerciseViewModel viewModel =
      StoryTranslationExerciseViewModel();

  void fetchStory() async {
    viewModel.isInitialLoading = true;
    viewModel.notifyListeners();

    final result = await FonliExerciseServer.generateStory(
      LanguageNotifier.instance.nativeLanguage,
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (response) {
        viewModel.storyText = response.story;
      },
      onError: (_) {},
    );
    viewModel.isInitialLoading = false;
    viewModel.notifyListeners();
  }

  void submitTranslation(String userTranslation) async {
    final trimmed = userTranslation.trim();
    if (trimmed.isEmpty) return;

    viewModel.isSubmitButtonLoading = true;
    viewModel.notifyListeners();

    final request = EvaluateStoryTranslationRequest(
      story: viewModel.storyText,
      userTranslation: trimmed,
    );

    final result = await FonliExerciseServer.evaluateStoryTranslation(
      request,
      LanguageNotifier.instance.nativeLanguage,
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (response) {
        viewModel.score = response.score;
        viewModel.errorsList = response.errors;
        viewModel.correctTranslationText = response.correctTranslation;
        viewModel.isEvaluated = true;
      },
      onError: (_) {},
    );
    viewModel.isSubmitButtonLoading = false;
    viewModel.notifyListeners();
  }
}
