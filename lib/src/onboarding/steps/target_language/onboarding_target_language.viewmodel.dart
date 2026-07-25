import 'package:fonli_app/core/components/base_viewmodel.dart';

class OnboardingTargetLanguageViewModel extends FViewModel {
  String targetLanguage;

  OnboardingTargetLanguageViewModel({this.targetLanguage = "en_US"});

  OnboardingTargetLanguageViewModel copyWith({String? targetLanguage}) {
    return OnboardingTargetLanguageViewModel(
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}
