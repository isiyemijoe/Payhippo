import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/styles/app_colors.dart';

class DotIndicator extends AnimatedWidget {
  const DotIndicator(
      {super.key,
      required this.indexListenable,
      required this.itemCount,
      this.color = AppColors.blue0,
      this.delay = Duration.zero})
      : super(listenable: indexListenable);

  final ValueListenable<int> indexListenable;

  final int itemCount;

  final Color color;

  final Duration delay;

  Widget _buildDot(int index) {
    final selectedPage = indexListenable.value;

    final selectedness = Curves.easeOut.transform(
      max(0, 1.0 - (selectedPage - index).abs()),
    );
    final zoom = 1.0 + (2.0 - 1.0) * selectedness;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.blue5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: 13 * zoom,
        height: 6,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 1),
        decoration: BoxDecoration(
          color: (selectedPage == index) ? color : AppColors.blue15,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // ignore: inference_failure_on_instance_creation
      future: Future.delayed(delay),
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(itemCount, _buildDot),
      ),
    );
  }
}
