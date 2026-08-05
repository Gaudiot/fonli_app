import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/snackbar/snackbar.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/learning/story_translation/story_translation.viewcontroller.dart';

part 'story_translation.components.dart';

class StoryTranslationExerciseView extends StatefulWidget {
  const StoryTranslationExerciseView({super.key});

  @override
  State<StoryTranslationExerciseView> createState() =>
      _StoryTranslationExerciseViewState();
}

class _StoryTranslationExerciseViewState
    extends State<StoryTranslationExerciseView> {
  final StoryTranslationExerciseViewController viewController =
      StoryTranslationExerciseViewController();

  final TextEditingController translationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewController.viewModel.addListener(_onViewModelChanged);
    viewController.fetchStory();
  }

  void _onViewModelChanged() {
    final vm = viewController.viewModel;
    final err = vm.snackbarErrorMessage;
    if (err != null && mounted) {
      vm.clearSnackbarError();
      snackbarMessenger.showError(context, err);
    }
  }

  @override
  void dispose() {
    viewController.viewModel.removeListener(_onViewModelChanged);
    translationController.dispose();
    super.dispose();
  }

  void onSubmitPressed() {
    viewController.submitTranslation(translationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: FColors.black),
          onPressed: () {
            NavigationManager.pop(context);
          },
        ),
      ),
      body: ColoredBox(
        color: FColors.primary,
        child: SafeArea(
          child: ListenableBuilder(
            listenable: viewController.viewModel,
            builder: (context, _) {
              final vm = viewController.viewModel;
              if (vm.isInitialLoading && vm.storyText.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.storyText.isEmpty && !vm.isInitialLoading) {
                return _FailedToFetchExercise(
                  onRetry: () => viewController.fetchStory(),
                );
              }

              if (vm.isEvaluated) {
                return _StoryTranslationResult(
                  score: vm.score,
                  errors: vm.errorsList,
                  correctTranslation: vm.correctTranslationText,
                );
              }

              return Column(
                children: [
                  Expanded(child: _StoryCard(story: vm.storyText)),
                  _TranslationSection(
                    controller: translationController,
                    onSubmit: onSubmitPressed,
                    isSubmitButtonLoading: vm.isSubmitButtonLoading,
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

class _StoryCard extends StatelessWidget {
  final String story;

  const _StoryCard({required this.story});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Card(
        color: FColors.secondary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: .min,
            children: [
              Text(
                AppLocalizations.of(context).translate_story,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: FColors.quaternary,
                ),
              ),
              const SizedBox(height: 16),
              Text(story, style: const TextStyle(fontSize: 18, height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TranslationSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final bool isSubmitButtonLoading;

  const _TranslationSection({
    required this.controller,
    required this.onSubmit,
    required this.isSubmitButtonLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).input_translation,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              filled: true,
              fillColor: FColors.white,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: isSubmitButtonLoading
                ? FColors.secondaryDark
                : FColors.secondary,
            shape: const StadiumBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: isSubmitButtonLoading ? null : onSubmit,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Center(
                  child: isSubmitButtonLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(AppLocalizations.of(context).common__submit),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
