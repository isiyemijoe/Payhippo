import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payhippo/_core_/utils/size_config.dart';
import 'package:payhippo/_core_/views/animations/fade_in_animation.dart';
import 'package:payhippo/_core_/views/app_route.dart';
import 'package:payhippo/_core_/views/styles/app_themes.dart';
import 'package:payhippo/_core_/views/widgets/dot_indicator.dart';
import 'package:payhippo/_core_/views/widgets/hippo_button.dart';
import 'package:payhippo/gen/assets.gen.dart';
import 'package:payhippo/l10n/l10n.dart';
import 'package:payhippo/modules/authentication/login/model/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late List<OnboardingPageData> pageData;
  final ValueNotifier<int> _scrollIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    loadOnboardingData(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: 64,
        ),
        decoration: BoxDecoration(
          color: const Color(0XFF0357EE).withOpacity(0.05),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  onPageChanged: (index, reason) => _scrollIndex.value = index,
                  height: double.infinity,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: pageData.map((e) => _OnboardingPage(data: e)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: DotIndicator(
                indexListenable: _scrollIndex,
                itemCount: 3,
                delay: const Duration(milliseconds: 100),
              ),
            ),
            const SizedBox(height: 27),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 41, bottom: 41),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -5),
                    blurRadius: 23,
                    color: const Color(0XFF003FAF).withOpacity(0.05),
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: HippoButton(
                        text: context.l10n.login,
                        onClick: () =>
                            Navigator.of(context).pushNamed(AppRoute.login)),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: HippoButton(
                        text: context.l10n.createAccount,
                        buttonStyle: AppThemes.primaryLightButtonStyle,
                        onClick: () =>
                            Navigator.of(context).pushNamed(AppRoute.signup)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadOnboardingData(BuildContext context) {
    pageData = [
      OnboardingPageData(
        title: context.l10n.instantLoans,
        description: context.l10n.instantLoanText,
        imageUrl: Assets.vectors.instantLoad.path,
      ),
      OnboardingPageData(
        title: context.l10n.noCollateral,
        description: context.l10n.noCollateralText,
        imageUrl: Assets.vectors.noCollateral.path,
      ),
      OnboardingPageData(
        title: context.l10n.seamlessProcess,
        description: context.l10n.seamlessProcessText,
        imageUrl: Assets.vectors.seamlessProcess.path,
      ),
    ];
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  double get imageWidth {
    if (SizeConfig.blockSizeHorizontal < 3.4) {
      return SizeConfig.blockSizeHorizontal * 70;
    }
    return SizeConfig.blockSizeHorizontal * 90;
  }

  double get imageHeight {
    if (SizeConfig.blockSizeHorizontal < 3.4) {
      return SizeConfig.blockSizeHorizontal * 50;
    }
    return SizeConfig.blockSizeHorizontal * 70;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            data.imageUrl,
            width: imageWidth,
            height: imageHeight,
          ),
          const SizedBox(height: 30),
          FadeInAnimations(
            delay: 0.5,
            child: Text(
              data.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeHorizontal * 6.15,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          FadeInAnimations(
            delay: 0.6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                data.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
