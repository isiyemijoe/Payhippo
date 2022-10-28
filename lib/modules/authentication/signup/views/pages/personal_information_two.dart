import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/_core_/views/widgets/hippo_textfield.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/widgets/step_widget.dart';
import 'package:payhippo/modules/authentication/signup/views/widgets/titled_field.dart';

class PersonalInfoPageTwo extends StatefulWidget {
  const PersonalInfoPageTwo({
    super.key,
    required this.viewModel,
    required this.onBack,
    required this.onSubmit,
  });

  final SignupViewModel viewModel;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  @override
  State<PersonalInfoPageTwo> createState() => _PersonalInfoPageTwoState();
}

class _PersonalInfoPageTwoState extends State<PersonalInfoPageTwo>
    with AutomaticKeepAliveClientMixin {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Widget hippoLogo = Assets.images.hippoFullLogo
        .image(width: SizeConfig.blockSizeVertical * 15);

    final Widget title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StepWidget(
          page: 2,
          totalPage: 3,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          context.l10n.personalInformation,
          style: context.textTheme.bodyMedium!
              .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 6,
        ),
        AutoSizeText(
          context.l10n.helpUsKnow,
          maxLines: 2,
          minFontSize: 6,
          style: context.textTheme.bodyMedium!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: ValueListenableBuilder<bool>(
            valueListenable: widget.viewModel.formModel.isOnBoardingUser,
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
                  TitledField(
                    title: context.l10n.birthDate,
                    child: HippoTextField.date(
                      context: context,
                      readOnly: !snapshot,
                      controller: _controller,
                      onChanged: widget.viewModel.formModel.onBirthDateChanged,
                      hintText: '1997/06/19',
                      helperText: 'You must be 24 years and older',
                      lastDate:
                          DateTime.now().subtract(const Duration(days: 8760)),
                    ),
                  ),
                  TitledField(
                    title: context.l10n.phoneNumber,
                    margin: 0,
                    child: HippoTextField.phone(
                      readOnly: !snapshot,
                      valueStream: widget.viewModel.formModel.phoneStream,
                      hintText: "7013957515",
                      onChanged: widget.viewModel.formModel.onPhoneChanged,
                    ),
                  ),
                  TitledField(
                    title: context.l10n.referralCode,
                    child: HippoTextField.stream(
                      readOnly: !snapshot,
                      valueStream: widget.viewModel.formModel.referralStream,
                      prefixIcon: const Icon(Icons.widgets),
                      onChanged: widget.viewModel.formModel.onReferralChanged,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: AppColors.blue15,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.iconBlue,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: AutoSizeText(
                            context.l10n.onlyEnterReferral,
                            style: context.textTheme.bodyMedium
                                ?.copyWith(fontSize: 10),
                          ))
                        ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  HippoButton.stream(
                      state: widget.viewModel.formModel.isSecondPageValid,
                      text: context.l10n.continueText,
                      isLoading: widget.viewModel.formModel.isOnBoardingUser,
                      onClick: widget.onSubmit),
                  const SizedBox(
                    height: 20,
                  ),
                  HippoButton.stream(
                      buttonStyle: AppThemes.textButtonStyle,
                      state: Stream.value(true),
                      isLoading: widget.viewModel.formModel.isGeneratingOtp,
                      text: 'Back',
                      onClick: widget.onBack)
                ],
              );
            }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
