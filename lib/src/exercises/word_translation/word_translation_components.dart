part of './word_translation.view.dart';

final class _ExerciseComplete extends StatelessWidget {
  final int questionsQuantity;
  final List<Pair<String, String>> mistakes;

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

// MARK: - Exercise Completed Perfectly

final class _NoMistakesResult extends StatelessWidget {
  const _NoMistakesResult();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Exercise finished"),
        Text("You got all answers correct! You are a master of the language!"),
      ],
    );
  }
}

// MARK: - Exercise Completed with Mistakes

final class _SomeMistakesResult extends StatelessWidget {
  final List<Pair<String, String>> mistakes;
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
          "Exercise finished",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: .min,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green),
            SizedBox(width: 16),
            Text(
              "You got $correctAnswersQuantity out of $questionsQuantity correct",
            ),
          ],
        ),
      ],
    );
  }
}

class _SomeMistakesResultContent extends StatelessWidget {
  final List<Pair<String, String>> mistakes;

  const _SomeMistakesResultContent({required this.mistakes});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        Text(
          "Here are your mistakes:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 100,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.cyan.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              itemCount: mistakes.length,
              itemBuilder: (context, index) {
                final pair = mistakes[index];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: Colors.red),
                    SizedBox(width: 8),
                    Text('${pair.first} → ${pair.second}'),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

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
          color: Colors.cyan,
          shape: const StadiumBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onCompleteButtonTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 120,
              ),
              child: Center(child: Text("Complete")),
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - View Status

class _FailedToFetchExercise extends StatelessWidget {
  const _FailedToFetchExercise();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _LoadingExercise extends StatelessWidget {
  const _LoadingExercise();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
