import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:rxdart/rxdart.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel({LocalStorageService? localStorageService})
      : _localStorage = (localStorageService ?? locator<LocalStorageService>())
            as LocalStorageServiceImpl;

  final LocalStorageServiceImpl _localStorage;

  bool isFirstLaunch() {
    return _localStorage.getAppFirstLaunch() ?? true;
  }

  Stream<bool> countdown() {
    return TimerStream<bool>(true, const Duration(milliseconds: 3500));
  }

  // ignore: avoid_positional_boolean_parameters
  void onCountdownCompleted(bool event, [ValueChanged<bool>? onFirstLaunch]) {
    if (event) {
      onFirstLaunch?.call(isFirstLaunch());
    }
  }
}
