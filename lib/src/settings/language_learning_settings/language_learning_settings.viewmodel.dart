import 'package:fonli_app/core/components/base_viewmodel.dart';
import 'package:fonli_app/core/types/language_code.type.dart';

class LanguageLearningSettingsViewModel extends FViewModel {
  final LanguageCode baseLanguage;
  final LanguageCode targetLanguage;

  LanguageLearningSettingsViewModel({
    this.baseLanguage = .pt_BR,
    this.targetLanguage = .en_US,
  });

  LanguageLearningSettingsViewModel copyWith({
    LanguageCode? baseLanguage,
    LanguageCode? targetLanguage,
  }) {
    return LanguageLearningSettingsViewModel(
      baseLanguage: baseLanguage ?? this.baseLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}
