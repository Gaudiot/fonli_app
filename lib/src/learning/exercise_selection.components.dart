part of 'exercise_selection.view.dart';

class _SettingsDisplay extends StatelessWidget {
  const _SettingsDisplay();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: FColors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: IconButton(
          onPressed: () {
            NavigationManager.goTo(context, .settings);
          },
          icon: Icon(Icons.settings, color: FColors.black, size: 28),
          splashRadius: 24,
          tooltip: 'User Settings',
        ),
      ),
    );
  }
}

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
          backgroundColor: FColors.secondary,
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(title, style: TextStyle(color: FColors.black)),
          ),
        ),
      ),
    );
  }
}
