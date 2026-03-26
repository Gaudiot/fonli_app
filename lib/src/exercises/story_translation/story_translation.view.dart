import 'package:flutter/material.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/exercises/story_translation/story_translation.viewmodel.dart';

part 'story_translation.components.dart';

class StoryTranslationExerciseView extends StatefulWidget {
  const StoryTranslationExerciseView({super.key});

  @override
  State<StoryTranslationExerciseView> createState() =>
      _StoryTranslationExerciseViewState();
}

class _StoryTranslationExerciseViewState
    extends State<StoryTranslationExerciseView> {
  final StoryTranslationExerciseViewModel viewModel =
      StoryTranslationExerciseViewModel();

  final TextEditingController translationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.fetchStory();
  }

  @override
  void dispose() {
    translationController.dispose();
    super.dispose();
  }

  void onSubmitPressed() {
    viewModel.submitTranslation(translationController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel.state,
          builder: (context, _) {
            final state = viewModel.state;
            if (state.isLoading && state.story.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.story.isEmpty && !state.isLoading) {
              return _FailedToFetchExercise(
                onRetry: () => viewModel.fetchStory(),
              );
            }

            if (state.isEvaluated) {
              return _StoryTranslationResult(
                score: state.score,
                errors: state.errors,
                correctTranslation: state.correctTranslation,
              );
            }

            return Column(
              children: [
                Expanded(
                  child: _StoryCard(story: state.story),
                ),
                _TranslationSection(
                  controller: translationController,
                  onSubmit: onSubmitPressed,
                  isLoading: state.isLoading,
                ),
              ],
            );
          },
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Translate this story:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                story,
                style: const TextStyle(fontSize: 18, height: 1.5),
              ),
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
  final bool isLoading;

  const _TranslationSection({
    required this.controller,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Type your translation here...",
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: isLoading ? null : onSubmit,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text("Submit translation"),
          ),
        ],
      ),
    );
  }
}
