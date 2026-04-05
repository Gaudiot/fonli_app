import 'package:flutter/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'snackbar_messenger.interface.dart';

/// [SnackbarMessenger] backed by [top_snackbar_flutter].
final class TopSnackbarMessenger implements SnackbarMessenger {
  const TopSnackbarMessenger();

  void _show(BuildContext context, Widget snackBar) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;
    showTopSnackBar(overlay, snackBar);
  }

  @override
  void showSuccess(BuildContext context, String message) {
    _show(context, CustomSnackBar.success(message: message));
  }

  @override
  void showError(BuildContext context, String message) {
    _show(context, CustomSnackBar.error(message: message));
  }

  @override
  void showInfo(BuildContext context, String message) {
    _show(context, CustomSnackBar.info(message: message));
  }
}
