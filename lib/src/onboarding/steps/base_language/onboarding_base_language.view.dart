import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/available_languages.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/base_language/onboarding_base_language.viewmodel.dart';

class OnboardingBaseLanguageView extends StatelessWidget {
  final OnboardingBaseLanguageViewController viewController;

  const OnboardingBaseLanguageView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<
      OnboardingBaseLanguageViewModel,
      OnboardingBaseLanguageViewController
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
                  AppLocalizations.of(context)!.onboarding__base_language_title,
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
                          data.baseLanguage ==
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
                  onPressed: viewController.onNextPressed,
                  color: FColors.secondary,
                  text: AppLocalizations.of(context)!.common__next,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
