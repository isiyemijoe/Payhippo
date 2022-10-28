import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/utils/validators.dart';
import 'package:payhippo/modules/authentication/signup/models/signup_request.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:rxdart/rxdart.dart';

class SignupViewModel extends BaseViewModel {
  SignupViewModel({AuthenticationServiceStruct? signupService})
      : _service = signupService ?? locator<AuthenticationServiceStruct>();
  OnboardingFormModel formModel = OnboardingFormModel();

  AuthenticationServiceStruct _service;

  Stream<Resource<User?>> createAccount() async* {
    final stream = _service.createAccount(request: formModel.request);

    await for (final event in stream) {
      formModel.isOnBoardingUser.value = event is Loading;

      yield event;
    }
  }

  Stream<Resource<bool?>> requestOtp() async* {
    final stream =
        _service.requestOtp(phoneNumber: formModel.request.phoneNumber);

    await for (final event in stream) {
      formModel.isGeneratingOtp.value = event is Loading;
      yield event;
    }
  }

  void setIsAppFirstLaunch() =>
      authenticationManager.localStorage.setAppFirstLaunch(false);
}

class OnboardingFormModel with Validators {
  OnboardingFormModel() {
    ///PhoneNumber and Email Page Validation
    isFirstPageValid = Rx.combineLatest(
        [emailStream, firstNameStream, lastNameStream, languageStream],
        (values) {
      return isEmailValidCheck(displayError: true) &&
          isFirstNameValid(displayError: true) &&
          isLastNameValid(displayError: true) &&
          isLanguageNameValid(displayError: true);
    }).asBroadcastStream();

    isSecondPageValid = Rx.combineLatest([
      birthDateStream,
      phoneStream,
    ], (values) {
      return isBirthDateValid() && isPhoneValid();
    }).asBroadcastStream();

    ///OtpPage Validation
    isOtpPinValid = Rx.combineLatest([_otpPinSubject.stream], (values) {
      return isOtpPinValidCheck(displayError: false);
    }).asBroadcastStream();
  }
  final SignupRequest request = SignupRequest();

  String ussdCodeText = '';

  final BehaviorSubject<String?> _emailSubject = BehaviorSubject();
  Stream<String?> get emailStream => _emailSubject.stream;

  final BehaviorSubject<String?> _languageSubject = BehaviorSubject();
  Stream<String?> get languageStream => _languageSubject.stream;

  final BehaviorSubject<String?> _firstNameSubject = BehaviorSubject.seeded('');
  Stream<String?> get firstNameStream => _firstNameSubject.stream;

  final BehaviorSubject<String?> _lastNameSubject = BehaviorSubject();
  Stream<String?> get lastNameStream => _lastNameSubject.stream;

  late final Stream<bool> isFirstPageValid;

  final BehaviorSubject<String?> _birthDateSubject = BehaviorSubject();
  Stream<String?> get birthDateStream => _birthDateSubject.stream;

  final BehaviorSubject<String?> _phoneSubject = BehaviorSubject();
  Stream<String?> get phoneStream => _phoneSubject.stream;

  final BehaviorSubject<String?> _referralSubject = BehaviorSubject();
  Stream<String?> get referralStream => _referralSubject.stream;

  final ValueNotifier<bool> isGeneratingOtp = ValueNotifier(false);

  late final Stream<bool> isSecondPageValid;

  final BehaviorSubject<String?> _otpPinSubject = BehaviorSubject();
  Stream<String?> get otpPinStream => _otpPinSubject.stream;

  late final Stream<bool> isOtpPinValid;

  final ValueNotifier<bool> isOnBoardingUser = ValueNotifier(false);

  ///
  void onEmailChanged(String? email) {
    request.email = email;
    _emailSubject.add(email);
    isEmailValidCheck();
  }

  void onLanguageChanged(String? language) {
    request.language = language;
    _languageSubject.add(language);
    isLanguageNameValid(displayError: true);
  }

