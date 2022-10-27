import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class OTPValidationRequest {
  OTPValidationRequest({this.otp});
  String? otp;
}
