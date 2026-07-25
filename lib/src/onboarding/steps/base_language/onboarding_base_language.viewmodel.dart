import 'package:fonli_app/core/components/base_viewmodel.dart';

class OnboardingBaseLanguageViewModel extends FViewModel {
  final String baseLanguage;
  final String targetLanguage;

  OnboardingBaseLanguageViewModel({
    this.baseLanguage = "pt_BR",
    this.targetLanguage = "en_US",
  });

  OnboardingBaseLanguageViewModel copyWith({
    String? baseLanguage,
    String? targetLanguage,
  }) {
    return OnboardingBaseLanguageViewModel(
      baseLanguage: baseLanguage ?? this.baseLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}
