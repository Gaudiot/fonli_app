import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewmodel.dart';

class OnboardingLifestyleView extends StatelessWidget {
  static const int _maxLifestyleLength = 500;

  final OnboardingLifestyleViewController viewController;

  const OnboardingLifestyleView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<
      OnboardingLifestyleViewModel,
      OnboardingLifestyleViewController
    >(
      viewController: viewController,
      builder: (context, data) {
        return Container(
          color: FColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context).onboarding__lifestyle_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: viewController.lifestyleController,
                  maxLines: 5,
                  maxLength: _maxLifestyleLength,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: FColors.primaryLighter,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(
                    context,
                  ).onboarding__lifestyle_description,
                ),
                Spacer(),
                FButton(
                  text: AppLocalizations.of(context).common__next,
                  color: FColors.secondary,
                  onPressed: viewController.onNextPressed,
                  isEnabled: data.canSubmit,
                  isLoading: data.isLoading,
                ),
                TextButton(
                  onPressed: viewController.onSkipPressed,
                  child: Text(AppLocalizations.of(context).common__skip),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
