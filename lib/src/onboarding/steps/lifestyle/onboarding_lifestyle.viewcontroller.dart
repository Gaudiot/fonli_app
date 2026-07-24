import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/types/base_event.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';

class OnboardingLifestyleViewController {
  final EventEmitter<OnboardingStepStatus> emitter;

  OnboardingLifestyleViewController({required this.emitter});

  void onNextPressed(String lifestyle) {
    final trimmed = lifestyle.trim();
    if (trimmed.isEmpty) return;
    FonliUserServer.saveUserLifestyle(lifestyle);
    emitter.emit(.completed);
  }

  void onSkipPressed() {
    emitter.emit(.completed);
  }
}
