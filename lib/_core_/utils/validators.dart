import 'package:flutter/material.dart';

mixin Validators {
  ///Validates the password and append the error message
  /// if the password is valid Tuple.second is empty

  @protected
  bool isBVNValid(String? text) {
    if (text == null) return false;
    if (text.isEmpty || text.length < 11) return false;
    return true;
  }

  @protected
  bool isAccountNumberValid(String? text) {
    if (text == null) return false;
    if (text.isEmpty || text.length < 10) return false;
    return true;
  }

  @protected
  ValidationReponse isPhoneNumberValid(String? text) {
    if (text == null) return ValidationReponse(isValid: false);
    if (text.length < 10) {
      return ValidationReponse(
          isValid: false, reason: 'Please enter a valid mobile number');
    }
    final reg2 = RegExp(r'^(|08|09|07)\d{9}$');

    if (reg2.hasMatch(text)) {
      return ValidationReponse(
        isValid: false,
        reason: 'Please enter phone number without the first zero',
      );
    }
    final reg = RegExp(r'^(\+234[7-9]|234[7-9]|08|09|07)\d{9}$');
    final valid = reg.hasMatch(text.replaceAll(RegExp(r'\s'), '').trim());
    return ValidationReponse(
      isValid: valid,
    );
  }

  @protected
  bool isEmailValid(String? text) {
    if (text == null) return false;
    return RegExp(
            r"^(?=.{1,64}@)[A-Za-z0-9_-]+(\.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$")
        .hasMatch(text);
  }

  @protected
  bool isAlphanumeric(String? text) {
    if (text == null) return false;
    return RegExp(r"^(?=.*[a-zA-Z])(?=.*[0-9])[A-Za-z0-9]+$").hasMatch(text);
  }

  @protected
  bool isEmpty(String? text) {
    return text == null || text.trim().isEmpty;
  }
}

class ValidationReponse {
  ValidationReponse({required this.isValid, this.reason});
  String? reason;
  bool isValid;
}
