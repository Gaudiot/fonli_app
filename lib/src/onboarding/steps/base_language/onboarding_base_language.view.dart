import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/available_languages.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:country_flags/country_flags.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewcontroller.dart';

class OnboardingBaseLanguageView extends StatefulWidget {
  final StreamSink<OnboardingStepStatus> eventStream;
  late final OnboardingBaseLanguageViewController viewController;

  OnboardingBaseLanguageView({super.key, required this.eventStream}) {
    viewController = OnboardingBaseLanguageViewController(
      eventStream: eventStream,
    );
  }

  @override
  State<OnboardingBaseLanguageView> createState() =>
      _OnboardingBaseLanguageViewState();
}

class _OnboardingBaseLanguageViewState
    extends State<OnboardingBaseLanguageView> {
  @override
  Widget build(BuildContext context) {
    final viewController = widget.viewController;

    return ListenableBuilder(
      listenable: viewController.viewModel,
      builder: (context, _) {
        final vm = viewController.viewModel;

        return Scaffold(
          body: Container(
            color: FColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.onboarding__base_language_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: AvailableLanguages.languageCodes.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CountryFlag.fromCountryCode(
                          AvailableLanguages.getCountryCodes(
                            AvailableLanguages.languageCodes[index],
                          ),
                        ),
                        title: Text(
                          AvailableLanguages.getLanguageName(
                            AvailableLanguages.languageCodes[index],
                          ),
                        ),
                        trailing:
                            vm.baseLanguage ==
                                AvailableLanguages.languageCodes[index].code
                            ? Icon(Icons.check)
                            : null,
                        onTap: () {
                          setState(() {
                            vm.baseLanguage =
                                AvailableLanguages.languageCodes[index].code;
                          });
                        },
                      ),
                    ),
                  ),
                  FButton(
                    onPressed: viewController.onNextPressed,
                    color: FColors.secondary,
                    text: AppLocalizations.of(context)!.common__next,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
