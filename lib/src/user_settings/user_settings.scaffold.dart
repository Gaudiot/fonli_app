import 'package:flutter/material.dart';

/// Mock feedback surface. Replace with the real scaffold / overlay behavior later.
void showUserSettingsScaffoldMock(
  BuildContext context, {
  required bool success,
  String? message,
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        message ??
            (success
                ? 'Lifestyle saved.'
                : 'Could not save lifestyle.'),
      ),
    ),
  );
}
