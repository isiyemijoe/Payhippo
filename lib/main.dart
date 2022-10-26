import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/payhippo_app.dart';

void main() async {
  await setup();
  runApp(const PayHippoApp());
}

Future<void> setup() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await setupDeps();
}
