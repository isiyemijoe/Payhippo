import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable {
  LoginRequest(
      {this.phoneNumber,
      this.password,
      this.manufacturer,
      this.model,
      this.otp,
      this.deviceUniqueIdentifier});

  String? phoneNumber;
  String? password;
  String? manufacturer;
  String? model;
  String? deviceUniqueIdentifier;
  String? otp;

  factory LoginRequest.fromJson(Map<String, dynamic> data) =>
      _$LoginRequestFromJson(data);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props =>
      [phoneNumber, password, manufacturer, model, deviceUniqueIdentifier];
}
