import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';

class GreyButton extends StatelessWidget {
  const GreyButton({
    super.key,
    this.width = double.infinity,
    this.height = ButtonHeight.medium,
    required this.onPressed,
    required this.child,
  });

  final double width;
  final double height;
  final Function onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), //
        ),
        child: child,
      ),
    );
  }
}
