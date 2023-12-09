import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';

class ScrollArrowButton extends StatefulWidget {
  const ScrollArrowButton({
    super.key,
    required this.onPressed,
    this.color,
    this.size = ButtonHeight.medium,
  });

  final VoidCallback onPressed;
  final double size;
  final Color? color;

  @override
  _ScrollArrowButtonState createState() => _ScrollArrowButtonState();
}

class _ScrollArrowButtonState extends State<ScrollArrowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final ScrollController _scrollController = ScrollController();

  bool isArrowUp = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isArrowUp = !isArrowUp;

        if (isArrowUp) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        widget.onPressed();
      },
      child: RotationTransition(
        turns: _animation,
        child: Icon(
          Icons.keyboard_arrow_down,
          size: widget.size,
          color: widget.color,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
