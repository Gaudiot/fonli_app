import 'package:flutter/material.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final viewController = OnboardingViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewController.onInit(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: CircularProgressIndicator())),
    );
  }
}
