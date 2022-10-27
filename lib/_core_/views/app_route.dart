import 'package:flutter/material.dart';
import 'package:payhippo/modules/authentication/login/viewmodels/login_viewmodel.dart';
import 'package:payhippo/modules/authentication/login/views/login_screen.dart';
import 'package:payhippo/modules/authentication/login/views/onboarding_screen.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/validate_otp_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/screens/otp_screen.dart';
import 'package:payhippo/modules/authentication/signup/views/screens/signup_screen.dart';
import 'package:payhippo/modules/authentication/splash/viewmodels/splash_viewmodel.dart';
import 'package:payhippo/modules/authentication/splash/views/splash_screen.dart';
import 'package:payhippo/modules/dashboard/views/dashboard.dart';
import 'package:provider/provider.dart';

class AppRoute {
  AppRoute._();

  ///@auth
  static const String splash = 'SPLASH';
  static const String onboarding = 'ONBOARDING';
  static const String login = 'LOGIN';
  static const String signup = 'SIGNUP';
  static const String otp = 'OTP';
  static const String dashboard = 'DASHBOARD';

  static Map<String, WidgetBuilder> buildRouteMap() => {
        splash: (context) => ChangeNotifierProvider(
            create: (_) => SplashViewModel(),
            builder: (context, child) {
              return const SplashScreen();
            }),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
            builder: (context, child) {
              return const LoginScreen();
            }),
        signup: (context) => ChangeNotifierProvider(
              create: (context) => SignupViewModel(),
              builder: (context, child) {
                return const SignupScreen();
              },
            ),
        otp: (context) => ChangeNotifierProvider(
            create: (context) => ValidateOtpViewModel(),
            builder: (context, child) {
              return const OTPScreen();
            }),
        dashboard: (context) => const DashboardScreen()
      };
}
