// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      birthDate: json['birthDate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      referralCode: json['referralCode'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'birthDate': instance.birthDate,
      'phoneNumber': instance.phoneNumber,
      'referralCode': instance.referralCode,
      'isVerified': instance.isVerified,
    };
