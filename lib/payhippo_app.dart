import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/route_observer.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:provider/provider.dart';

class PayHippoApp extends StatelessWidget {
  const PayHippoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BaseViewModel(),
        builder: (context, child) {
          return StreamBuilder<Language>(
              stream: context.read<BaseViewModel>().locale,
              builder: (context, snapshot) {
                final lang = snapshot.data;

                return MaterialApp(
                    title: 'Payhippo',
                    theme: AppThemes.payhippoLightTheme(),
                    navigatorKey: locator<GlobalKey<NavigatorState>>(),
                    navigatorObservers: [RoutesObserver()],
                    locale: lang?.locale,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    routes: AppRoute.buildRouteMap(),
                    initialRoute: AppRoute.splash,
                    supportedLocales: AppLocalizations.supportedLocales);
              });
        });
  }
}
