import 'package:flutter/material.dart';
import 'package:payhippo/_core_/views/animations/bottom_up_animations.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class TopBottomAnimaitons extends StatelessWidget {
  const TopBottomAnimaitons({
    super.key,
    required this.delay,
    required this.child,
    this.curve = Curves.easeOut,
  });

  final double delay;
  final Widget child;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final tween = TimelineTween<AniProp>()
      ..addScene(begin: 0.milliseconds, duration: 500.milliseconds)
          .animate(AniProp.opacity, tween: 0.0.tweenTo(1))
      ..addScene(begin: 0.milliseconds, end: 500.milliseconds).animate(
        AniProp.translateY,
        tween: (-30.0).tweenTo(0),
        curve: curve,
      );

    return PlayAnimation<TimelineValue<AniProp>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      builder: (context, child, value) => Transform.translate(
        offset: Offset(0, value.get(AniProp.translateY)),
        child: Opacity(opacity: value.get(AniProp.opacity), child: child),
      ),
      child: child,
    );
  }
}
