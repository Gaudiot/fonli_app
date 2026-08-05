import 'package:flutter/material.dart';
import 'package:fonli_app/core/app_info/app_info.dart';
import 'package:fonli_app/core/components/ui/buttons/list_tile.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/settings/settings.viewcontroller.dart';

class SettingsView extends StatelessWidget {
  final SettingsViewController viewController = SettingsViewController();

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.primary,
      appBar: AppBar(
        backgroundColor: FColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: FColors.black),
          onPressed: () {
            NavigationManager.pop(context);
          },
        ),
        title: Text(AppLocalizations.of(context).settings__title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomScrollView(
            slivers: [
              SliverList.list(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Fonli Settings",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  FonliListTile(
                    title: AppLocalizations.of(
                      context,
                    ).settings__language_learning_title,
                    onPressed: () => viewController
                        .goToChangeLearningLanguageSettings(context),
                  ),
                  const SizedBox(height: 8),
                  FonliListTile(
                    title: AppLocalizations.of(
                      context,
                    ).settings__lifestyle_settings,
                    onPressed: () =>
                        viewController.goToLifestyleSettings(context),
                  ),
                ],
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .end,
                  children: [
                    const SizedBox(height: 48),
                    TextButton(
                      onPressed: viewController.logout,
                      child: Text(
                        AppLocalizations.of(context).logout,
                        style: TextStyle(color: FColors.feedbackIncorrect),
                      ),
                    ),
                    Text("Version: ${AppInfo.version}+${AppInfo.buildNumber}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
