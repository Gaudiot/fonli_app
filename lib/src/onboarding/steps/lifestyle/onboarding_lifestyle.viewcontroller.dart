import 'dart:async';

import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewmodel.dart';

class OnboardingLifestyleViewController {
  final StreamSink<OnboardingStepStatus> eventStream;
  final viewModel = OnboardingLifestyleViewModel();

  OnboardingLifestyleViewController({required this.eventStream});

  void onNextPressed(String lifestyle) async {
    final trimmed = lifestyle.trim();
    if (trimmed.isEmpty) return;

    viewModel.isLoading = true;
    await FonliUserServer.saveUserLifestyle(lifestyle);
    viewModel.isLoading = false;
    eventStream.add(.completed);
  }

  void onSkipPressed() {
    eventStream.add(.completed);
  }
}
