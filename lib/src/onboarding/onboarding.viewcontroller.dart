import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.builder.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.builder.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.builder.dart';

enum OnboardingStepStatus { completed }

class OnboardingViewController extends FViewController<OnboardingViewModel> {
  final _stepController = StreamController<OnboardingStepStatus>();
  StreamSubscription<OnboardingStepStatus>? _sub;

  int _currentStep = 0;
  bool _hasStarted = false;

  final List<Widget Function(StreamSink<OnboardingStepStatus> eventStream)>
  _stepsBuilder = [
    (eventStream) =>
        OnboardingTargetLanguageBuilder(eventStream: eventStream).build(),
    (eventStream) =>
        OnboardingBaseLanguageBuilder(eventStream: eventStream).build(),
    (eventStream) =>
        OnboardingLifestyleBuilder(eventStream: eventStream).build(),
  ];

  OnboardingViewController({required super.viewModel});

  @override
  void onInit(BuildContext context) {
    _sub = _stepController.stream.listen((status) {
      if (context.mounted) {
        _handleEvent(context, status);
      }
    });
    _launchCurrentStep(context);
  }

  @override
  void dispose() {
    _sub?.cancel();
    _stepController.close();
    super.dispose();
  }

  void _handleEvent(BuildContext context, OnboardingStepStatus status) {
    switch (status) {
      case .completed:
        _stepCompleted(context);
        break;
    }
  }

  void _stepCompleted(BuildContext context) {
    if (_hasStarted) {
      _currentStep++;
    }

    final isOnboardingFinished = _currentStep >= _stepsBuilder.length;
    if (isOnboardingFinished) {
      exitOnboarding(context);
      return;
    }

    _launchCurrentStep(context);
  }

  void _launchCurrentStep(BuildContext context) {
    final stepBuilder = _stepsBuilder[_currentStep];
    if (_hasStarted) {
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
    _hasStarted = true;
  }

  void exitOnboarding(BuildContext context) {
    localStorage.setBoolean(.onboarded, true);
    NavigationManager.pushNamedAndRemoveAll(context, .exerciseSelection);
  }
}
