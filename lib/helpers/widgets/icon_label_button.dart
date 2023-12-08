import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';

class IconLabelButton extends StatelessWidget {
  const IconLabelButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.label,
    this.iconSize = 36,
    this.fontSize = FontSize.small,
    this.textColor = Colors.white,
    this.buttonColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String label;
  final double iconSize;
  final double fontSize;
  final Color textColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          iconSize: iconSize,
          color: buttonColor,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
