import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewmodel.dart';

class OnboardingLifestyleViewController
    extends FViewController<OnboardingLifestyleViewModel> {
  final StreamSink<OnboardingStepStatus> eventStream;
  final TextEditingController lifestyleController = TextEditingController();

  OnboardingLifestyleViewController({
    required this.eventStream,
    required super.viewModel,
  }) {
    lifestyleController.addListener(_onLifestyleChanged);
  }

  @override
  void dispose() {
    lifestyleController.removeListener(_onLifestyleChanged);
    lifestyleController.dispose();
    super.dispose();
  }

  void _onLifestyleChanged() {
    value = value.copyWith(lifestyle: lifestyleController.text);
  }

  Future<void> onNextPressed() async {
    if (!value.canSubmit) return;

    value = value.copyWith(isLoading: true);
    await FonliUserServer.saveUserLifestyle(value.lifestyle);
    value = value.copyWith(isLoading: false);
    eventStream.add(.completed);
  }

  void onSkipPressed() {
    eventStream.add(.completed);
  }
}
