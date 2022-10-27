import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/remote/response_observer.dart';
import 'package:payhippo/_core_/network/resource.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/modules/authentication/login/viewmodels/login_viewmodel.dart';

class LoginResponseObserver extends ResponseObserver<Resource<bool?>> {
  LoginResponseObserver({required super.context, required this.viewModel});

  final LoginViewModel viewModel;

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
    viewModel.setIsAppFirstLaunch();

    locator<GlobalKey<NavigatorState>>().currentState?.pushNamed(
          AppRoute.otp,
        );
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
          child: Center(child: Text((error as Error).error.toString())),
        );
      },
    );
  }
}
