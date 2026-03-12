import 'package:flutter/material.dart';
import 'package:fonli_app/core/navigation/navigation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: NavigationManager.routesMap(),
      initialRoute: NavigationManager.initialRoute,
    );
  }
}
