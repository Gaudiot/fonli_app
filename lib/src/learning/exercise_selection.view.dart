import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/learning/exercise_selection.viewcontroller.dart';
import 'package:fonli_app/src/learning/exercise_selection.viewmodel.dart';

part 'exercise_selection.components.dart';

class _ExerciseModel {
  final String title;
  final VoidCallback onTap;

  _ExerciseModel({required this.title, required this.onTap});
}

class _ExerciseSelectionHeader extends StatelessWidget {
  final VoidCallback onSettingsTap;
  final VoidCallback onLanguageSelectorTap;

  const _ExerciseSelectionHeader({
    required this.onSettingsTap,
    required this.onLanguageSelectorTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _SettingsDisplay(onTap: onSettingsTap),
        _LanguageSelector(onTap: onLanguageSelectorTap),
      ],
    );
  }
}

class ExerciseSelectionViewV2 extends StatelessWidget {
  final ExerciseSelectionViewController viewController;

  const ExerciseSelectionViewV2({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    final List<_ExerciseModel> exercises = [
      _ExerciseModel(
        title: AppLocalizations.of(context).exercises__vocabulary,
        onTap: () => NavigationManager.goTo(context, .vocabularyExercise),
      ),
      _ExerciseModel(
        title: AppLocalizations.of(context).exercises__verb_conjugation,
        onTap: () => NavigationManager.goTo(context, .verbConjugation),
      ),
      _ExerciseModel(
        title: AppLocalizations.of(context).exercises__story_translation,
        onTap: () => NavigationManager.goTo(context, .storyTranslation),
      ),
    ];

    return FView<ExerciseSelectionViewModel, ExerciseSelectionViewController>(
      viewController: viewController,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: FColors.primary,
          child: SafeArea(
            child: Column(
              children: [
                _ExerciseSelectionHeader(
                  onSettingsTap: () => viewController.onSettingsTap(context),
                  onLanguageSelectorTap: () =>
                      viewController.onLanguageSelectorTap(context),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          AppLocalizations.of(context).exercises__selection,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: exercises.length,
                          itemBuilder: (context, index) =>
                              _ExerciseSelectionCard(
                                title: exercises[index].title,
                                onTap: exercises[index].onTap,
                              ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                        ),
                      ],
                    ),
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
