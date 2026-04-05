/// Snackbar abstraction: [SnackbarMessenger] + default implementation.
library;

export 'snackbar_messenger.interface.dart';
export 'top_snackbar_messenger.dart';

import 'snackbar_messenger.interface.dart';
import 'top_snackbar_messenger.dart';

/// Default messenger; inject another [SnackbarMessenger] in tests or if you replace the impl.
final SnackbarMessenger snackbarMessenger = const TopSnackbarMessenger();
