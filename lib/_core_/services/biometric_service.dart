import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';

abstract class BiometricServiceStruct {
  BiometricServiceStruct({LocalStorageService? localStorageService})
      : _localStorageService = (localStorageService ??
            locator<LocalStorageService>()) as LocalStorageServiceImpl;

  final LocalStorageServiceImpl _localStorageService;

  Future<bool> supportBiometrics();

  Future<bool> authenticate();
}

//couple of overriden values because of current incomplete usecase
class BiometricService extends BiometricServiceStruct {
  BiometricService({super.localStorageService});

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _canUseBiometrics = false;
  bool _isBiometricsSetup = false;

  //if device hardware support biometrics
  bool get canUseBiometrics => _canUseBiometrics;

  //if biometrics has been setup on this device and device supports biometrics
  bool get isBiometricsSetup => _isBiometricsSetup;

  Future<void> init() async {
    _canUseBiometrics = await supportBiometrics();

    final localAuthenticationEnabled =
        _localStorageService.getEnabledBiometric() ?? true;

    final canReadBiometricLogin = await _readBiometricsPassword();

    _isBiometricsSetup = _canUseBiometrics &&
        localAuthenticationEnabled &&
        canReadBiometricLogin != null;
  }

  @override
  Future<bool> supportBiometrics() async {
    try {
      //Check if device support biometrics
      final canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

      final isBiometricSupported =
          await _localAuthentication.isDeviceSupported();

      //Check if any fingerprint has been enrolled
      final availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      return canCheckBiometrics &&
          isBiometricSupported &&
          availableBiometrics.isNotEmpty;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> authenticateAndGetPW() async {
    try {
      final didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to login into your account',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        return _readBiometricsPassword();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> authenticate() async {
    try {
      final didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to login into your account',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        return true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<String?> _readBiometricsPassword() async {
    final username = _localStorageService.getEmail();
    if (username == null) {
      return null;
    }
    try {
      final readData = await _secureStorage.read(key: '$username-key');
      return readData;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      await clearBiometricsPassword();
      return null;
    }
  }

  Future<void> setBiometricsPassword(String? username, String password) async {
    if (username == null) {
      return;
    }
    try {
      await _secureStorage.write(key: '$username-key', value: password);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      await clearBiometricsPassword();
      return;
    }
  }

  Future<void> clearBiometricsPassword() async {
    final username = _localStorageService.getEmail();
    if (username == null) return;
    try {
      await _secureStorage.delete(key: '$username-key');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
