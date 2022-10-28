import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/remote/network_bound_resource.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/modules/authentication/login/model/login_request.dart';
import 'package:payhippo/modules/authentication/signup/models/otp_validation_request.dart';
import 'package:payhippo/modules/authentication/signup/models/signup_request.dart';
import 'package:payhippo/modules/authentication/signup/services/signup_service_client.dart';

abstract class AuthenticationServiceStruct extends NetworkBoundResource {
  AuthenticationServiceStruct(this._client, this._authenticationManager);

  final AuthenticationServiceClient _client;

  final AuthenticationManager _authenticationManager;

  Stream<Resource<User?>> createAccount({SignupRequest? request});

  Stream<Resource<bool?>> requestOtp({String? phoneNumber});

  Stream<Resource<bool?>> validateOtp({required OTPValidationRequest? otp});

  Stream<Resource<User?>> login({required LoginRequest? request});
}

class AuthenticationService extends AuthenticationServiceStruct {
  AuthenticationService(super.client, super.authenticationManager);

  @override
  Stream<Resource<User?>> createAccount({SignupRequest? request}) {
    return networkBoundResource(
      fromRemote: () =>
          _client.createAccount(request: request).then((value) => value),
      onRemoteDataFetched: (User? response) async {
        return response;
      },
    );
  }

  @override
  Stream<Resource<bool?>> requestOtp({String? phoneNumber}) {
    return networkBoundResource(
      fromRemote: () =>
          _client.requestOTP(phoneNumber: phoneNumber).then((value) => value),
      onRemoteDataFetched: (bool? response) async {
        return response;
      },
    );
  }

  @override
  Stream<Resource<bool?>> validateOtp({OTPValidationRequest? otp}) {
    return networkBoundResource(
      fromRemote: () =>
          _client.validateOtp(otp: otp?.otp).then((value) => value),
      onRemoteDataFetched: (bool? response) async {
        return response;
      },
    );
  }

  @override
  Stream<Resource<User?>> login({LoginRequest? request}) {
    return networkBoundResource(
      fromRemote: () => _client.login(request: request).then((value) => value),
      onRemoteDataFetched: (User? response) async {
        return response;
      },
    );
  }
}

class MockSignupService extends AuthenticationServiceStruct {
  MockSignupService(super.client, super.authenticationManager);

  @override
  Stream<Resource<User?>> createAccount({SignupRequest? request}) async* {
    yield Loading(null);
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
    if (request?.firstName?.toLowerCase() == 'joseph') {
      final mockUser = User(
        email: 'josephisiyemi1@gmail.com',
        lastName: 'Isiyemi',
        firstName: 'Joseph',
        phoneNumber: '7013957515',
      );

      _authenticationManager.auth(mockUser);

      yield Success(mockUser);
    } else {
      yield Error('Error creating account', 'User already exist', null);
    }
  }

  @override
  Stream<Resource<bool?>> requestOtp({String? phoneNumber}) async* {
    yield Loading(null);

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
    if ((phoneNumber?.length ?? 0) == 10) {
      yield Success(true);
    } else {
      yield Error('Error requesting OTP', 'Invalid phone number', null);
    }
  }

  @override
  Stream<Resource<bool?>> validateOtp({OTPValidationRequest? otp}) async* {
    yield Loading(null);
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
    if (otp?.otp == '000000') {
      yield Success(true);
    } else {
      yield Error(
          'Error validating OTP', 'Invalid OTP, pls check and try again', null);
    }
  }

  @override
  Stream<Resource<User?>> login({required LoginRequest? request}) async* {
    yield Loading(null);
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
    if ((request?.phoneNumber?.length ?? 0) == 10) {
      final mockUser = User(
        email: 'josephisiyemi1@gmail.com',
        lastName: 'Isiyemi',
        firstName: 'Joseph',
        phoneNumber: request?.phoneNumber ?? '7013957515',
      );

      _authenticationManager.auth(mockUser);

      yield Success(mockUser);
    } else {
      yield Error(
          'Error logging in, please try again', 'User already exist', null);
    }
  }
}
