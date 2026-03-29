import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';
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

  void onAnswerSubmit() {
    final answer = answerController.text;
    viewModel.submitAnswer(answer);
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

class _WordCard extends StatelessWidget {
  final String word;

  const _WordCard({required this.word});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: FColors.secondary,
      child: Padding(padding: EdgeInsets.all(16), child: Text(word)),
    );
  }
}

class _TranslationInput extends StatelessWidget {
  final VoidCallback onSubmitted;
  final TextEditingController controller;
  final VoidCallback onSubmitButtonPressed;

  const _TranslationInput({
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
                hintText: 'insert translation',
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
