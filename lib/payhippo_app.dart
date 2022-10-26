import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/utils/size_congig.dart';
import 'package:payhippo/_core_/views/animations/fade_in_animation.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/route_observer.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';

class PayHippoApp extends StatelessWidget {
  const PayHippoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Payhippo',
        theme: AppThemes.payhippoLightTheme(),
        navigatorKey: locator<GlobalKey<NavigatorState>>(),
        navigatorObservers: [RoutesObserver()],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        routes: AppRoute.buildRouteMap(),
        initialRoute: AppRoute.onboarding,
        supportedLocales: AppLocalizations.supportedLocales);
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
