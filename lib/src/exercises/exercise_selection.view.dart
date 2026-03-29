import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';

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
        title: "Native to Foreign",
        onTap: () => NavigationManager.goTo(context, .nativeToForeign),
      ),
      _ExerciseModel(
        title: "Foreign to Native",
        onTap: () => NavigationManager.goTo(context, .foreignToNative),
      ),
      _ExerciseModel(
        title: "Word Conjugation",
        onTap: () => NavigationManager.goTo(context, .wordConjugation),
      ),
      _ExerciseModel(
        title: "Story Translation",
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
                        'Select an exercise:',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [_LanguageDisplay()],
    );
  }
}
