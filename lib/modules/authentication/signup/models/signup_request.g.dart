// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) =>
    SignupRequest(
      language: json['language'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      birthDate: json['birthDate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      referralCode: json['referralCode'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'language': instance.language,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDate': instance.birthDate,
      'phoneNumber': instance.phoneNumber,
      'referralCode': instance.referralCode,
      'otp': instance.otp,
    };
