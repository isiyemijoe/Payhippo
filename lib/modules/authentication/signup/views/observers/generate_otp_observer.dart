import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/remote/response_observer.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/validate_otp_viewmodel.dart';

class ValidateOtpResponseObserver extends ResponseObserver<Resource<bool?>> {
  ValidateOtpResponseObserver(
      {required super.context, required this.viewModel});

  final ValidateOtpViewModel viewModel;

  @override
  void observe(Resource<bool?> event) {
    if (event is Success) {
      _doOnSuccess();
    } else if (event is Error) {
      _doOnError(event);
    }
    super.observe(event);
  }

  void _doOnSuccess() {
    viewModel.setVerifiedState(true);

    locator<GlobalKey<NavigatorState>>()
        .currentState
        ?.pushNamedAndRemoveUntil(AppRoute.dashboard, (route) => false);
  }

  void _doOnError(error) {
    if (null == error) {
      return;
    }
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
