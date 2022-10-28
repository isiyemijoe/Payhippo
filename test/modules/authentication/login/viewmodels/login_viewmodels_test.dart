import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/services/biometric_service.dart';
import 'package:payhippo/modules/authentication/login/viewmodels/login_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service_client.dart';

import 'login_viewmodels_test.mocks.dart';

@GenerateMocks([AuthenticationServiceClient, LocalStorageServiceImpl])
void main() {
  late final MockAuthenticationServiceClient client;

  late final LoginViewModel viewmodel;
  final user = User(
    firstName: 'Joseph',
    lastName: 'Isiyemi',
    email: 'Josephisiyemi1@gmail.com',
  );

  setUpAll(() {
    client = MockAuthenticationServiceClient();
    final _service =
        AuthenticationService(client, AuthenticationManager.getInstance());

    viewmodel = LoginViewModel(
        signupService: _service,
        biometricService: BiometricService(
            localStorageService: MockLocalStorageServiceImpl()));
  });
  // ignore: omit_local_variable_types

  group('LoginFormModel', () {
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
      expect(viewmodel.formModel.isPhoneNumberValidCheck(), false);
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
      expect(viewmodel.formModel.isPhoneNumberValidCheck(), false);
    });

    test('Test that _isPhoneNumberValid returns true is phone number valid',
        () {
      //@Arrange
      const phoneNumber = '7013957515';
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.isPhoneNumberValidCheck(), true);
    });

    test('Test that isPageValid returns true is phone number valid', () {
      //@Arrange
      const phoneNumber = '7013957515';
      when(viewmodel.formModel.onPhoneChanged(phoneNumber));

      //@Act
      viewmodel.formModel.onPhoneChanged(phoneNumber);

      //@Assert
      expect(viewmodel.formModel.isPageValid, emits(true));
    });
  });

  group('LoginNetworkCall', () {
    test('Test that we can login', () {
      //@Arrange
      when(client.login(request: viewmodel.formModel.request))
          .thenAnswer((realInvocation) async => Future.value(user));

      //@Act
      final resourceStream = viewmodel.login();

      //@Assert
      expect(
        resourceStream,
        emitsInOrder([
          isA<Loading<User?>>(),
          isA<Success<User?>>()
              .having((p0) => p0.data?.firstName, 'FirstName', user.firstName)
        ]),
      );
    });
  });
}
