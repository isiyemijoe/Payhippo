import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';
import 'package:payhippo/l10n/l10n.dart';

class TitledField extends StatelessWidget {
  const TitledField(
      {Key? key, required this.title, required this.child, this.margin = 20})
      : super(key: key);

  final String title;
  final Widget child;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.titleBlack),
        ),
        const SizedBox(
          height: 8,
        ),
        child,
        SizedBox(
          height: margin,
        ),
      ],
    );
  }
}
