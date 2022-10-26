import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/_core_/views/widgets/hippo_textfield.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget get hippoLogo => Assets.images.hippoFullLogo
      .image(width: SizeConfig.blockSizeVertical * 15);

  Widget get title => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.welcome,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          AutoSizeText(
            context.l10n.signInToContinue,
            minFontSize: 5,
            maxLines: 2,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w300),
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
                const HippoTextField.phone(
                  valueStream: Stream.empty(),
                  hintText: '9013957515',
                ),
                const SizedBox(
                  height: 30,
                ),
                HippoButton.stream(
                    state: Stream.empty(),
                    text: context.l10n.continueText,
                    onClick: () {})
              ],
            ),
          ),
        ),
      ),
    );
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
