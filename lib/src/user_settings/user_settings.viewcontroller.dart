import 'package:fonli_app/base/http/fonli/fonli_server.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
import 'package:fonli_app/src/user_settings/user_settings.repository.dart';
import 'package:fonli_app/src/user_settings/user_settings.viewmodel.dart';

class UserSettingsViewController {
  UserSettingsViewController({UserSettingsRepository? repository})
    : _repository = repository ?? UserSettingsRepository();

  final UserSettingsRepository _repository;
  final UserSettingsViewModel viewModel = UserSettingsViewModel();

  Future<void> load() async {
    viewModel.initialLoading = true;
    viewModel.hasError = false;
    viewModel.notifyListeners();

    try {
      viewModel.lifestyleText = await _repository.loadLifestyle();
    } on Exception {
      viewModel.hasError = true;
      viewModel.lifestyleText = '';
    } finally {
      viewModel.initialLoading = false;
      viewModel.notifyListeners();
    }
  }

  /// Returns `true` if save succeeded, `false` if it failed.
  Future<bool> save(String lifestyle) async {
    viewModel.saving = true;
    viewModel.notifyListeners();

    try {
      await _repository.saveLifestyle(lifestyle);
      viewModel.lifestyleText = lifestyle;
      return true;
    } on Exception {
      return false;
    } finally {
      viewModel.saving = false;
      viewModel.notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await FonliAuthServer.logout();
    } finally {
      await secureStorage.deleteKey(SecureStorageKeys.accessToken);
      await secureStorage.deleteKey(SecureStorageKeys.refreshToken);
    }
  }
}
