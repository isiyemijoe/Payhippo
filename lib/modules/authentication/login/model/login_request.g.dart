// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      manufacturer: json['manufacturer'] as String?,
      model: json['model'] as String?,
      otp: json['otp'] as String?,
      deviceUniqueIdentifier: json['deviceUniqueIdentifier'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'deviceUniqueIdentifier': instance.deviceUniqueIdentifier,
      'otp': instance.otp,
    };
