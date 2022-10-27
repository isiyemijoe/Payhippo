import 'package:dio/dio.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/modules/authentication/login/model/login_request.dart';
import 'package:payhippo/modules/authentication/signup/models/signup_request.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_service_client.g.dart';

@RestApi()
abstract class AuthenticationServiceClient {
  factory AuthenticationServiceClient(
    Dio dio, {
    String baseUrl,
  }) = _AuthenticationServiceClient;

  @POST('auth/create-account')
  Future<User?> createAccount({@Body() SignupRequest? request});

  @GET('auth/request-otp')
  Future<bool?> requestOTP({
    @Query('phone') String? phoneNumber,
  });

  @GET('auth/validate-otp')
  Future<bool?> validateOtp({
    @Query('otp') String? otp,
  });

  @POST('auth/login')
  Future<User?> login({@Body() LoginRequest? request});
}
