import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FadeAndScaleAnimation extends HookWidget {
  const FadeAndScaleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);

    final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
    final scaleTween = Tween<double>(begin: 0.5, end: 1.0);

    useEffect(() {
      controller.forward();
      return () => controller.dispose();
    }, [controller]);

    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, value, child) {
        return Opacity(
          opacity: opacityTween.transform(value),
          child: Transform.scale(
            scale: scaleTween.transform(value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
