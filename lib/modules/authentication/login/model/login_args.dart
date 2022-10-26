import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/route_observer.dart';

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.reason,
  });

  final Key? key;

  final SessionTimeoutReason? reason;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, reason: $reason}';
  }
}
