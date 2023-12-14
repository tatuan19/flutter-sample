import 'package:flutter/material.dart';
import 'package:sample/common/themes/sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: FontSize.large,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
