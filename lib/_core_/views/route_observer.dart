import 'package:flutter/material.dart';
import 'package:payhippo/modules/authentication/login/model/login_args.dart';

enum SessionTimeoutReason { INACTIVITY, SESSION_TIMEOUT, LOGIN_REQUESTED }

class RoutesObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  Future<void> didPush(Route route, Route? previousRoute) async {
    super.didPush(route, previousRoute);

    final arguments = route.settings.arguments;

    if (arguments == null) return;

    if (arguments is LoginRouteArgs && arguments.reason != null) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 400));
      //--TODO display logout reason dialog
    }
  }
}
