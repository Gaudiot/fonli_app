import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.view.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageBuilder extends FViewBuilder {
  final StreamSink<OnboardingStepStatus> eventStream;

  const OnboardingBaseLanguageBuilder({required this.eventStream});

  @override
  Widget build() {
    final viewModel = OnboardingBaseLanguageViewModel();
    final viewController = OnboardingBaseLanguageViewController(
      eventStream: eventStream,
      viewModel: viewModel,
    );

    return OnboardingBaseLanguageView(viewController: viewController);
  }
}
