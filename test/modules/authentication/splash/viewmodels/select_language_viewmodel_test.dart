import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/modules/authentication/signup/views/pages/personal_infomation_one.dart';
import 'package:payhippo/modules/authentication/splash/viewmodels/select_language_viewmodel.dart';

import 'splash_viewmodel_test.mocks.dart';

@GenerateMocks([LocalStorageServiceImpl])
void main() {
  late final SelectLanguageViewmodel viewModel;
  late final LocalStorageServiceImpl _localStorage;

  setUpAll(() async {
    _localStorage = MockLocalStorageServiceImpl();
    viewModel = SelectLanguageViewmodel(
      localStorageService: _localStorage,
    );
  });

  group('SelectLanguageViewmodel', () {
    late Language locale;
    setUp(() async {
      locale = languages[0];
    });

    test(
      'Test that value of language stream when onSelect is called',
      () {
        //@Arrange
        when(_localStorage.saveUserLanguage(locale))
            .thenAnswer((realInvocation) => Future.value(true));

        //@Act
        viewModel.onSelect(locale);

        //@Assert
        expect(viewModel.lang, emits(locale));
      },
    );

    test(
      'Test that value of user language in saved and fetch successfully',
      () {
        //@Arrange
        when(_localStorage.saveUserLanguage(locale))
            .thenAnswer((realInvocation) => Future.value(true));

        when(_localStorage.getUserLanguage())
            .thenAnswer((realInvocation) => locale);

        //@Act
        final getLocale = _localStorage.getUserLanguage();

        //@Assert
        expect(getLocale, locale);
      },
    );

    test(
      'Test that value of user language is null when value does not exist',
      () {
        //@Arrange
        when(_localStorage.getUserLanguage())
            .thenAnswer((realInvocation) => null);

        //@Act
        final getLocale = _localStorage.getUserLanguage();

        //@Assert
        expect(getLocale, null);
      },
    );
  });
}
