import 'package:flutter/widgets.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.view.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.view.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.view.dart';

class OnboardingViewController {
  int currentStep = 0;

  final List<Widget Function()> stepsBuilder = [
    () => OnboardingTargetLanguageView(),
    () => OnboardingBaseLanguageView(),
    () => OnboardingLifestyleView(),
  ];

  void onInit(BuildContext context) {
    NavigationManager.replaceScreen(context, stepsBuilder[currentStep]());
  }

  /*
  if stepCompleted, move to next step
  */

  void moveToNextStep(BuildContext context) {
    currentStep++;
    if (currentStep >= stepsBuilder.length) {
      exitOnboarding();
      return;
    }

    NavigationManager.replaceScreen(context, stepsBuilder[currentStep]());
  }

  void exitOnboarding() {}
}
