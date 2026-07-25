import 'package:fonli_app/core/components/base_viewmodel.dart';

class OnboardingLifestyleViewModel extends FViewModel {
  final bool isLoading;
  final String lifestyle;

  OnboardingLifestyleViewModel({this.isLoading = false, this.lifestyle = ""});

  bool get canSubmit => lifestyle.trim().isNotEmpty;

  OnboardingLifestyleViewModel copyWith({bool? isLoading, String? lifestyle}) {
    return OnboardingLifestyleViewModel(
      isLoading: isLoading ?? this.isLoading,
      lifestyle: lifestyle ?? this.lifestyle,
    );
  }
}
