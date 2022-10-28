import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';

class ErrorHandler {
  static void setup() async {
    FlutterError.onError = (FlutterErrorDetails error) {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(error);
      } else {
        Zone.current.handleUncaughtError(error.exception, error.stack!);
      }
    };
  }

  static Future<void> reportError(Object error, StackTrace stackTrace) async {
    if (kDebugMode) {
      log("Debug error $error");
    } else {
      log("Release Mode $error");
    }
  }
}
