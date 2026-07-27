part of 'exercise_selection.view.dart';

class _SettingsDisplay extends StatelessWidget {
  final VoidCallback onTap;

  const _SettingsDisplay({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: FColors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(Icons.settings, color: FColors.black, size: 28),
          splashRadius: 24,
          tooltip: 'User Settings',
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final VoidCallback onTap;
  final LanguageCode baseLanguage;
  final LanguageCode targetLanguage;

  const _LanguageSelector({
    required this.onTap,
    required this.baseLanguage,
    required this.targetLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: FColors.secondary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ValueListenableBuilder(
            valueListenable: LanguageNotifier.instance,
            builder: (context, value, _) {
              return Row(
                children: [
                  CountryFlag.fromCountryCode(
                    value.baseLanguage.countryCode,
                    theme: const ImageTheme(
                      height: 32,
                      width: 32,
                      shape: Circle(),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: FColors.white, size: 16),
                  CountryFlag.fromCountryCode(
                    value.targetLanguage.countryCode,
                    theme: const ImageTheme(
                      height: 32,
                      width: 32,
                      shape: Circle(),
                    ),
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
