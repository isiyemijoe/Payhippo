import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/data/secrets.dart';
import 'package:payhippo/_core_/services/biometric_service.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service_client.dart';

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
    ..registerSingletonAsync<LocalStorageService>(() async {
      return LocalStorageServiceImpl.getInstance();
    })
    ..registerSingletonWithDependencies<AuthenticationManager>(
      AuthenticationManager.new,
      dependsOn: [LocalStorageService],
    )
    ..registerSingletonAsync<BiometricService>(
      () async {
        final biometricsService = BiometricService();
        await biometricsService.init();
        return biometricsService;
      },
      dependsOn: [LocalStorageService],
    )
    ..registerSingletonWithDependencies<AuthenticationServiceStruct>(
        () => MockSignupService(
              AuthenticationServiceClient(
                Dio(),
              ),
              locator<AuthenticationManager>(),
            ),
        dependsOn: [AuthenticationManager]);
}
