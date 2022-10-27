import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/l10n/l10n.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({
    Key? key,
    required this.page,
    required this.totalPage,
  }) : super(key: key);

  final int page;
  final int totalPage;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Step ',
        children: [
          TextSpan(
              text: page.toString(),
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: AppColors.blue0,
              )),
          TextSpan(text: '/${totalPage.toString()}')
        ],
        style: context.textTheme.bodyMedium!
            .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
      ),
    );
  }
}
