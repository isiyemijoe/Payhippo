import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/remote/response_observer.dart';
import 'package:payhippo/_core_/models/user.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/modules/authentication/signup/models/otp_screen_args.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/screens/otp_screen.dart';

class SignupResponseObserver extends ResponseObserver<Resource<User?>> {
  SignupResponseObserver({required super.context, required this.viewModel});

  final SignupViewModel viewModel;

  @override
  void observe(Resource<User?> event) {
    if (event is Success) {
      _doOnSuccess();
    } else if (event is Error) {
      _doOnError(event);
    }
    super.observe(event);
  }

  void _doOnSuccess() {
    viewModel.setIsAppFirstLaunch();

    locator<GlobalKey<NavigatorState>>().currentState?.pushNamedAndRemoveUntil(
        AppRoute.otp, (route) => false,
        arguments: OTPScreenArgs(isSignup: true));
  }

  void _doOnError(error) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return Container(
          color: Colors.white,
          height: 200,
          child: Center(child: Text((error as Error).error.toString() ?? "")),
        );
      },
    );
  }
}
