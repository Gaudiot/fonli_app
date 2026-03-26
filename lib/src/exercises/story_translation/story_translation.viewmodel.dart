import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/base/http/fonli_server.dart';
import 'package:fonli_app/core/types/exercises.type.dart';
import 'package:fonli_app/src/exercises/story_translation/story_translation.viewstate.dart';

class StoryTranslationExerciseViewModel {
  final StoryTranslationExerciseViewState state =
      StoryTranslationExerciseViewState();

  void fetchStory() async {
    state.isLoading = true;

    final result = await FonliServer.generateStory(
      LanguageNotifier.instance.nativeLanguage,
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (response) {
        state.story = response.story;
      },
      onError: (_) {},
    );
    state.isLoading = false;
  }

  void submitTranslation(String userTranslation) async {
    final trimmed = userTranslation.trim();
    if (trimmed.isEmpty) return;

    state.isLoading = true;

    final request = EvaluateStoryTranslationRequest(
      story: state.story,
      userTranslation: trimmed,
    );

    final result = await FonliServer.evaluateStoryTranslation(
      request,
      LanguageNotifier.instance.nativeLanguage,
      LanguageNotifier.instance.targetLanguage,
    );

    result.when(
      onOk: (response) {
        state.score = response.score;
        state.errors = response.errors;
        state.correctTranslation = response.correctTranslation;
        state.isEvaluated = true;
      },
      onError: (_) {},
    );
    state.isLoading = false;
  }
}
