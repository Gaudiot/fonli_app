import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewmodel.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingViewController viewController;

  const OnboardingView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<OnboardingViewModel, OnboardingViewController>(
      viewController: viewController,
      builder: (context, data) {
        return ColoredBox(
          color: FColors.primary,
          child: SafeArea(child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
