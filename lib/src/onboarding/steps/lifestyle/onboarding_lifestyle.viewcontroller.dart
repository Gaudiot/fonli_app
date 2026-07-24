import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewmodel.dart';

class OnboardingLifestyleViewController {
  final EventEmitter<OnboardingStepStatus> emitter;
  final viewModel = OnboardingLifestyleViewModel();

  OnboardingLifestyleViewController({required this.emitter});

  void onNextPressed(String lifestyle) async {
    final trimmed = lifestyle.trim();
    if (trimmed.isEmpty) return;

    viewModel.isLoading = true;
    await FonliUserServer.saveUserLifestyle(lifestyle);
    viewModel.isLoading = false;
    emitter.emit(.completed);
  }

  void onSkipPressed() {
    emitter.emit(.completed);
  }
}
