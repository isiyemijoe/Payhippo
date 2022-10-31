import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/local/local_storage.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:rxdart/subjects.dart';

class SelectLanguageViewmodel extends BaseViewModel {
  SelectLanguageViewmodel({LocalStorageService? localStorageService})
      : _localStorage = (localStorageService ?? locator<LocalStorageService>())
            as LocalStorageServiceImpl;

  final LocalStorageServiceImpl _localStorage;

  Stream<Language> get lang => locale;

  void onSelect(Language? language) {
    _localStorage.saveUserLanguage(language!);
    setLocal(language);
  }
}
