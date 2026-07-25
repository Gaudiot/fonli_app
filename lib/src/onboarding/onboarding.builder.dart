import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/src/onboarding/onboarding.view.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';

class OnboardingBuilder extends FViewBuilder {
  const OnboardingBuilder();

  @override
  Widget build() {
    final viewModel = OnboardingViewModel();
    final viewController = OnboardingViewController(viewModel: viewModel);

    return OnboardingView(viewController: viewController);
  }
}
