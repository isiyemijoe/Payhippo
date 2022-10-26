import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/data/secrets.dart';

final locator = GetIt.I;

Future<void> setupDeps() async {
  await LocalStorageServiceImpl.getInstance.call();

  locator
    ..registerSingletonAsync<Secrets>(() async {
      final secrets = Secrets();
      await Secrets.init();
      return secrets;
    })
    ..registerSingleton<GlobalKey<NavigatorState>>(GlobalKey<NavigatorState>())
    ..registerFactoryAsync<LocalStorageService>(() async {
      return LocalStorageServiceImpl.getInstance();
    });
}