  void onFirstNameChanged(String? firstname) {
    request.firstName = firstname;
    _firstNameSubject.add(firstname);
    isFirstNameValid(displayError: true);
  }

  void onLastNameChanged(String? lastName) {
    request.lastName = lastName;
    _lastNameSubject.add(lastName);
    isLastNameValid(displayError: true);
  }

  void onBirthDateChanged(String? birthDate) {
    print(birthDate);
    request.birthDate = birthDate;
    _birthDateSubject.add(birthDate);
    isBirthDateValid(displayError: true);
  }

  void onReferralChanged(String? code) {
    request.referralCode = code;
    _referralSubject.add(code);
  }

  bool isEmailValidCheck({bool displayError = true}) {
    final emailAddress = request.email;
    final isValid = isEmailValid(emailAddress);
    if (displayError && !isValid) {
      _emailSubject.addError('Please enter a valid email address.');
    }
    return isValid;
  }

  bool isBirthDateValid({bool displayError = true}) {
    final birthDate = request.birthDate;
    DateTime? dateTime;
    try {
      dateTime = DateFormat('yyyy/mm/dd').parse(birthDate ?? '');
    } catch (e) {}

    if (dateTime == null) {
      _birthDateSubject.addError('Please enter a valid date');
      return false;
    } else {
      final isValid =
          dateTime.add(const Duration(days: 8760)).isBefore(DateTime.now());
      if (displayError && !isValid) {
        _birthDateSubject.add('You must be 24 years or older');
      }

      return isValid;
    }
  }

  ///
  void onPhoneChanged(String? phone) {
    request.phoneNumber = phone;
    _phoneSubject.add(phone);
    isPhoneValid();
  }

  bool isFirstNameValid({required bool displayError}) {
    final firstName = request.firstName ?? '';
    final isValid = firstName.isNotEmpty;
    if (displayError && !isValid) {
      _firstNameSubject.addError('Please enter your first name');
    }
    return isValid;
  }

  bool isLastNameValid({required bool displayError}) {
    final lastName = request.lastName ?? '';
    final isValid = lastName.isNotEmpty;
    if (displayError && !isValid) {
      _lastNameSubject.addError('Please enter your surname');
    }
    return isValid;
  }

  bool isLanguageNameValid({required bool displayError}) {
    final language = request.language ?? '';
    final isValid = language.isNotEmpty;
    if (displayError && !isValid) {
      _lastNameSubject.addError('Please select your prefered language');
    }
    return isValid;
  }

  ///
  bool isPhoneValid({bool displayError = true}) {
    final phoneNumber = request.phoneNumber ?? '';
    final validationReponse = isPhoneNumberValid('+234$phoneNumber');
    if (displayError && !validationReponse.isValid) {
      _phoneSubject.addError(
          validationReponse.reason ?? 'Please enter a valid mobile number.');
    }
    return validationReponse.isValid;
  }

  void onOtpChanged(String? pin) {
    request.otp = pin;
    _otpPinSubject.add(request.otp);
  }

  bool isOtpPinValidCheck({bool displayError = true}) {
    final pin = request.otp ?? '';
    final isValid = pin.isNotEmpty && pin.length >= 6;
    return isValid;
  }

  void onDateOfBirthChanged(String? dateOfBirth) {
    request.birthDate = dateOfBirth;
    _birthDateSubject.add(request.birthDate);
  }

  void reset() {
    onOtpChanged(null);
    onFirstNameChanged(null);
    onLanguageChanged(null);
    onEmailChanged(null);
    onBirthDateChanged(null);
    onPhoneChanged(null);
    onReferralChanged(null);
    onDateOfBirthChanged(null);
  }

  void dispose() {
    isGeneratingOtp.dispose();
    _birthDateSubject.close();
    _languageSubject.close();
    _firstNameSubject.close();
    _lastNameSubject.close();
    _referralSubject.close();
    _phoneSubject.close();
    _otpPinSubject.close();
    _emailSubject.close();
  }
}
