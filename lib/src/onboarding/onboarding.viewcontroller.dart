import 'package:flutter/widgets.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.view.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.view.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.view.dart';

enum OnboardingStepStatus { inProgress, completed }

class OnboardingViewController {
  final viewModel = OnboardingViewModel();
  final eventEmitter = EventEmitter<OnboardingStepStatus>(value: .inProgress);

  final List<Widget Function(EventEmitter<OnboardingStepStatus> eventEmitter)>
  stepsBuilder = [
    (emitter) => OnboardingTargetLanguageView(emitter: emitter),
    (emitter) => OnboardingBaseLanguageView(emitter: emitter),
    (emitter) => OnboardingLifestyleView(emitter: emitter),
  ];

  void onInit(BuildContext context) {
    final eventListener = EventListener(emitter: eventEmitter);
    eventListener.handler = (status) => _handleEvent(context, status);
    _launchCurrentStep(context);
  }

  void _handleEvent(BuildContext context, OnboardingStepStatus status) {
    switch (status) {
      case .completed:
        _stepCompleted(context);
        break;
      default:
        return;
    }
  }

  void _stepCompleted(BuildContext context) {
    if (viewModel.hasStarted) {
      viewModel.currentStep++;
    }

    final isOnboardingFinished = viewModel.currentStep >= stepsBuilder.length;
    if (isOnboardingFinished) {
      exitOnboarding(context);
      return;
    }

    _launchCurrentStep(context);
  }

  void _launchCurrentStep(BuildContext context) {
    final stepBuilder = stepsBuilder[viewModel.currentStep];
    if (viewModel.hasStarted) {
      NavigationManager.replaceScreen(
        context,
        PopScope(canPop: false, child: stepBuilder(eventEmitter)),
      );
    } else {
      NavigationManager.pushScreen(
        context,
        PopScope(canPop: false, child: stepBuilder(eventEmitter)),
      );
    }
    viewModel.hasStarted = true;
  }

  void exitOnboarding(BuildContext context) {
    NavigationManager.pushNamedAndRemoveAll(context, .exerciseSelection);
  }
}
