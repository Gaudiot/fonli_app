import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';
import 'package:fonli_app/src/exercises/word_conjugation/word_conjugation.viewcontroller.dart';

part 'word_conjugation.components.dart';

class WordConjugationExerciseView extends StatefulWidget {
  const WordConjugationExerciseView({super.key});

  @override
  State<WordConjugationExerciseView> createState() =>
      _WordConjugationExerciseViewState();
}

class _WordConjugationExerciseViewState
    extends State<WordConjugationExerciseView> {
  final WordConjugationExerciseViewController viewController =
      WordConjugationExerciseViewController();

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewController.fetchWordConjugationExercise();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void onAnswerSubmit() {
    viewController.submitAnswer(answerController.text);
    answerController.clear();
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
              if (vm.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.questionsLength == 0) {
                return _FailedToFetchExercise(
                  onRetry: () => viewController.fetchWordConjugationExercise(),
                );
              }

              return vm.isExerciseFinished
                  ? _ExerciseComplete(
                      questionsQuantity: vm.questionsLength,
                      mistakes: vm.mistakes,
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: _ConjugationCard(
                              word: vm.word,
                              tense: vm.tense,
                              prompt: vm.currentPrompt,
                            ),
                          ),
                        ),
                        _ConjugationInput(
                          controller: answerController,
                          onSubmitted: onAnswerSubmit,
                          onSubmitButtonPressed: onAnswerSubmit,
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

class _ConjugationCard extends StatelessWidget {
  final String word;
  final String tense;
  final String prompt;

  const _ConjugationCard({
    required this.word,
    required this.tense,
    required this.prompt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: FColors.secondary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              word,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              tense,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Conjugate for: $prompt",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConjugationInput extends StatelessWidget {
  final VoidCallback onSubmitted;
  final TextEditingController controller;
  final VoidCallback onSubmitButtonPressed;

  const _ConjugationInput({
    required this.onSubmitted,
    required this.controller,
    required this.onSubmitButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => onSubmitted(),
              maxLines: 1,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                hintText: 'Type the conjugation...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: FColors.secondary,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onSubmitButtonPressed,
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                child: const Icon(Icons.send_rounded, color: FColors.black),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
