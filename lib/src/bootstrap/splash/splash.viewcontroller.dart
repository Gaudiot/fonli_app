import 'package:flutter/material.dart';
import 'package:fonli_app/core/app_info/app_info.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/flags/dynamic_config.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/bootstrap/splash/splash.viewmodel.dart';

final class SplashViewController extends FViewController<SplashViewModel> {
  SplashViewController({required super.viewModel});

  @override
  void onInit(BuildContext context) {
    // TODO: implement onInit
    super.onInit(context);

    bootstrapApp().then((_) => handleAppStatus(context));
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
    return true;
  }

  Future<bool> checkIfVersionSupported() async {
    final appBuildNumber = AppInfo.buildNumber;
    final minimumRequiredBuilderNumber = await IntegerDynamicConfig
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

// final class SplashViewController {
//   final SplashViewModel viewModel = SplashViewModel();

//   void onInit(BuildContext context) async {
//     final isAuthenticated = await _hasUserAuthenticatedBefore();

//     if (!context.mounted) return;

//     isAuthenticated
//         ? _navigateToExerciseSelection(context)
//         : _navigateToAuth(context);
//   }

//   Future<bool> _hasUserAuthenticatedBefore() async {
//     final accessToken = await AuthSessionNotifier.instance.getAccessToken();
//     return accessToken != null && accessToken.isNotEmpty;
//   }

//   void _navigateToAuth(BuildContext context) {
//     NavigationManager.replaceWith(context, NavigationRoutes.auth);
//   }

//   void _navigateToExerciseSelection(BuildContext context) async {
//     final isOnboarded = await localStorage.getBooleanWithDefault(
//       LocalStorageKeys.onboarded,
//       false,
//     );
//     if (context.mounted) {
//       if (!isOnboarded) {
//         NavigationManager.replaceWith(context, NavigationRoutes.onboarding);
//         return;
//       }
//       NavigationManager.replaceWith(
//         context,
//         NavigationRoutes.exerciseSelection,
//       );
//     }
//   }
// }
