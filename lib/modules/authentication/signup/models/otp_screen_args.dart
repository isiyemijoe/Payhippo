import 'package:flutter/material.dart';

class OTPScreenArgs {
  OTPScreenArgs({this.isSignup = false, this.callback});
  final VoidCallback? callback;
  final bool isSignup;
}
