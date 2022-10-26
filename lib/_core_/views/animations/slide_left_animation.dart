import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/animations/bottom_up_animations.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class SlideInLeftAnimation extends StatelessWidget {
  const SlideInLeftAnimation({
    super.key,
    required this.delay,
    required this.child,
  });
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = TimelineTween<AniProp>()
      ..addScene(begin: 0.milliseconds, duration: 500.milliseconds)
          .animate(AniProp.opacity, tween: 0.0.tweenTo(1))
      ..addScene(begin: 0.milliseconds, end: 500.milliseconds).animate(
        AniProp.translateX,
        tween: (-50.0).tweenTo(0),
        curve: Curves.easeOut,
      );

    return PlayAnimation<TimelineValue<AniProp>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) => Transform.translate(
        offset: Offset(value.get(AniProp.translateX), 0),
        child: Opacity(opacity: value.get(AniProp.opacity), child: child),
      ),
      child: child,
    );
  }
}
