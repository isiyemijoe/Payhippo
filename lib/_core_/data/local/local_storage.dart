// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  T? getFromDisk<T>(String key);

  Future<bool> saveToDisk<T>(String key, T content);

  Future<bool> deleteFromDisk(String key);

  Future<bool> saveData(String key, Object? object);

  dynamic getData(String key);
}

class LocalStorageServiceImpl extends LocalStorageService {
  static SharedPreferences? _prefs;
  static LocalStorageServiceImpl? _instance;

  static Future<LocalStorageServiceImpl> getInstance() async {
    _instance ??= LocalStorageServiceImpl();

    _prefs ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  @override
  T? getFromDisk<T>(String key) {
    final value = _prefs?.get(key) as T?;
    debugPrint(
      '(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value',
    );
    return value;
  }

  // updated _saveToDisk function that handles all types
  @override
  Future<bool> saveToDisk<T>(String key, T content) async {
    debugPrint(
      '(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content',
    );

    if (content is String) {
      return _prefs!.setString(key, content);
    }
    if (content is bool) {
      return _prefs!.setBool(key, content);
    }
    if (content is int) {
      return _prefs!.setInt(key, content);
    }
    if (content is double) {
      return _prefs!.setDouble(key, content);
    }
    if (content is List<String>) {
      return _prefs!.setStringList(key, content);
    }
    return false;
  }

  @override
  Future<bool> deleteFromDisk(String key) async {
    debugPrint('(TRACE) LocalStorageService:_deleteFromDisk. key: $key');

    return _prefs!.remove(key);
  }

  @override
  Future<bool> saveData(String key, Object? object) {
    final data = jsonEncode(object);
    return saveToDisk(key, data);
  }

  @override
  dynamic getData(String key) {
    final data = getFromDisk<String?>(key);
    try {
      return jsonDecode(data ?? '');
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveLoggedInUser(User data) {
    return saveData(LocalStorageKeys.loggedInUserKey, data.toJson());
  }

  User? getLoggedInUser() {
    final data =
        getData(LocalStorageKeys.loggedInUserKey) as Map<String, dynamic>?;
    if (data == null) return null;
    return User.fromJson(data);
  }

  Future<bool> deleteLoggedInUser() {
    return deleteFromDisk(LocalStorageKeys.loggedInUserKey);
  }

  Future<bool> saveFirstName(String data) =>
      saveData(LocalStorageKeys.userFirstNameKey, data);

  String? getFirstName() =>
      getData(LocalStorageKeys.userFirstNameKey) as String?;

  Future<bool> saveEmail(String data) =>
      saveData(LocalStorageKeys.userEmailKey, data);

  String? getEmail() => getData(LocalStorageKeys.userEmailKey) as String?;

  Future<bool?> setEnableBiometric(bool data) {
    return saveData(LocalStorageKeys.enableFingerPrintKey, data);
  }

  bool? getEnabledBiometric() =>
      getData(LocalStorageKeys.enableFingerPrintKey) as bool?;

  Future<bool> setAppFirstLaunch(bool data) {
    return saveData(LocalStorageKeys.isUserFirstLaunchKey, data);
  }

  Future<bool> setIsVerified({required bool state}) async {
    var user = getLoggedInUser();

    if (user == null) return false;
    user = user.copyWith(isVerified: state);
    return saveLoggedInUser(user);
  }

  bool? getAppFirstLaunch() {
    final data = getData(LocalStorageKeys.isUserFirstLaunchKey) as bool?;
    return data;
  }

  Language? getUserLanguage() {
    final data =
        getData(LocalStorageKeys.userLanguageKey) as Map<String, dynamic>?;
    if (data == null) return null;
    return Language.fromJson(data);
  }

  Future<bool> saveUserLanguage(Language data) {
    return saveData(LocalStorageKeys.userLanguageKey, data.toJson());
  }

  void clear() => _prefs?.clear();
}

class LocalStorageKeys {
  static const String loggedInUserKey = 'LOGGED_IN_USER_KEY';
  static const String userFirstNameKey = 'USER_FIRST_NAME_KEY';
  static const String userEmailKey = 'USER_EMAIL_KEY';
  static const String enableFingerPrintKey = 'ENABLE_FINGERPRINT_KEY';
  static const String isUserFirstLaunchKey = 'IS_USER_FIRST_LAUNCH';
  static const String userLanguageKey = 'LOGGED_IN_USER_LANGUAGE_KEY';
}
