part of 'word_translation.view.dart';

final class _ExerciseComplete extends StatelessWidget {
  final int questionsQuantity;
  final List<UserMistake> mistakes;

  const _ExerciseComplete({
    required this.questionsQuantity,
    required this.mistakes,
  });

  int get correctAnswersQuantity => questionsQuantity - mistakes.length;
  bool get hasNoMistakes => mistakes.isEmpty;

  @override
  Widget build(BuildContext context) {
    return hasNoMistakes
        ? const _NoMistakesResult()
        : _SomeMistakesResult(
            mistakes: mistakes,
            questionsQuantity: questionsQuantity,
          );
  }
}

// MARK: - Exercise Completed Perfect

final class _NoMistakesResult extends StatelessWidget {
  const _NoMistakesResult();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.exercise_finished),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.exercise_no_mistake,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _CompleteButton(context: context),
          ],
        ),
      ),
    );
  }
}

// MARK: - Exercise Completed with Mistakes

final class _SomeMistakesResult extends StatelessWidget {
  final List<UserMistake> mistakes;
  final int questionsQuantity;

  const _SomeMistakesResult({
    required this.mistakes,
    required this.questionsQuantity,
  });

  int get correctAnswersQuantity => questionsQuantity - mistakes.length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _SomeMistakesResultHeader(
            correctAnswersQuantity: correctAnswersQuantity,
            questionsQuantity: questionsQuantity,
          ),
          SizedBox(height: 32),
          _SomeMistakesResultContent(mistakes: mistakes),
          SizedBox(height: 16),
          _CompleteButton(context: context),
        ],
      ),
    );
  }
}

class _SomeMistakesResultHeader extends StatelessWidget {
  final int correctAnswersQuantity;
  final int questionsQuantity;

  const _SomeMistakesResultHeader({
    required this.correctAnswersQuantity,
    required this.questionsQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
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
            SizedBox(width: 16),
            Text(
              AppLocalizations.of(
                context,
              )!.exercise_mistakes(correctAnswersQuantity, questionsQuantity),
            ),
          ],
        ),
      ],
    );
  }
}

class _SomeMistakesResultContent extends StatelessWidget {
  final List<UserMistake> mistakes;

  const _SomeMistakesResultContent({required this.mistakes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.exercise_mistakes_output,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 270),
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: FColors.black),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: mistakes.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final mistake = mistakes[index];
                  return _Teste(
                    word: mistake.word,
                    userAnswer: mistake.userAnswer,
                    correctAnswer: mistake.correctAnswer,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Teste extends StatelessWidget {
  final String word;
  final String userAnswer;
  final String correctAnswer;

  const _Teste({
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

// MARK: - Complete Button

class _CompleteButton extends StatelessWidget {
  final BuildContext context;
  const _CompleteButton({required this.context});

  void onCompleteButtonTap() {
    NavigationManager.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: FColors.secondary,
          shape: const StadiumBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onCompleteButtonTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Center(
                child: Text(AppLocalizations.of(context)!.complete),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - View Status

class _FailedToFetchExercise extends StatelessWidget {
  final VoidCallback onRetry;

  const _FailedToFetchExercise({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.exercise_load_fail,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context)!.common__retry),
            ),
          ],
        ),
      ),
    );
  }
}
