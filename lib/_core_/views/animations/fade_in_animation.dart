import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import 'bottom_up_animations.dart';

class FadeInAnimations extends StatelessWidget {
  const FadeInAnimations({super.key, required this.delay, required this.child});
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = TimelineTween<AniProp>()
      ..addScene(begin: 0.milliseconds, duration: 500.milliseconds)
          .animate(AniProp.opacity, tween: 0.0.tweenTo(1));

    return PlayAnimation<TimelineValue<AniProp>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) =>
          Opacity(opacity: value.get(AniProp.opacity), child: child),
      child: child,
    );
  }
}
