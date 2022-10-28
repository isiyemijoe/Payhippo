import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/services/biometric_service.dart';
import 'package:payhippo/modules/authentication/login/model/login_request.dart';
import 'package:payhippo/modules/authentication/login/viewmodels/login_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service_client.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';

import '../../login/viewmodels/login_viewmodels_test.mocks.dart';

@GenerateMocks([AuthenticationServiceClient, LocalStorageServiceImpl])
void main() {
  late final MockAuthenticationServiceClient client;

  late final SignupViewModel viewmodel;
  final user = User(
    firstName: 'Joseph',
    lastName: 'Isiyemi',
    email: 'Josephisiyemi1@gmail.com',
  );

  setUpAll(() {
    client = MockAuthenticationServiceClient();
    final _service =
        AuthenticationService(client, AuthenticationManager.getInstance());

    viewmodel = SignupViewModel(signupService: _service);
  });
  // ignore: omit_local_variable_types

  group('OnboardingFormModel {Language}:', () {
    test('Test that value of language changes when onLanguageChanged is called',
        () {
      const language = 'English';

      //@Arrange
      when(viewmodel.formModel.onLanguageChanged(language));

      //@Act
      viewmodel.formModel.onLanguageChanged(language);

      //@Assert
      expect(viewmodel.formModel.request.language, language);
    });

    test('Test that isLanguageNameValid returns false is language is empty',
        () {
      //@Arrange
      const language = '';
      when(viewmodel.formModel.onLanguageChanged(language));

      //@Act
      viewmodel.formModel.onLanguageChanged(language);

      //@Assert
      expect(
          viewmodel.formModel.isLanguageNameValid(displayError: false), false);
    });

    test('Test that isLanguageNameValid returns true is language is not empty',
        () {
      //@Arrange
      const language = 'English';
      when(viewmodel.formModel.onLanguageChanged(language));

      //@Act
      viewmodel.formModel.onLanguageChanged(language);

      //@Assert
      expect(
          viewmodel.formModel.isLanguageNameValid(displayError: false), true);
    });
  });
  group('OnboardingFormModel {Firstname}:', () {
    test(
        'Test that value of firstname changes when onFirstNameChanged is called',
        () {
      const firstName = 'Joseph';

      //@Arrange
      when(viewmodel.formModel.onFirstNameChanged(firstName));

      //@Act
      viewmodel.formModel.onFirstNameChanged(firstName);

      //@Assert
      expect(viewmodel.formModel.request.firstName, firstName);
    });

    test('Test that isLanguageNameValid returns false is language is empty',
        () {
      //@Arrange
      const firstName = '';
      when(viewmodel.formModel.onFirstNameChanged(firstName));

      //@Act
      viewmodel.formModel.onFirstNameChanged(firstName);

      //@Assert
      expect(viewmodel.formModel.isFirstNameValid(displayError: false), false);
    });

    test('Test that isLanguageNameValid returns true is language is not empty',
        () {
      //@Arrange
      const firstName = 'Joseph';
      when(viewmodel.formModel.onLanguageChanged(firstName));

      //@Act
      viewmodel.formModel.onLanguageChanged(firstName);

      //@Assert
      expect(
          viewmodel.formModel.isLanguageNameValid(displayError: false), true);
    });
  });
  group('OnboardingFormModel {Surname}:', () {
    test('Test that value of Surname changes when onLastNameChanged is called',
        () {
      const lastName = 'Isiyemi';

      //@Arrange
      when(viewmodel.formModel.onLastNameChanged(lastName));

      //@Act
      viewmodel.formModel.onLastNameChanged(lastName);

      //@Assert
      expect(viewmodel.formModel.request.lastName, lastName);
    });

    test('Test that isLastNameValid returns false is Surname is empty', () {
      //@Arrange
      const firstName = '';
      when(viewmodel.formModel.onLastNameChanged(firstName));

      //@Act
      viewmodel.formModel.onLastNameChanged(firstName);

      //@Assert
      expect(viewmodel.formModel.isLastNameValid(displayError: false), false);
    });

    test('Test that isLastNameValid returns true is Surname is not empty', () {
      //@Arrange
      const firstName = 'Isiyemi';
      when(viewmodel.formModel.onLastNameChanged(firstName));

      //@Act
      viewmodel.formModel.onLastNameChanged(firstName);

      //@Assert
      expect(viewmodel.formModel.isLastNameValid(displayError: false), true);
    });
  });
  group('OnboardingFormModel {Email Address}:', () {
    test(
        'Test that value of Email Address changes when onLastNameChanged is called',
        () {
      const email = 'joseph.isiyemi@teamapt.com';

      //@Arrange
      when(viewmodel.formModel.onEmailChanged(email));

      //@Act
      viewmodel.formModel.onEmailChanged(email);

      //@Assert
      expect(viewmodel.formModel.request.email, email);
    });

    test('Test that isEmailValidCheck returns false if Email Address is empty',
        () {
      //@Arrange
      const email = '';
      when(viewmodel.formModel.onEmailChanged(email));

      //@Act
      viewmodel.formModel.onEmailChanged(email);

      //@Assert
      expect(viewmodel.formModel.isEmailValidCheck(displayError: false), false);
    });

    test(
        'Test that isEmailValidCheck returns false if Email Address is invalid',
        () {
      //@Arrange
      const email = 'joseph.isiyemi@teamapt';
      when(viewmodel.formModel.onEmailChanged(email));

      //@Act
      viewmodel.formModel.onEmailChanged(email);

      //@Assert
      expect(viewmodel.formModel.isEmailValidCheck(displayError: false), false);
    });

    test('Test that isEmailValidCheck returns true if Email Address is valid',
        () {
      //@Arrange
      const email = 'joseph.isiyemi@teamapt.com';
      when(viewmodel.formModel.onEmailChanged(email));

      //@Act
      viewmodel.formModel.onEmailChanged(email);

      //@Assert
      expect(viewmodel.formModel.isEmailValidCheck(displayError: false), true);
    });
  });
  group('OnboardingFormModel {Birth Date}:', () {
    test(
        'Test that value of request.birthDate changes when onBirthDateChanged is called',
        () {
      const dateOfBirth = '1997/11/03';

      //@Arrange
      when(viewmodel.formModel.onDateOfBirthChanged(dateOfBirth));

      //@Act
      viewmodel.formModel.onDateOfBirthChanged(dateOfBirth);

      //@Assert
      expect(viewmodel.formModel.request.birthDate, dateOfBirth);
    });

    test(
        'Test that isEmailValidCheck returns false if request.birthDate is malformed',
        () {
      //@Arrange
      const email = 'Jan 2020';
      when(viewmodel.formModel.onDateOfBirthChanged(email));

      //@Act
      viewmodel.formModel.onDateOfBirthChanged(email);

      //@Assert
      expect(viewmodel.formModel.isBirthDateValid(displayError: false), false);
    });

    test(
        'Test that isEmailValidCheck returns false if request.birthDate is empty',
        () {
      //@Arrange
      const email = '';
      when(viewmodel.formModel.onDateOfBirthChanged(email));

      //@Act
      viewmodel.formModel.onDateOfBirthChanged(email);

      //@Assert
      expect(viewmodel.formModel.isBirthDateValid(displayError: false), false);
    });

    test(
        'Test that isEmailValidCheck returns false if request.birthDate is less than 24 yers',
        () {
      //@Arrange
      const email = '1999/11/03';
      when(viewmodel.formModel.onDateOfBirthChanged(email));

      //@Act
      viewmodel.formModel.onDateOfBirthChanged(email);

      //@Assert
      expect(viewmodel.formModel.isBirthDateValid(displayError: false), false);
    });
    test(
        'Test that isEmailValidCheck returns true if request.birthDate is valid',
        () {
      //@Arrange
      const email = '1997/11/03';
      when(viewmodel.formModel.onDateOfBirthChanged(email));

      //@Act
      viewmodel.formModel.onDateOfBirthChanged(email);

      //@Assert
      expect(viewmodel.formModel.isBirthDateValid(displayError: false), true);
    });
  });

  group('OnboardingFormModel {Phone number} :', () {
    test(
        'Test that value on phone number changes when onPhoneChanged is called',
        () {
      const phoneNumber = '07013957515';

      //@Arrange
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.request.phoneNumber, phoneNumber);
    });

    test(
        'Test that _isPhoneNumberValid returns false is phone number starts with zero',
        () {
      //@Arrange
      const phoneNumber = '0701395751';
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.isPhoneValid(), false);
    });

    test(
        'Test that _isPhoneNumberValid returns false is phone number is less than 10',
        () {
      //@Arrange
      const phoneNumber = '701395751';
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.isPhoneValid(), false);
    });

    test('Test that _isPhoneNumberValid returns true is phone number valid',
        () {
      //@Arrange
      const phoneNumber = '7013957515';
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.isPhoneValid(), true);
    });
  });

  group('NetworkNetworkCall:', () {
    test('Test that we can Signup', () {
      //@Arrange
      when(client.createAccount(request: viewmodel.formModel.request))
          .thenAnswer((realInvocation) async => Future.value(user));

      //@Act
      final resourceStream = viewmodel.createAccount();

      //@Assert
      expect(
          resourceStream,
          emitsInOrder([
            isA<Loading<User?>>(),
            isA<Success<User?>>()
                .having((p0) => p0.data?.firstName, 'FirstName', user.firstName)
          ]));
    });

    test('Test that we can request OTP', () {
      //@Arrange
      when(client.requestOTP(
              phoneNumber: viewmodel.formModel.request.phoneNumber))
          .thenAnswer((realInvocation) async => Future.value(true));

      //@Act
      final resourceStream = viewmodel.requestOtp();

      //@Assert
      expect(
        resourceStream,
        emitsInOrder([
          isA<Loading<bool?>>(),
          isA<Success<bool?>>().having((p0) => p0.data, 'success', true)
        ]),
      );
    });
  });
}
