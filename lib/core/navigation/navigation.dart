import "package:flutter/material.dart";
import "package:fonli_app/core/components/snackbar/snackbar.dart";
import "package:fonli_app/src/auth/auth.builder.dart";
import "package:fonli_app/src/bootstrap/splash/splash.builder.dart";
import "package:fonli_app/src/bootstrap/version_gate/version_gate.builder.dart";
import "package:fonli_app/src/learning/exercise_selection.builder.dart";
import "package:fonli_app/src/learning/story_translation/story_translation.view.dart";
import "package:fonli_app/src/learning/vocabulary/vocabulary.builder.dart";
import "package:fonli_app/src/learning/word_conjugation/word_conjugation.view.dart";
import "package:fonli_app/src/onboarding/onboarding.builder.dart";
import "package:fonli_app/src/settings/language_learning_settings/language_learning_settings.builder.dart";
import "package:fonli_app/src/settings/settings.view.dart";
import "package:fonli_app/src/settings/lifestyle_settings/lifestyle_settings.view.dart";

enum NavigationRoutes {
  splash("/bootstrap/splash"),
  versionGate("/bootstrap/version-gate"),
  auth("/auth"),
  onboarding("/onboarding"),
  exerciseSelection("/exercise-selection"),
  vocabularyExercise("/exercise/vocabulary"),
  verbConjugation("/exercise/verb-conjugation"),
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

  static Map<String, WidgetBuilder> routesMap() {
    return {
      NavigationRoutes.splash.path: (context) => SplashBuilder().build(),
      NavigationRoutes.auth.path: (context) =>
          AuthBuilder(snackbarMessenger: snackbarMessenger).build(),
      NavigationRoutes.onboarding.path: (context) =>
          OnboardingBuilder(snackbarMessenger: snackbarMessenger).build(),
      NavigationRoutes.exerciseSelection.path: (context) =>
          ExerciseSelectionBuilder().build(),
      NavigationRoutes.vocabularyExercise.path: (context) =>
          VocabularyExerciseBuilder().build(),
      NavigationRoutes.verbConjugation.path: (context) =>
          const WordConjugationExerciseView(),
      NavigationRoutes.storyTranslation.path: (context) =>
          const StoryTranslationExerciseView(),
      NavigationRoutes.languageLearningSettings.path: (context) =>
          LanguageLearningSettingsBuilder().build(),
      NavigationRoutes.settings.path: (context) => SettingsView(),
      NavigationRoutes.userLifestyle.path: (context) =>
          const UserSettingsView(),
      NavigationRoutes.versionGate.path: (context) =>
          VersionGateBuilder().build(),
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

  static void pushScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  static void replaceScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
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
