part of './exercise_selection.view.dart';

class _LanguageDisplay extends StatelessWidget {
  final double _arrowSize = 32;
  final LanguageNotifier _languageNotifier = LanguageNotifier();

  final ImageTheme _imageTheme = () {
    final double iconSize = 32;

    return ImageTheme(height: iconSize, width: iconSize, shape: Circle());
  }();

  void _openOptions(BuildContext context) {
    NavigationManager.goTo(context, .languageSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: FColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _openOptions(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListenableBuilder(
            listenable: _languageNotifier,
            builder: (context, _) {
              return Row(
                children: [
                  CountryFlag.fromCountryCode(
                    _languageNotifier.nativeLanguage,
                    theme: _imageTheme,
                  ),
                  Icon(Icons.arrow_forward_rounded, size: _arrowSize),
                  CountryFlag.fromCountryCode(
                    _languageNotifier.targetLanguage,
                    theme: _imageTheme,
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
