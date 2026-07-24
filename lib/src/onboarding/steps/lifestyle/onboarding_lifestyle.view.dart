import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';

class OnboardingLifestyleView extends StatelessWidget {
  final EventEmitter<OnboardingStepStatus> emitter;

  const OnboardingLifestyleView({super.key, required this.emitter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              Text('Onboarding Lifestyle'),
              Spacer(),
              TextButton(
                onPressed: () {
                  emitter.emit(.completed);
                },
                child: Text(AppLocalizations.of(context)!.common__skip),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
