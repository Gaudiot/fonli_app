import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.view.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewmodel.dart';

class OnboardingLifestyleBuilder extends FViewBuilder {
  final StreamSink<OnboardingStepStatus> eventStream;

  const OnboardingLifestyleBuilder({required this.eventStream});

  @override
  Widget build() {
    final viewModel = OnboardingLifestyleViewModel();
    final viewController = OnboardingLifestyleViewController(
      eventStream: eventStream,
      viewModel: viewModel,
    );

    return OnboardingLifestyleView(viewController: viewController);
  }
}
