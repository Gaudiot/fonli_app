part of 'story_translation.view.dart';

final class _StoryTranslationResult extends StatelessWidget {
  final int score;
  final List<String> errors;
  final String correctTranslation;

  const _StoryTranslationResult({
    required this.score,
    required this.errors,
    required this.correctTranslation,
  });

  bool get hasNoErrors => errors.isEmpty;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.exercise_finished,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _ScoreCard(score: score),
          const SizedBox(height: 24),
          if (!hasNoErrors) ...[
            _ErrorsSection(errors: errors),
            const SizedBox(height: 24),
          ],
          _CorrectTranslationSection(correctTranslation: correctTranslation),
          const SizedBox(height: 24),
          _CompleteButton(context: context),
        ],
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final int score;

  const _ScoreCard({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: FColors.primaryLightest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          const Icon(Icons.star, color: FColors.secondaryDarkest, size: 32),
          const SizedBox(width: 16),
          Text(
            AppLocalizations.of(context)!.translation_score(score, 100),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ErrorsSection extends StatelessWidget {
  final List<String> errors;

  const _ErrorsSection({required this.errors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: .min,
      children: [
        Text(
          AppLocalizations.of(context)!.exercise_mistakes_output,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(maxHeight: 120),
          decoration: BoxDecoration(
            color: FColors.tertiaryLightest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: errors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.close, color: FColors.tertiary, size: 20),
                    const SizedBox(width: 8),
                    Expanded(child: Text(errors[index])),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CorrectTranslationSection extends StatelessWidget {
  final String correctTranslation;

  const _CorrectTranslationSection({required this.correctTranslation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: .min,
      children: [
        Text(
          AppLocalizations.of(context)!.correct_translation,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: FColors.primaryLightest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            correctTranslation,
            style: const TextStyle(fontSize: 16, height: 1.5),
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
          color: FColors.secondary,
          shape: const StadiumBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: onCompleteButtonTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 120),
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

class _FailedToFetchExercise extends StatelessWidget {
  final VoidCallback onRetry;

  const _FailedToFetchExercise({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: .min,
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
