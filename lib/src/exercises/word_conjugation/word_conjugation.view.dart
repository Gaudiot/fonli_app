import 'package:flutter/material.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';
import 'package:fonli_app/src/exercises/word_conjugation/word_conjugation.viewmodel.dart';

part 'word_conjugation.components.dart';

class WordConjugationExerciseView extends StatefulWidget {
  const WordConjugationExerciseView({super.key});

  @override
  State<WordConjugationExerciseView> createState() =>
      _WordConjugationExerciseViewState();
}

class _WordConjugationExerciseViewState extends State<WordConjugationExerciseView> {
  final WordConjugationExerciseViewModel viewModel =
      WordConjugationExerciseViewModel();

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.fetchWordConjugationExercise();
  }

  void onAnswerSubmit(String answer) {
    viewModel.submitAnswer(answer);
    answerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel.state,
          builder: (context, _) {
            final state = viewModel.state;
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.questionsLength == 0) {
              return _FailedToFetchExercise(
                onRetry: () => viewModel.fetchWordConjugationExercise(),
              );
            }

            return state.isExerciseFinished
                ? _ExerciseComplete(
                    questionsQuantity: state.questionsLength,
                    mistakes: state.mistakes,
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: _ConjugationCard(
                            word: state.word,
                            tense: state.tense,
                            prompt: state.currentPrompt,
                          ),
                        ),
                      ),
                      _ConjugationInput(
                        controller: answerController,
                        onSubmitted: onAnswerSubmit,
                      ),
                    ],
                  );
          },
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
  final Function(String) onSubmitted;
  final TextEditingController controller;

  const _ConjugationInput({
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          hintText: "Type the conjugation...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
