import 'package:flutter/material.dart';
import 'package:fonli_app/core/app_info/app_info.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/navigation/session_wrapper.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInfo.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SessionWrapper(
      child: MaterialApp(
        navigatorKey: NavigationManager.navigatorKey,
        routes: NavigationManager.routesMap(),
        initialRoute: NavigationManager.initialRoute,
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          if (locale == null) return const Locale('en', 'US');
          if (supportedLocales.contains(locale)) return locale;
          return const Locale('en', 'US');
        },
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      ),
    );
  }
}
