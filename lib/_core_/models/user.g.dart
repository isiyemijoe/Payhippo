// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  User accessToken(String? accessToken);

  User birthDate(String? birthDate);

  User email(String email);

  User firstName(String firstName);

  User isVerified(bool isVerified);

  User lastName(String lastName);

  User phoneNumber(String? phoneNumber);

  User referralCode(String? referralCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    String? accessToken,
    String? birthDate,
    String? email,
    String? firstName,
    bool? isVerified,
    String? lastName,
    String? phoneNumber,
    String? referralCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUser.copyWith.fieldName(...)`
class _$UserCWProxyImpl implements _$UserCWProxy {
  final User _value;

  const _$UserCWProxyImpl(this._value);

  @override
  User accessToken(String? accessToken) => this(accessToken: accessToken);

  @override
  User birthDate(String? birthDate) => this(birthDate: birthDate);

  @override
  User email(String email) => this(email: email);

  @override
  User firstName(String firstName) => this(firstName: firstName);

  @override
  User isVerified(bool isVerified) => this(isVerified: isVerified);

  @override
  User lastName(String lastName) => this(lastName: lastName);

  @override
  User phoneNumber(String? phoneNumber) => this(phoneNumber: phoneNumber);

  @override
  User referralCode(String? referralCode) => this(referralCode: referralCode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `User(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ````
  User call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? birthDate = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? isVerified = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
    Object? referralCode = const $CopyWithPlaceholder(),
  }) {
    return User(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String?,
      birthDate: birthDate == const $CopyWithPlaceholder()
          ? _value.birthDate
          // ignore: cast_nullable_to_non_nullable
          : birthDate as String?,
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      isVerified:
          isVerified == const $CopyWithPlaceholder() || isVerified == null
              ? _value.isVerified
              // ignore: cast_nullable_to_non_nullable
              : isVerified as bool,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as String?,
      referralCode: referralCode == const $CopyWithPlaceholder()
          ? _value.referralCode
          // ignore: cast_nullable_to_non_nullable
          : referralCode as String?,
    );
  }
}

extension $UserCopyWith on User {
  /// Returns a callable class that can be used as follows: `instanceOfUser.copyWith(...)` or like so:`instanceOfUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}

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
      accessToken: json['accessToken'] as String?,
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
      'accessToken': instance.accessToken,
    };
