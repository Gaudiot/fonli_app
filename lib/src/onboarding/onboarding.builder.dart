import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/snackbar/snackbar_messenger.interface.dart';
import 'package:fonli_app/src/onboarding/onboarding.view.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';

class OnboardingBuilder extends FViewBuilder {
  final SnackbarMessenger snackbarMessenger;

  const OnboardingBuilder({required this.snackbarMessenger});

  @override
  Widget build() {
    final viewModel = OnboardingViewModel();
    final viewController = OnboardingViewController(
      viewModel: viewModel,
      snackbarMessenger: snackbarMessenger,
    );

    return OnboardingView(viewController: viewController);
  }
}
