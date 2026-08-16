import 'package:fonli_app/core/components/base_viewmodel.dart';
import 'package:fonli_app/core/types/language_code.type.dart';

class OnboardingTargetLanguageViewModel extends FViewModel {
  final LanguageCode targetLanguage;

  OnboardingTargetLanguageViewModel({this.targetLanguage = LanguageCode.en_US});

  OnboardingTargetLanguageViewModel copyWith({LanguageCode? targetLanguage}) {
    return OnboardingTargetLanguageViewModel(
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}
