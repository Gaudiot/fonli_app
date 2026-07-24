import 'package:fonli_app/core/components/base_viewstate.dart';

class OnboardingViewModel extends BaseViewState {
  int _currentStep = 0;

  int get currentStep => _currentStep;
  set currentStep(int value) {
    _currentStep = value;
    notifyListeners();
  }
}
