import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';

part './exercise_selection.components.dart';

class _ExerciseModel {
  final String title;
  final VoidCallback onTap;

  _ExerciseModel({required this.title, required this.onTap});
}

class ExerciseSelectionView extends StatelessWidget {
  const ExerciseSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ExerciseModel> exercises = [
      _ExerciseModel(
        title: AppLocalizations.of(context)!.exercise_native_to_foreign,
        onTap: () => NavigationManager.goTo(context, .nativeToForeign),
      ),
      _ExerciseModel(
        title: AppLocalizations.of(context)!.exercise_foreign_to_native,
        onTap: () => NavigationManager.goTo(context, .foreignToNative),
      ),
      _ExerciseModel(
        title: AppLocalizations.of(context)!.exercise_conjugation,
        onTap: () => NavigationManager.goTo(context, .wordConjugation),
      ),
      _ExerciseModel(
        title: AppLocalizations.of(context)!.exercise_story,
        onTap: () => NavigationManager.goTo(context, .storyTranslation),
      ),
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        color: FColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              _ExerciseSelectionHeader(),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.select_exercise,
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
                        itemBuilder: (context, index) => _ExerciseSelectionCard(
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
      ),
    );
  }
}

class _ExerciseSelectionHeader extends StatelessWidget {
  const _ExerciseSelectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(children: [_SettingsDisplay()]);
  }
}
