import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/route_observer.dart';

//import 'app_sessioned.dart';

class AuthenticationManager {
  AuthenticationManager({
    LocalStorageService? localStorageService,
  }) : localStorage = (localStorageService ?? locator<LocalStorageService>())
            as LocalStorageServiceImpl;

  final LocalStorageServiceImpl localStorage;

  User? _loggedInUser;
  int _sessionExpiryTime = 120; //seconds
  DateTime _lastActivityTime = DateTime.now();
  Cron? _scheduler;
  SessionEventCallback? _sessionEventCallback;

  String get firstName =>
      getUser()?.firstName ?? localStorage.getFirstName() ?? '';

  String get email => getUser()?.email ?? localStorage.getEmail() ?? '';

  void auth(User? loggedInUser) {
    _loggedInUser = loggedInUser;
    if (loggedInUser != null) {
      localStorage.saveLoggedInUser(loggedInUser);
      if (isLoggedIn) {
        localStorage
          ..saveEmail(getUser()?.email ?? '')
          ..saveFirstName(getUser()?.firstName ?? '');
      }
    }
  }

  bool get isLoggedIn => getUser() != null;

  User? getUser() => _loggedInUser ??= localStorage.getLoggedInUser();

  String? get accessToken => _loggedInUser?.referralCode;

  void resetSession() {
    _loggedInUser = null;
    _scheduler?.close();
    _scheduler = null;
    localStorage.deleteLoggedInUser();
  }

  // ignore: use_setters_to_change_properties
  void setSessionEventCallback(SessionEventCallback callback) =>
      _sessionEventCallback = callback;

  void updateLastActivityTime() {
    _lastActivityTime = DateTime.now();
  }

  void startSession({int sessionTime = 120}) {
    _sessionExpiryTime = sessionTime;
    updateLastActivityTime();
    if (_scheduler != null || !isLoggedIn) return;

    _scheduler = Cron();
    _scheduler?.schedule(Schedule.parse('*/2 * * * * *'), () async {
      final elapsedTime =
          DateTime.now().difference(_lastActivityTime).inSeconds;
      if (elapsedTime > _sessionExpiryTime) {
        _sessionEventCallback?.call(SessionTimeoutReason.INACTIVITY);
        unawaited(_scheduler?.close());
        _scheduler = null;
      }
    });
  }

  void attemptLogout(SessionTimeoutReason reason) {
    resetSession();
    locator<GlobalKey<NavigatorState>>().currentState?.pushNamedAndRemoveUntil(
          AppRoute.login,
          (_) => true,
          arguments: reason,
        );
  }

  void clearUserCache() {
    resetSession();
    localStorage.clear();
  }
}

// ignore: inference_failure_on_function_return_type
typedef SessionEventCallback<T extends SessionTimeoutReason> = Function(
  T value,
);
