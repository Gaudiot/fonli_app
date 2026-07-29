import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_view.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/components/ui/if_else_widget.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.viewcontroller.dart';
import 'package:fonli_app/src/learning/vocabulary/vocabulary.viewmodel.dart';

class VocabularyExerciseView extends StatelessWidget {
  final VocabularyViewController viewController;

  const VocabularyExerciseView({super.key, required this.viewController});

  @override
  Widget build(BuildContext context) {
    return FView<VocabularyViewModel, VocabularyViewController>(
      appBar: AppBar(
        backgroundColor: FColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => viewController.onBackPressed(context),
        ),
      ),
      viewController: viewController,
      builder: (context, data) {
        return Container(
          color: FColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SafeArea(
            child: IfElseWidget(
              condition: data.isLoading,
              ifChild: (_) => _Loading(),
              elseChild: (_) => IfElseWidget(
                condition: data.hasError,
                ifChild: (_) => _Error(onRetry: viewController.onRetryPressed),
                elseChild: (_) => IfElseWidget(
                  condition: data.hasCompletedExercise,
                  ifChild: (_) => _ResultPanel(
                    questionsQuantity: data.questions.length,
                    userMistakes: data.wrongUserAnswers,
                    onComplete: () => viewController.onCompletePressed(context),
                  ),
                  elseChild: (_) => _VocabularyExercise(
                    didUserSubmitAnswer: data.didUserSubmitAnswer,
                    userAnswerController: viewController.userAnswerController,
                    question: data.questions[data.currentQuestionIndex],
                    isAnswerCorrect: data.isUserAnswerCorrect,
                    onAnswerSubmitted: viewController.onUserAnswerSubmit,
                    onNextQuestion: viewController.onNextQuestion,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// MARK: - Loading

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: .center,
        mainAxisSize: .max,
        children: [CircularProgressIndicator(), Text("Loading...")],
      ),
    );
  }
}

// MARK: - Error

class _Error extends StatelessWidget {
  final VoidCallback onRetry;

  const _Error({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Text("Error"),
            const SizedBox(height: 16),
            FButton(
              color: FColors.secondary,
              text: AppLocalizations.of(context)!.common__retry,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

// MARK: - Vocabulary Exercise

class _VocabularyExercise extends StatelessWidget {
  final VocabularyQuestion question;
  final VoidCallback onAnswerSubmitted;
  final VoidCallback onNextQuestion;
  final bool isAnswerCorrect;
  final bool didUserSubmitAnswer;
  final TextEditingController userAnswerController;

  const _VocabularyExercise({
    required this.question,
    required this.onAnswerSubmitted,
    required this.onNextQuestion,
    required this.isAnswerCorrect,
    required this.didUserSubmitAnswer,
    required this.userAnswerController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: _QuestionCard(
              word: question.word,
              answer: question.answer,
              isUserAnswerCorrect: isAnswerCorrect,
              didUserSubmitAnswer: didUserSubmitAnswer,
            ),
          ),
        ),
        IfElseWidget(
          condition: didUserSubmitAnswer,
          ifChild: (_) => FButton(
            text: AppLocalizations.of(context)!.common__next,
            onPressed: onNextQuestion,
          ),
          elseChild: (_) => Row(
            children: [
              Expanded(
                child: TextField(
                  controller: userAnswerController,
                  onSubmitted: (_) => onAnswerSubmitted(),
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
              Container(
                decoration: BoxDecoration(
                  color: FColors.secondary,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: IconButton(
                  onPressed: onAnswerSubmitted,
                  icon: Icon(Icons.send),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String word;
  final String answer;
  final bool didUserSubmitAnswer;
  final bool isUserAnswerCorrect;

  const _QuestionCard({
    required this.word,
    required this.answer,
    required this.didUserSubmitAnswer,
    required this.isUserAnswerCorrect,
  });

  Color get cardColor {
    if (!didUserSubmitAnswer) return FColors.secondary;
    if (isUserAnswerCorrect) return FColors.feedbackCorrect;
    return FColors.feedbackIncorrect;
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
            ...[if (didUserSubmitAnswer) Text("Answer: $answer")],
          ],
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  final int questionsQuantity;
  final List<VocabularyMistake> userMistakes;
  final VoidCallback onComplete;

  const _ResultPanel({
    required this.userMistakes,
    required this.onComplete,
    required this.questionsQuantity,
  });

  int get correctAnswersQuantity {
    return questionsQuantity - userMistakes.length;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Altura disponível da tela menos os paddings e widgets fixos
        // Aqui supomos que o espaço usado acima (cabeçalho, textos, botões) é cerca de 280px;
        // Ajuste conforme necessário para seu layout.
        final double mistakesListMaxHeight =
            constraints.maxHeight - 24 - 36 - 32 - 28 - 56 - 50 - 24;
        // 24 (padding top) + 36 (title+row) + 32 (sizedbox) + 28 (mistakes title) + 56 (aprox. button) + 50 (outras margens)
        return Column(
          children: [
            SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.exercise_finished,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisSize: .min,
              children: [
                const Icon(
                  Icons.check_circle_outline_outlined,
                  color: FColors.black,
                ),
                SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.exercise_mistakes(
                    correctAnswersQuantity,
                    questionsQuantity,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              AppLocalizations.of(context)!.exercise_mistakes_output,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: FColors.black),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: mistakesListMaxHeight > 200
                        ? mistakesListMaxHeight
                        : 200, // nunca menor do que 200
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: userMistakes.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return _Mistake(
                        word: userMistakes[index].word,
                        userAnswer: userMistakes[index].userAnswer,
                        correctAnswer: userMistakes[index].correctAnswer,
                      );
                    },
                  ),
                ),
              ),
            ),
            Spacer(),
            FButton(
              text: AppLocalizations.of(context)!.common__complete,
              onPressed: onComplete,
            ),
          ],
        );
      },
    );
  }
}

class _Mistake extends StatelessWidget {
  final String word;
  final String userAnswer;
  final String correctAnswer;

  const _Mistake({
    required this.word,
    required this.userAnswer,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: FColors.primaryLighter,
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          Text(userAnswer, style: TextStyle(color: FColors.feedbackIncorrect)),
          Text(correctAnswer, style: TextStyle(color: Colors.green)),
        ],
      ),
    );
  }
}
