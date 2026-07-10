import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/auth_session.notifier.dart';
import 'package:fonli_app/core/navigation/navigation.dart';

class SessionWrapper extends StatefulWidget {
  final Widget child;

  const SessionWrapper({super.key, required this.child});

  @override
  State<SessionWrapper> createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> {
  late AuthState _lastObservedAuthState;

  @override
  void initState() {
    super.initState();
    _lastObservedAuthState = AuthSessionNotifier.instance.state;
    AuthSessionNotifier.instance.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    AuthSessionNotifier.instance.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    final previous = _lastObservedAuthState;
    final current = AuthSessionNotifier.instance.state;
    _lastObservedAuthState = current;

    final wasLoggedIn = previous == AuthState.authenticated;
    final isNowLoggedOut = current == AuthState.unauthenticated;
    if (!wasLoggedIn || !isNowLoggedOut) return;

    NavigationManager.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      NavigationRoutes.auth.path,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
