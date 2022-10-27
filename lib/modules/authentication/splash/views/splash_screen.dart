import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/animations/fade_in_animation.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/modules/authentication/login/views/onboarding_screen.dart';
import 'package:payhippo/modules/authentication/splash/viewmodels/splash_viewmodel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkState();
  }

  void checkState() {
    final viewModel = context.read<SplashViewModel>();

    viewModel.countdown().listen(
          (event) => viewModel.onCountdownCompleted(
            event,
            (bool firstLaunch) {
              if (firstLaunch) {
                Navigator.popAndPushNamed(context, AppRoute.onboarding);
              } else {
                Navigator.popAndPushNamed(context, AppRoute.login);
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInAnimations(
                delay: 0.5,
                child: Assets.images.hippoLogo.image(height: 75, width: 75)),
            FadeInAnimations(
              delay: 0.5,
              child: Assets.images.hippoLogoText.image(height: 45),
            )
          ],
        ),
      ),
    );
  }
}
