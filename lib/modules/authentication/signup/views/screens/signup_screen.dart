import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/remote/composite_disposable_widget.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/observers/signup_observer.dart';
import 'package:payhippo/modules/authentication/signup/views/pages/personal_infomation_one.dart';
import 'package:payhippo/modules/authentication/signup/views/pages/personal_information_two.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with CompositeDisposableWidget {
  late final SignupViewModel _viewModel;
  final _pageController = PageController(initialPage: 0, keepPage: true);
  late final SignupResponseObserver _observer;

  @override
  void initState() {
    _viewModel = context.read<SignupViewModel>();
    _observer = SignupResponseObserver(
      context: context,
      viewModel: _viewModel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      PersonalInfoPageOne(
                        viewModel: _viewModel,
                        onSubmit: moveNext,
                      ),
                      PersonalInfoPageTwo(
                        viewModel: _viewModel,
                        onSubmit: onSubmit,
                        onBack: moveBack,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  void moveNext() {
    if ((_pageController.page ?? 0) < 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }

  void moveBack() {
    if ((_pageController.page ?? 0) >= 1) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }

  void onSubmit() {
    _viewModel.createAccount().listen(_observer.observe).disposedBy(this);
  }

  @override
  void dispose() {
    disposeAll();
    super.dispose();
  }
}
