import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_LanguageDisplay()],
                ),
                SizedBox(height: 16),
                Text(
                  'Select an exercise:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
