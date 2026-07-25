import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/available_languages.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewmodel.dart';

class OnboardingTargetLanguageView extends StatelessWidget {
  final OnboardingTargetLanguageViewController viewController;

  const OnboardingTargetLanguageView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<
      OnboardingTargetLanguageViewModel,
      OnboardingTargetLanguageViewController
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
                  AppLocalizations.of(
                    context,
                  )!.onboarding__target_language_title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                          data.targetLanguage ==
                              AvailableLanguages.languageCodes[index].code
                          ? Icon(Icons.check)
                          : null,
                      onTap: () => viewController.onLanguageSelected(
                        AvailableLanguages.languageCodes[index].code,
                      ),
                    ),
                  ),
                ),
                FButton(
                  text: AppLocalizations.of(context)!.common__next,
                  color: FColors.secondary,
                  onPressed: viewController.onNextPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
