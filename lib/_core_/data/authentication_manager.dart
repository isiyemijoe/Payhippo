// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:payhippo/_core_/data/di.dart';
// import 'package:payhippo/_core_/data/local/local_storage.dart';
// import 'package:payhippo/_core_/models/user.dart';


// //import 'app_sessioned.dart';


// class AuthenticationManager {
//   AuthenticationManager({
//     LocalStorageService? localStorageService,
//   }) : localStorage = (localStorageService ?? locator<LocalStorageService>())
//             as LocalStorageServiceImpl;

//   final LocalStorageServiceImpl localStorage;

//   User? _loginResponse;
//   int _sessionExpiryTime = 120; //seconds
//   DateTime _lastActivityTime = DateTime.now();
//   Cron? _scheduler;
//   SessionEventCallback? _sessionEventCallback;



//   String get firstName =>
//       getUser()?.firstName ?? localStorage.getFirstName() ?? '';

//   String get email => getUser()?.email ?? localStorage.getEmail() ?? '';






//   // TODO(joseph): Rename LoginResponse
//   void auth(User? loginResponse) {
//     _loginResponse = loginResponse;
//     if (loginResponse != null) {
//       setCurrentBusinessProfile(loginResponse);
//       localStorage.saveLoggedInUser(loginResponse);
//       if (isLoggedIn) {
//         localStorage
//           ..saveEmail(getUser()?.email ?? '')
//           ..saveFirstName(getUser()?.firstName ?? '');
//       }
//     }
//   }

//   void authMerchant(LoginResponse? newAuthData) {
//     if (newAuthData != null) {
//       _loginResponse = _loginResponse?.copyWith(
//           selectedMerchant: newAuthData.selectedMerchant,
//           merchantList: newAuthData.merchantList);
//       if (kDebugMode) {
//         print('Reauth merchant details ${_loginResponse!.toJson()}');
//       }
//       setCurrentBusinessProfile(newAuthData);
//       localStorage
//         ..saveEmail(getUser()?.email ?? '')
//         ..saveFirstName(getUser()?.firstName ?? '')
//         ..saveLoggedInUser(_loginResponse!);
//     }
//   }

//   void setCurrentBusinessProfile(LoginResponse loginResponse) {
//     if (loginResponse.selectedMerchant != null) {
//       _selectedMerchant = loginResponse.selectedMerchant;
//     } else {
//       // TODO(joseph): Continue with login flow... Display select merchant dialog on Dashboard
//       //IF no default merchant, select a merchant
//     }
//   }

//   void setOperationalBusiness(SelectedMerchant? selectedMerchant) {
//     if (null == selectedMerchant) return;
//     final user = getUser();
//     if (null != user) {
//       _selectedMerchant = selectedMerchant;
//     }
//   }

//   SelectedMerchant? get selectedMerchant => _selectedMerchant;

//   bool get isLoggedIn =>
//       getUser() != null &&
//       accessToken != null &&
//       accessToken?.isNotEmpty == true;

//   User? getUser() {
//     _loginResponse ??= localStorage.getLoggedInUser();
//     return _loginResponse?.user;
//   }

//   String? get accessToken => _loginResponse?.accessToken;

//   void resetSession() {
//     _loginResponse = null;
//     _selectedMerchant = null;
//     _scheduler?.close();
//     _scheduler = null;
//     localStorage.deleteLoggedInUser();
//   }

//   // ignore: use_setters_to_change_properties
//   void setSessionEventCallback(SessionEventCallback callback) =>
//       _sessionEventCallback = callback;

//   void updateLastActivityTime() {
//     _lastActivityTime = DateTime.now();
//   }

//   void startSession({int sessionTime = 120}) {
//     _sessionExpiryTime = sessionTime;
//     updateLastActivityTime();
//     if (_scheduler != null || !isLoggedIn) return;

//     _scheduler = Cron();
//     _scheduler?.schedule(Schedule.parse('*/2 * * * * *'), () async {
//       final elapsedTime =
//           DateTime.now().difference(_lastActivityTime).inSeconds;
//       if (elapsedTime > _sessionExpiryTime) {
//         _sessionEventCallback?.call(SessionTimeoutReason.INACTIVITY);
//         unawaited(_scheduler?.close());
//         _scheduler = null;
//       }
//     });
//   }

//   void attemptLogout(SessionTimeoutReason reason) {
//     resetSession();
//     locator<AppRouter>().replaceAll([LoginRoute(reason: reason)]);
//   }
// }
