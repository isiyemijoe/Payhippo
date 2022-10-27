import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/authentication_manager.dart';
import 'package:payhippo/_core_/data/di.dart';
import 'package:payhippo/_core_/data/remote/composite_disposable_widget.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/route_observer.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/_core_/views/widgets/hippo_textfield.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/login/viewmodels/login_viewmodel.dart';
import 'package:payhippo/modules/authentication/login/views/observers/login_observer.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with CompositeDisposableWidget {
  late final LoginViewModel _viewmodel;
  late final LoginResponseObserver _observer;
  final _textController = TextEditingController();

  @override
  void initState() {
    _viewmodel = context.read<LoginViewModel>();
    _observer = LoginResponseObserver(context: context, viewModel: _viewmodel);
    _restoreState();
    super.initState();
  }

  void _restoreState() {
    if (_viewmodel.phoneNumber.isNotEmpty) {
      _textController.text = _viewmodel.phoneNumber;
      _viewmodel.formModel.onPhoneChanged(_viewmodel.phoneNumber);
    }
  }

  Widget get hippoLogo => Assets.images.hippoFullLogo
      .image(width: SizeConfig.blockSizeVertical * 15);

  Widget get title => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _viewmodel.isLoggedIn
                ? context.l10n.welcomeBack
                : context.l10n.welcome,
            style: context.textTheme.bodyMedium!.copyWith(
                fontSize: _viewmodel.isLoggedIn ? 18 : 25,
                fontWeight:
                    _viewmodel.isLoggedIn ? FontWeight.w400 : FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          AutoSizeText(
            _viewmodel.isLoggedIn
                ? _viewmodel.firstName
                : context.l10n.signInToContinue,
            minFontSize: 5,
            maxLines: 2,
            style: context.textTheme.bodyMedium!.copyWith(
                fontSize: _viewmodel.isLoggedIn ? 25 : 15,
                fontWeight:
                    _viewmodel.isLoggedIn ? FontWeight.w700 : FontWeight.w300),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const _AvailableOnWebWidget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hippoLogo,
                const SizedBox(
                  height: 40,
                ),
                title,
                const SizedBox(
                  height: 20,
                ),
                HippoTextField.phone(
                  controller: _textController,
                  valueStream: _viewmodel.formModel.phoneStream,
                  hintText: '9013957515',
                  onChanged: _viewmodel.formModel.onPhoneChanged,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: HippoButton.stream(
                          state: _viewmodel.formModel.isPageValid,
                          isLoading: _viewmodel.formModel.isLogginIn,
                          text: context.l10n.continueText,
                          onClick: () {
                            _viewmodel
                                .login()
                                .listen(_observer.observe)
                                .disposedBy(this);
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    if (_viewmodel.canUseBiometrics)
                      Container(
                        height: 56,
                        width: 56,
                        decoration: const BoxDecoration(
                          color: AppColors.blue5,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: IconButton(
                          iconSize: 32,
                          color: AppColors.blue0,
                          onPressed: () {
                            _viewmodel
                                .loginWithBiometrics()
                                .listen(_observer.observe)
                                .disposedBy(this);
                          },
                          icon: Assets.vectors.icFingerprint.svg(),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                if (_viewmodel.isLoggedIn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${context.l10n.notUser(_viewmodel.firstName)}?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRoute.onboarding, (route) => false);
                          locator.get<AuthenticationManager>().clearUserCache();
                        },
                        child: Text(context.l10n.signOut),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposeAll();
    super.dispose();
  }
}

class _AvailableOnWebWidget extends StatelessWidget {
  const _AvailableOnWebWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Launch Payhippo page
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 84,
        decoration: const BoxDecoration(
            color: AppColors.blue5,
            border: Border(
              top: BorderSide(color: AppColors.blue0, width: 0.3),
            )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.availableOnWeb,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                AutoSizeText(
                  context.l10n.quickLoans,
                  minFontSize: 8,
                  maxLines: 2,
                  style: context.textTheme.caption
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Assets.vectors.icWeb.svg()
        ]),
      ),
    );
  }
}
