import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/snackbar/snackbar.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/components/ui/if_else_widget.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/types/custom/custom_types.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/learning/word_translation/word_translation.viewcontroller.dart';

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
  final WordTranslationExerciseViewController viewController =
      WordTranslationExerciseViewController();

  final TextEditingController answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewController.viewModel.addListener(_onViewModelChanged);
    viewController.fetchWordTranslationExercise(widget.exerciseType);
  }

  @override
  void dispose() {
    viewController.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    final vm = viewController.viewModel;
    final err = vm.snackbarErrorMessage;
    if (err != null && mounted) {
      vm.clearSnackbarError();
      snackbarMessenger.showError(context, err);
    }
  }

  void onAnswerSubmit() {
    final answer = answerController.text;
    viewController.submitAnswer(answer);
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
                  onRetry: () => viewController.fetchWordTranslationExercise(
                    widget.exerciseType,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: vm.isExerciseFinished
                    ? _ExerciseComplete(
                        questionsQuantity: vm.questionsLength,
                        mistakes: vm.mistakes,
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: _WordCard(
                                word: vm.currentQuestion,
                                answer: vm.currentAnswer,
                                isAnswerCorrect: vm.isAnswerCorrect,
                                isAnswerSubmitted: vm.currentAnswerSubmitted,
                              ),
                            ),
                          ),
                          IfElseWidget(
                            ifChild: NextQuestionButton(
                              onPressed: viewController.moveToNextQuestion,
                            ),
                            elseChild: _TranslationInput(
                              controller: answerController,
                              onSubmitted: onAnswerSubmit,
                              onSubmitButtonPressed: onAnswerSubmit,
                            ),
                            condition: vm.currentAnswerSubmitted,
                          ),
                        ],
                      ),
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
  final String answer;
  final bool isAnswerCorrect;
  final bool isAnswerSubmitted;

  const _WordCard({
    required this.word,
    required this.answer,
    required this.isAnswerCorrect,
    required this.isAnswerSubmitted,
  });

  Color get cardColor {
    if (isAnswerSubmitted) {
      return isAnswerCorrect
          ? FColors.feedbackCorrect
          : FColors.feedbackIncorrect;
    }
    return FColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(word),
            ...[if (isAnswerSubmitted) Text("Answer: $answer")],
          ],
        ),
      ),
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
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.insert_translation,
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

class NextQuestionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextQuestionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FButton(
      text: AppLocalizations.of(context)!.common__next,
      onPressed: onPressed,
      color: FColors.secondary,
    );
  }
}
