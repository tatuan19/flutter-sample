import 'package:flutter/material.dart';

class GreyButton extends StatelessWidget {
  const GreyButton({
    super.key,
    this.width = double.infinity,
    this.height,
    required this.onPressed,
    required this.child,
  });

  final double width;
  final double? height;
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
