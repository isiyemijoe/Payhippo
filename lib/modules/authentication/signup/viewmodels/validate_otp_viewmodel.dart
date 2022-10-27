import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/utils/validators.dart';
import 'package:payhippo/modules/authentication/signup/models/otp_validation_request.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:rxdart/rxdart.dart';

class ValidateOtpViewModel extends BaseViewModel {
  ValidateOtpViewModel({AuthenticationServiceStruct? signupService})
      : _service = signupService ?? locator<AuthenticationServiceStruct>();
  OTPVerifiationModel formModel = OTPVerifiationModel();

  AuthenticationServiceStruct _service;

  Stream<Resource<bool?>> validateOtp() async* {
    final stream = _service.validateOtp(otp: formModel._request);

    await for (final event in stream) {
      formModel.isValidatingOtp.value = event is Loading;
      yield event;
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void setVerifiedState(bool state) =>
      authenticationManager.localStorage.setIsVerified(state: state);
}

class OTPVerifiationModel with Validators {
  OTPVerifiationModel() {
    ///OtpPage Validation
    isOtpPinValid = Rx.combineLatest([_otpPinSubject.stream], (values) {
      return _isOtpPinValid(displayError: false);
    }).asBroadcastStream();
  }
  final OTPValidationRequest _request = OTPValidationRequest();

  final BehaviorSubject<String?> _otpPinSubject = BehaviorSubject();
  Stream<String?> get otpPinStream => _otpPinSubject.stream;

  late final Stream<bool> isOtpPinValid;

  final ValueNotifier<bool> isValidatingOtp = ValueNotifier(false);

  void onOtpChanged(String? pin) {
    _request.otp = pin;
    _otpPinSubject.add(_request.otp);
  }

  @protected
  bool _isOtpPinValid({bool displayError = true}) {
    final pin = _request.otp ?? '';
    final isValid = pin.isNotEmpty && pin.length >= 6;
    return isValid;
  }

  void reset() {
    onOtpChanged(null);
  }

  void dispose() {
    _otpPinSubject.close();
  }
}
