import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sample/common/themes/sizes.dart';

class ScrollArrowButton extends HookWidget {
  const ScrollArrowButton({
    Key? key,
    required this.onPressed,
    this.color,
    this.size = ButtonHeight.medium,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isArrowUp = useState(false);
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final animation = useAnimation<double>(
      Tween<double>(
        begin: 0,
        end: 0.5,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      )),
    );

    return GestureDetector(
      onTap: () {
        isArrowUp.value = !isArrowUp.value;

        if (isArrowUp.value) {
          controller.forward();
        } else {
          controller.reverse();
        }

        onPressed();
      },
      child: RotationTransition(
        turns: AlwaysStoppedAnimation<double>(animation), // Explicit type
        child: Icon(
          Icons.keyboard_arrow_down,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
