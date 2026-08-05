import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/language_code.type.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.viewcontroller.dart';
import 'package:fonli_app/src/settings/language_learning_settings/language_learning_settings.viewmodel.dart';

// MARK: - V2

class LanguageLearningSettingsView extends StatelessWidget {
  final LanguageLearningSettingsViewController viewController;

  const LanguageLearningSettingsView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<
      LanguageLearningSettingsViewModel,
      LanguageLearningSettingsViewController
    >(
      appBar: AppBar(
        backgroundColor: FColors.primary,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).settings__language_learning_title,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            NavigationManager.pop(context);
          },
        ),
      ),
      viewController: viewController,
      builder: (context, data) {
        return Container(
          color: FColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: Row(
                    spacing: 16,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context).base_language),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 4),
                                itemCount: LanguageCode.values.length,
                                itemBuilder: (context, index) {
                                  final language = LanguageCode.values[index];
                                  return _LanguageTile(
                                    isSelected: data.baseLanguage == language,
                                    language: language,
                                    onTap: () => viewController
                                        .onBaseLanguageChanged(language),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context).target_language),
                            const SizedBox(height: 8),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 4),
                                itemCount: LanguageCode.values.length,
                                itemBuilder: (context, index) {
                                  final language = LanguageCode.values[index];
                                  return _LanguageTile(
                                    isSelected: data.targetLanguage == language,
                                    language: language,
                                    onTap: () => viewController
                                        .onTargetLanguageChanged(language),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final LanguageCode language;
  final VoidCallback onTap;
  final bool isSelected;

  const _LanguageTile({
    required this.language,
    required this.onTap,
    required this.isSelected,
  });

  Color get _borderColor => isSelected ? FColors.black : FColors.primaryDarkest;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: ShapeDecoration(
          color: FColors.primaryDark,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: _borderColor),
            borderRadius: .all(.circular(4)),
          ),
        ),
        child: Row(
          children: [
            CountryFlag.fromCountryCode(
              language.countryCode,
              theme: const EmojiTheme(),
            ),
            const SizedBox(width: 8),
            Text(language.languageName),
          ],
        ),
      ),
    );
  }
}
