import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/views/route_observer.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/l10n/l10n.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: HippoButton.stream(
              state: Stream.value(true),
              text: context.l10n.signOut,
              onClick: () {
                AuthenticationManager.getInstance()
                    .attemptLogout(SessionTimeoutReason.LOGIN_REQUESTED);
              }),
        ),
      ),
    );
  }
}
