import 'package:json_annotation/json_annotation.dart';

part 'signup_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SignupRequest {
  SignupRequest(
      {this.language,
      this.firstName,
      this.lastName,
      this.email,
      this.birthDate,
      this.phoneNumber,
      this.referralCode,
      this.otp});

  String? language;
  String? firstName;
  String? lastName;
  String? email;
  String? birthDate;
  String? phoneNumber;
  String? referralCode;
  String? otp;

  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}
