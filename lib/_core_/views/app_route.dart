import 'package:flutter/material.dart';
import 'package:payhippo/modules/authentication/login/views/login_screen.dart';
import 'package:payhippo/modules/authentication/login/views/onboarding_screen.dart';
import 'package:payhippo/modules/authentication/signup/views/otp_screen.dart';
import 'package:payhippo/modules/authentication/signup/views/signup_screen.dart';
import 'package:payhippo/payhippo_app.dart';

class AppRoute {
  AppRoute._();

  ///@auth
  static const String splash = 'SPLASH';
  static const String onboarding = 'ONBOARDING';
  static const String login = 'LOGIN';
  static const String signup = 'SIGNUP';
  static const String otp = 'OTP';

  static Map<String, WidgetBuilder> buildRouteMap() => {
        splash: (context) => const SplashScreen(),
        onboarding: (context) => const OnboardingScreen(),
        login: (context) => const LoginScreen(),
        signup: (context) => const SignupScreen(),
        otp: (context) => const OTPScreen()
      };
}
