import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';

class OnboardingLifestyleView extends StatelessWidget {
  const OnboardingLifestyleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FColors.primary,
      child: SafeArea(child: Column(children: [Text('Onboarding Lifestyle')])),
    );
  }
}
