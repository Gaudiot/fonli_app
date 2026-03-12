part of './exercise_selection.view.dart';

class _ExerciseSelectionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ExerciseSelectionCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
