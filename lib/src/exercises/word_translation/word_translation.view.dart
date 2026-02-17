import 'package:flutter/material.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewmodel.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation.viewstate.dart';
import 'package:fonli_app/src/exercises/word_translation/word_translation_card.component.dart';

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
      WordTranslationExerciseViewModel(
        exerciseType: WordTranslationExerciseType.nativeToForeign,
        state: WordTranslationExerciseViewState(),
      );

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.state,
      builder: (context, snapshot) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => _WordTranslationQuestion(
                  word: viewModel.state.questions[index].word,
                  translation: viewModel.state.questions[index].translation,
                  isAnswerHidden: viewModel.state.areAnswersHidden,
                  answerController: viewModel.state.answerControllers[index],
                  isCorrect: viewModel.state.isCorrect[index],
                ),
                separatorBuilder: (_, _) => const SizedBox(height: 32),
                itemCount: viewModel.state.questions.length,
              ),
            ),
            ElevatedButton(
              onPressed: () => viewModel.evaluateAnswers(),
              child: Text("Check"),
            ),
          ],
        );
      },
    );
  }
}

class _WordTranslationQuestion extends StatelessWidget {
  final String word;
  final String translation;
  final bool isAnswerHidden;
  final TextEditingController answerController;
  final bool? isCorrect;

  const _WordTranslationQuestion({
    required this.word,
    required this.translation,
    required this.isAnswerHidden,
    required this.answerController,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WordTranslationCard(
          word: word,
          translation: translation,
          isAnswerHidden: isAnswerHidden,
          isCorrect: isCorrect,
        ),
        SizedBox(height: 16),
        TextField(
          controller: answerController,
          decoration: InputDecoration(hintText: "Translate \"$word\""),
        ),
      ],
    );
  }
}
