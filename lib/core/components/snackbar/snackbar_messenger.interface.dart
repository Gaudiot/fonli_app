import 'package:flutter/widgets.dart';

abstract interface class SnackbarMessenger {
  void showSuccess(BuildContext context, String message);

  void showError(BuildContext context, String message);

  void showInfo(BuildContext context, String message);
}
