import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/core/app_info/app_info.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/flags/remote_config/remote_config.dart';
import 'package:fonli_app/core/flags/remote_config/remote_config.interface.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewmodel.dart';

final class SplashViewController extends FViewController<SplashViewModel> {
  SplashViewController({required super.viewModel});

  @override
  void onInit(BuildContext context) {
    super.onInit(context);

    _initialize(context);
  }

  Future<void> _initialize(BuildContext context) async {
    await initFlags();
    await bootstrapApp();
    if (context.mounted) await handleAppStatus(context);
  }

  Future<void> initFlags() async {
    await remoteConfig.init();
  }

  Future<void> bootstrapApp() async {
    await AppInfo.init();
  }

  Future<void> handleAppStatus(BuildContext context) async {
    final isVersionSupported = await checkIfVersionSupported();
    if (!isVersionSupported) {
      if (context.mounted) await routeToVersionGate(context);
      return;
    }

    final isUserAuthenticated = await checkIfUserAuthenticated();
    if (!isUserAuthenticated) {
      if (context.mounted) await routeToAuth(context);
      return;
    }

    if (context.mounted) await routeToHome(context);
  }
}

// MARK: - Private Methods

extension on SplashViewController {
  Future<bool> checkIfUserAuthenticated() async {
    final isAuthenticated = AuthSessionNotifier.instance.isAuthenticated;
    return isAuthenticated;
  }

  Future<bool> checkIfVersionSupported() async {
    final appBuildNumber = AppInfo.buildNumber;
    final minimumRequiredBuilderNumber = await IntegerRemoteConfig
        .minimumBuildNumber
        .value();
    return minimumRequiredBuilderNumber <= appBuildNumber;
  }
}

//MARK: - Routing Methods

extension on SplashViewController {
  Future<void> routeToVersionGate(BuildContext context) async {
    NavigationManager.pushNamedAndRemoveAll(context, .versionGate);
  }

  Future<void> routeToAuth(BuildContext context) async {
    NavigationManager.pushNamedAndRemoveAll(context, .auth);
  }

  Future<void> routeToHome(BuildContext context) async {
    NavigationManager.pushNamedAndRemoveAll(context, .exerciseSelection);
  }
}
