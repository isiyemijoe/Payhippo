import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Language extends Equatable {
  Language({required this.locale, required this.languageName});
  Locale locale;
  String languageName;

  String getLable() => languageName;

  @override
  // TODO: implement props
  List<Object?> get props => [languageName, locale];
}
