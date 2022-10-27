import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/route_observer.dart';

class AppSessionManager extends Listener {
  AppSessionManager(
      {required this.context,
      this.sessionTime = 120,
      AuthenticationManager? authManager,
      super.key,
      super.child})
      : _authManager = authManager ?? locator<AuthenticationManager>() {
    _authManager
      ..setSessionEventCallback(_onSessionTimeout)
      ..startSession(sessionTime: sessionTime);
  }

  final BuildContext context;
  final int sessionTime;
  final AuthenticationManager _authManager;

  void _onSessionTimeout(SessionTimeoutReason reason) {
    if (_authManager.getUser() == null) return;
    _authManager.resetSession();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.login,
      (route) => true,
      arguments: reason,
    );
  }

  @override
  HitTestBehavior get behavior => HitTestBehavior.translucent;

  @override
  PointerDownEventListener? get onPointerDown => (_) {
        _authManager.updateLastActivityTime();
      };
}
