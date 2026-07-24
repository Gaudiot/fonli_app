import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/available_languages.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewcontroller.dart';

class OnboardingTargetLanguageView extends StatelessWidget {
  final vm = OnboardingTargetLanguageViewController();

  OnboardingTargetLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FColors.primary,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: vm.viewModel,
            builder: (context, _) {
              return Column(
                children: [
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.onboarding__target_language_title,
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
                            vm.viewModel.targetLanguage ==
                                AvailableLanguages.languageCodes[index].code
                            ? Icon(Icons.check)
                            : null,
                        onTap: () => vm.onLanguageSelected(
                          AvailableLanguages.languageCodes[index].code,
                        ),
                      ),
                    ),
                  ),
                  FButton(
                    text: AppLocalizations.of(context)!.common__next,
                    onPressed: () {},
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.common__skip),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
