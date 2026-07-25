import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.view.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageBuilder extends FViewBuilder {
  final StreamSink<OnboardingStepStatus> eventStream;

  const OnboardingTargetLanguageBuilder({required this.eventStream});

  @override
  Widget build() {
    final viewModel = OnboardingTargetLanguageViewModel();
    final viewController = OnboardingTargetLanguageViewController(
      eventStream: eventStream,
      viewModel: viewModel,
    );

    return OnboardingTargetLanguageView(viewController: viewController);
  }
}
