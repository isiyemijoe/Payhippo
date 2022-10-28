import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/payhippo_app.dart';

void main() async {
  await setUp();
  runApp(const PayHippoApp());
}

Future<void> setUp() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await setupDeps();
}
