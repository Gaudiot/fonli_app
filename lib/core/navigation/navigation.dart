import "package:flutter/material.dart";
import "package:fonli_app/src/auth/auth.view.dart";
import "package:fonli_app/src/learning/exercise_selection.view.dart";
import "package:fonli_app/src/learning/story_translation/story_translation.view.dart";
import "package:fonli_app/src/learning/word_conjugation/word_conjugation.view.dart";
import "package:fonli_app/src/learning/word_translation/word_translation.view.dart";
import "package:fonli_app/src/learning/word_translation/word_translation.viewcontroller.dart";
import "package:fonli_app/src/settings/language_learning_settings/language_learning_settings.view.dart";
import "package:fonli_app/src/settings/settings.view.dart";
import "package:fonli_app/src/splash/splash.view.dart";
import "package:fonli_app/src/settings/lifestyle_settings/lifestyle_settings.view.dart";

typedef RouteBuilder = Widget Function(BuildContext context);

enum NavigationRoutes {
  splash("/splash"),
  auth("/auth"),
  exerciseSelection("/exercise-selection"),
  nativeToForeign("/exercise/native-to-foreign"),
  foreignToNative("/exercise/foreign-to-native"),
  wordConjugation("/exercise/word-conjugation"),
  storyTranslation("/exercise/story-translation"),
  languageLearningSettings("/language-learning-settings"),
  settings("/settings"),
  userLifestyle("/user-lifestyle");

  final String path;

  const NavigationRoutes(this.path);
}

class NavigationManager {
  NavigationManager._internal();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static String initialRoute = NavigationRoutes.splash.path;
  static var _args = <String, dynamic>{};

  static Map<String, RouteBuilder> routesMap() {
    return {
      NavigationRoutes.splash.path: (context) => const SplashView(),
      NavigationRoutes.auth.path: (context) => const AuthView(),
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
      NavigationRoutes.wordConjugation.path: (context) =>
          const WordConjugationExerciseView(),
      NavigationRoutes.storyTranslation.path: (context) =>
          const StoryTranslationExerciseView(),
      NavigationRoutes.languageLearningSettings.path: (context) =>
          LanguageLearningSettingView(),
      NavigationRoutes.settings.path: (context) => SettingsView(),
      NavigationRoutes.userLifestyle.path: (context) =>
          const UserSettingsView(),
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

  static void replaceWith(
    BuildContext context,
    NavigationRoutes route, {
    Map<String, String>? args,
  }) {
    _args = args ?? {};
    Navigator.pushReplacementNamed(context, route.path);
  }

  static Future<T?> pushNamedAndRemoveAll<T extends Object?>(
    BuildContext context,
    NavigationRoutes route, {
    Map<String, String>? args,
  }) {
    _args = args ?? {};
    return Navigator.pushNamedAndRemoveUntil<T>(
      context,
      route.path,
      (route) => false,
    );
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
