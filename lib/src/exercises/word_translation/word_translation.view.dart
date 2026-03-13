import 'package:flutter/material.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewmodel.dart';

part 'word_translation.components.dart';

class WordTranslationExerciseView extends StatefulWidget {
  final WordTranslationExerciseType exerciseType;

  const WordTranslationExerciseView({super.key, required this.exerciseType});

  @override
  State<WordTranslationExerciseView> createState() =>
      _WordTranslationExerciseViewState();
}

class _WordTranslationExerciseViewState
    extends State<WordTranslationExerciseView> {
  final WordTranslationExerciseViewModel viewModel =
      WordTranslationExerciseViewModel();

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.fetchWordTranslationExercise(widget.exerciseType);
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

            return state.isExerciseFinished
                ? _ExerciseComplete(
                    questionsQuantity: state.questionsLength,
                    mistakes: state.mistakes,
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: _WordCard(word: state.currentQuestion),
                        ),
                      ),
                      _TranslationInput(
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

class _WordCard extends StatelessWidget {
  final String word;

  const _WordCard({required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(padding: EdgeInsets.all(16), child: Text(word)),
    );
  }
}

class _TranslationInput extends StatelessWidget {
  final Function(String) onSubmitted;
  final TextEditingController controller;

  const _TranslationInput({
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(controller: controller, onSubmitted: onSubmitted),
    );
  }
}
