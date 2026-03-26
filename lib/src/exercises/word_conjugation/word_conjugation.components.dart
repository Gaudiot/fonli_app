part of './word_conjugation.view.dart';

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
            const Text("Exercise finished"),
            const SizedBox(height: 16),
            Text(
              "You got all conjugations correct! You are a master of the language!",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _CompleteButton(context: context),
          ],
        ),
      ),
    );
  }
}

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
          const SizedBox(height: 32),
          _SomeMistakesResultContent(mistakes: mistakes),
          const SizedBox(height: 16),
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Exercise finished",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green),
            const SizedBox(width: 16),
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
      mainAxisSize: MainAxisSize.min,
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
                    const Icon(Icons.close, color: Colors.red),
                    const SizedBox(width: 8),
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
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: Colors.cyan,
          shape: const StadiumBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onCompleteButtonTap,
            child: const Padding(
              padding: EdgeInsets.symmetric(
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
            const Text(
              "Failed to load exercise",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}
