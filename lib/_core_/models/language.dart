import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Language extends Equatable {
  Language({required this.locale, required this.languageName});
  Locale locale;
  String languageName;

  String getLable() => languageName;

  factory Language.fromJson(Map<String, dynamic> data) => Language(
        languageName: data['languageName'] as String,
        locale: Locale(
          data['languageCode'] as String,
          data['countryCode'] as String,
        ),
      );

  @override
  List<Object?> get props =>
      [languageName, locale.countryCode, locale.languageCode];

  Map<String, dynamic> toJson() => {
        'languageName': languageName,
        'languageCode': locale.languageCode,
        'countryCode': locale.countryCode,
      };
}
