import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/_core_/views/widgets/hippo_textfield.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/signup/viewmodels/sign_up_viewmodel.dart';
import 'package:payhippo/modules/authentication/signup/views/widgets/step_widget.dart';
import 'package:payhippo/modules/authentication/signup/views/widgets/titled_field.dart';
import 'package:provider/provider.dart';

List<Language> languages = [
  Language(locale: const Locale('en'), languageName: 'English'),
  Language(locale: const Locale('en', 'NG'), languageName: 'Pidgin')
];

class PersonalInfoPageOne extends StatefulWidget {
  const PersonalInfoPageOne(
      {super.key, required this.viewModel, required this.onSubmit});

  final SignupViewModel viewModel;
  final VoidCallback onSubmit;

  @override
  State<PersonalInfoPageOne> createState() => _PersonalInfoPageOneState();
}

class _PersonalInfoPageOneState extends State<PersonalInfoPageOne>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final Widget hippoLogo = Hero(
      tag: 'logo',
      child: Assets.images.hippoFullLogo
          .image(width: SizeConfig.blockSizeVertical * 15),
    );

    final Widget title = Hero(
      tag: 'step',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StepWidget(
            page: 1,
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
            context.l10n.gettingOnboard,
            maxLines: 2,
            minFontSize: 6,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              title: context.l10n.selectLanguage,
              child: HippoDropdownTextField<Language>(
                hintText: context.l10n.selectPreferedLanguage,
                prefixIcon: const Icon(Icons.translate),
                options: languages,
                getLabel: (p0) => p0.getLable(),
                onChanged: (Language language) {
                  widget.viewModel.formModel
                      .onLanguageChanged(language.languageName);
                  context.read<BaseViewModel>().setLocal(language);
                },
              ),
            ),
            TitledField(
              title: context.l10n.firstName,
              child: HippoTextField.stream(
                valueStream: widget.viewModel.formModel.firstNameStream,
                prefixIcon: const Icon(Icons.person),
                onChanged: widget.viewModel.formModel.onFirstNameChanged,
              ),
            ),
            TitledField(
              title: context.l10n.surname,
              child: HippoTextField.stream(
                valueStream: widget.viewModel.formModel.lastNameStream,
                prefixIcon: const Icon(Icons.person),
                onChanged: widget.viewModel.formModel.onLastNameChanged,
              ),
            ),
            TitledField(
              title: context.l10n.emailAddress,
              child: HippoTextField.stream(
                valueStream: widget.viewModel.formModel.emailStream,
                prefixIcon: const Icon(Icons.email),
                onChanged: widget.viewModel.formModel.onEmailChanged,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            HippoButton.stream(
                state: widget.viewModel.formModel.isFirstPageValid,
                text: context.l10n.continueText,
                onClick: widget.onSubmit)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
