import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.view.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.view.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.builder.dart';

enum OnboardingStepStatus { completed }

class OnboardingViewController {
  final _stepController = StreamController<OnboardingStepStatus>();
  StreamSubscription<OnboardingStepStatus>? _sub;

  final viewModel = OnboardingViewModel();

  final List<Widget Function(StreamSink<OnboardingStepStatus> stepController)>
  stepsBuilder = [
    (eventStream) =>
        OnboardingTargetLanguageBuilder(eventStream: eventStream).build(),
    (eventStream) => OnboardingBaseLanguageView(eventStream: eventStream),
    (eventStream) => OnboardingLifestyleView(eventStream: eventStream),
  ];

  void onInit(BuildContext context) {
    _sub = _stepController.stream.listen((status) {
      if (context.mounted) {
        _handleEvent(context, status);
      }
    });
    _launchCurrentStep(context);
  }

  void dispose() {
    _sub?.cancel();
    _stepController.close();
  }

  void _handleEvent(BuildContext context, OnboardingStepStatus status) {
    switch (status) {
      case .completed:
        _stepCompleted(context);
        break;
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
        PopScope(canPop: false, child: stepBuilder(_stepController.sink)),
      );
    } else {
      NavigationManager.pushScreen(
        context,
        PopScope(canPop: false, child: stepBuilder(_stepController.sink)),
      );
    }
    viewModel.hasStarted = true;
  }

  void exitOnboarding(BuildContext context) {
    localStorage.setBoolean(.onboarded, true);
    NavigationManager.pushNamedAndRemoveAll(context, .exerciseSelection);
  }
}
