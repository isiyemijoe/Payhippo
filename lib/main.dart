import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/services/error_handler.dart';
import 'package:payhippo/payhippo_app.dart';

void main() async {
  await setUp();

  unawaited(runZonedGuarded<Future<void>>(() async {
    runApp(const PayHippoApp());
  }, ErrorHandler.reportError));
}

Future<void> setUp() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await setupDeps();
}
