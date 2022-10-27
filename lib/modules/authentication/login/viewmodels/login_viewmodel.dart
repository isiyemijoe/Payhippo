import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/services/biometric_service.dart';
import 'package:payhippo/_core_/utils/validators.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/login/model/login_request.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(
      {AuthenticationServiceStruct? signupService,
      BiometricService? biometricService})
      : _service = signupService ?? locator<AuthenticationServiceStruct>(),
        _biometricService = biometricService ?? locator.get<BiometricService>();
  LoginFormModel formModel = LoginFormModel();

  final AuthenticationServiceStruct _service;
  final BiometricService _biometricService;

  bool get canUseBiometrics => _biometricService.canUseBiometrics && isLoggedIn;

  Stream<Resource<bool?>> login() async* {
    final stream = _service.login(request: formModel._request);

    await for (final event in stream) {
      formModel.isLogginIn.value = event is Loading;
      yield event;
    }
  }

  Stream<Resource<bool?>> loginWithBiometrics() async* {
    final validate = await _biometricService.authenticate();

    if (validate) {
      final stream = _service.login(request: formModel._request);

      await for (final event in stream) {
        formModel.isLogginIn.value = event is Loading;
        yield event;
      }
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void setVerifiedState(bool state) =>
      authenticationManager.localStorage.setIsVerified(state: state);

  void setIsAppFirstLaunch() =>
      authenticationManager.localStorage.setAppFirstLaunch(false);
}

class LoginFormModel with Validators {
  LoginFormModel() {
    isPageValid = Rx.combineLatest([_phoneSubject.stream], (values) {
      return _isPhoneNumberValid(displayError: true);
    }).asBroadcastStream();
  }
  final LoginRequest _request = LoginRequest();

  final BehaviorSubject<String?> _phoneSubject = BehaviorSubject();
  Stream<String?> get phoneStream => _phoneSubject.stream;

  late final Stream<bool> isPageValid;

  final ValueNotifier<bool> isLogginIn = ValueNotifier(false);

  void onPhoneChanged(String? number) {
    _request.phoneNumber = number;
    _phoneSubject.add(_request.otp);
    _isPhoneNumberValid();
  }

  @protected
  bool _isPhoneNumberValid({bool displayError = true}) {
    final phoneNumber = _request.phoneNumber ?? '';
    final isValid = isPhoneNumberValid('+234$phoneNumber');
    if (displayError && !isValid.isValid) {
      _phoneSubject
          .addError(isValid.reason ?? 'Please enter a valid mobile number.');
    }
    return isValid.isValid;
  }

  void reset() {
    onPhoneChanged(null);
  }

  void dispose() {
    _phoneSubject.close();
  }
}
