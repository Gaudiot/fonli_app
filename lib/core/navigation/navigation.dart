import "package:flutter/material.dart";
import "package:fonli_app/src/exercises/exercise_selection.view.dart";
import "package:fonli_app/src/exercises/word_translation/word_translation.view.dart";
import "package:fonli_app/src/exercises/word_translation/word_translation.viewmodel.dart";
import "package:fonli_app/src/language_selection/language_selection.view.dart";

typedef RouteBuilder = Widget Function(BuildContext context);

enum NavigationRoutes {
  exerciseSelection("/exercise-selection"),
  nativeToForeign("/exercise/native-to-foreign"),
  foreignToNative("/exercise/foreign-to-native"),
  wordConjugation("/exercise/word-conjugation"),
  storyTranslation("/exercise/story-translation"),
  languageSelection("/language-selection");

  final String path;

  const NavigationRoutes(this.path);
}

class NavigationManager {
  NavigationManager._internal();

  static String initialRoute = NavigationRoutes.exerciseSelection.path;
  static var _args = <String, dynamic>{};

  static Map<String, RouteBuilder> routesMap() {
    return {
      NavigationRoutes.exerciseSelection.path: (context) =>
          ExerciseSelectionView(),
      NavigationRoutes.nativeToForeign.path: (context) =>
          WordTranslationExerciseView(
            exerciseType: WordTranslationExerciseType.nativeToForeign,
          ),
      NavigationRoutes.foreignToNative.path: (context) =>
          WordTranslationExerciseView(
            exerciseType: WordTranslationExerciseType.foreignToNative,
          ),
      NavigationRoutes.languageSelection.path: (context) =>
          LanguageSelectionView(),
    };
  }

  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void popWithConfirm(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }

  static void goTo(
    BuildContext context,
    NavigationRoutes route, {
    Map<String, String>? args,
  }) {
    _args = args ?? {};
    Navigator.pushNamed(context, route.path);
  }

  static Future<void> goToAndCallBack(
    BuildContext context,
    NavigationRoutes route,
    VoidCallback callback, {
    Map<String, String>? args,
  }) async {
    _args = args ?? {};
    Navigator.pushNamed(context, route.path).then((value) {
      if (value != null && value is bool && value) {
        callback();
      }
    });
  }
}
