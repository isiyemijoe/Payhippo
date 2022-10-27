import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/remote/composite_disposable_widget.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/signup/models/otp_screen_args.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/validate_otp_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/observers/generate_otp_observer.dart';
import 'package:payhippo/modules/authentication/signup/views/widgets/step_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with CompositeDisposableWidget {
  late final ValidateOtpViewModel _viewmodel;
  late final ValidateOtpResponseObserver _observer;
  late OTPScreenArgs? args;
  @override
  void initState() {
    _viewmodel = context.read<ValidateOtpViewModel>();
    _observer =
        ValidateOtpResponseObserver(context: context, viewModel: _viewmodel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as OTPScreenArgs?;

    final Widget hippoLogo = Assets.images.hippoFullLogo
        .image(width: SizeConfig.blockSizeVertical * 15);

    final Widget title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (args?.isSignup ?? false)
          const StepWidget(
            page: 3,
            totalPage: 3,
          )
        else
          const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        ),
        Text(
          context.l10n.enterOtp,
          style: context.textTheme.bodyMedium!
              .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 30,
        ),
        RichText(
            text: TextSpan(
          text: '${context.l10n.otpSent} ',
          children: [
            TextSpan(
              text: context.l10n.email,
              style: context.textTheme.bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            TextSpan(
              text: ', +234${_viewmodel.phoneNumber} ',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            TextSpan(text: context.l10n.and),
            TextSpan(
              text: ' ${context.l10n.whatsapp} ',
              style: context.textTheme.bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
          style: context.textTheme.bodyMedium!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
        )),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<bool>(
                valueListenable: _viewmodel.formModel.isValidatingOtp,
                builder: (context, snapshot, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hippoLogo,
                      const SizedBox(
                        height: 20,
                      ),
                      title,
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Pinput(
                          length: 6,
                          defaultPinTheme: AppThemes.defaultPinTheme,
                          focusedPinTheme: AppThemes.focusedTheme,
                          onChanged: _viewmodel.formModel.onOtpChanged,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      HippoButton.stream(
                          state: _viewmodel.formModel.isOtpPinValid,
                          text: context.l10n.continueText,
                          isLoading: _viewmodel.formModel.isValidatingOtp,
                          onClick: () {
                            _viewmodel
                                .validateOtp()
                                .listen(_observer.observe)
                                .disposedBy(this);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
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
