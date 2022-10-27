import 'package:flutter/foundation.dart';
import 'package:intl/locale.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/signup/views/pages/personal_infomation_one.dart';
import 'package:rxdart/subjects.dart';

class BaseViewModel extends ChangeNotifier {
  BaseViewModel({AuthenticationManager? authenticationManager})
      : authenticationManager =
            authenticationManager ?? locator<AuthenticationManager>();

  final AuthenticationManager authenticationManager;

  ///Retrieves the firstName name of the loggedIn User
  String get firstName => authenticationManager.firstName;

  ///Retrieves the full name of the loggedIn User
  String get fullName => '${authenticationManager.getUser()?.firstName ?? ''} '
      '${authenticationManager.getUser()?.lastName ?? ''}';

  ///Retrieves the email address of the loggedIn User
  String get emailAddress => authenticationManager.email;

  bool get isLoggedIn => authenticationManager.isLoggedIn;

  ///Retrieves the Phone Number of the loggedIn User
  String get phoneNumber => authenticationManager.getUser()?.phoneNumber ?? '';

  final BehaviorSubject<Language> _currentLocale =
      BehaviorSubject.seeded(languages[0]);

  Stream<Language> get locale => _currentLocale.stream;

  void setLocal(Language local) async {
    print("Called jherer");
    //await AppLocalizations.delegate.load(local.locale);
    _currentLocale.add(local);
  }
}
