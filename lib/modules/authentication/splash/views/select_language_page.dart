import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/data/base_viewmodel.dart';
import 'package:payhippo/_core_/models/language.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/signup/views/pages/personal_infomation_one.dart';
import 'package:payhippo/modules/authentication/splash/viewmodels/select_language_viewmodel.dart';
import 'package:provider/provider.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  Widget get image => Assets.vectors.language.svg();

  late SelectLanguageViewmodel _viewmodel;
  @override
  void initState() {
    _viewmodel = context.read<SelectLanguageViewmodel>();
    super.initState();
  }

  Widget get title => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.chooseLanguage,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 6,
          ),
          AutoSizeText(
            context.l10n.changeLater,
            maxLines: 2,
            minFontSize: 6,
            style: context.textTheme.bodyMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    image,
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    title,
                    const SizedBox(
                      height: 30,
                    ),
                    StreamBuilder<Language>(
                        stream: _viewmodel.lang,
                        builder: (context, snapshot) {
                          return ListView.builder(
                              itemCount: languages.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final locale = languages[index];

                                final isSelected =
                                    languages[index] == snapshot.data;

                                final subtitle =
                                    languages[index] == languages[0]
                                        ? context.l10n.setLanguageEng
                                        : context.l10n.setLanguagePgn;

                                return ListTile(
                                  onTap: () {
                                    _viewmodel.onSelect(locale);
                                    context
                                        .read<BaseViewModel>()
                                        .setLocal(locale);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  tileColor: isSelected
                                      ? AppColors.blue0
                                      : Colors.white,
                                  title: Text(
                                    languages[index].languageName,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    subtitle,
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12),
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                );
                              });
                        }),
                  ],
                ),
              ),
              HippoButton.stream(
                state: Stream.value(true),
                text: context.l10n.continueText,
                onClick: () =>
                    Navigator.popAndPushNamed(context, AppRoute.onboarding),
              )
            ],
          ),
        ),
      ),
    );
  }
}
