import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class User {
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.birthDate,
      this.phoneNumber,
      this.referralCode,
      this.accessToken,
      this.isVerified = false});

  final String firstName;
  final String lastName;
  final String email;
  final String? birthDate;
  final String? phoneNumber;
  final String? referralCode;
  final bool isVerified;
  final String? accessToken;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
