import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/core/navigation/navigation.dart';

class SettingsViewController {
  void goToChangeLearningLanguageSettings(BuildContext context) {
    NavigationManager.goTo(context, .languageLearningSettings);
  }

  void goToLifestyleSettings(BuildContext context) {
    NavigationManager.goTo(context, .userLifestyle);
  }

  void logout() {
    AuthSessionNotifier.instance.clear();
  }
}
