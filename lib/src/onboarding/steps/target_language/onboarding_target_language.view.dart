import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/available_languages.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/target_language/onboarding_target_language.viewcontroller.dart';

class OnboardingTargetLanguageView extends StatelessWidget {
  final EventEmitter<OnboardingStepStatus> emitter;
  late final OnboardingTargetLanguageViewController vm;

  OnboardingTargetLanguageView({super.key, required this.emitter}) {
    vm = OnboardingTargetLanguageViewController(emitter: emitter);
  }

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
                    onPressed: vm.onNextPressed,
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

class BaseViewModel<T> extends ValueNotifier<T> {
  BaseViewModel({required T value}) : super(value);

  void increment() {
    value = ((value as int) + 1) as T;
  }
}

class BaseView<T> extends StatelessWidget {
  const BaseView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BaseViewModel<int>(value: 0);
    return ValueListenableBuilder(
      valueListenable: viewModel,
      builder: (context, value, child) {
        return const Placeholder();
      },
    );
  }
}
