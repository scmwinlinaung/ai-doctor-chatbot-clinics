import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback callback;
  final Color iconColor;
  const CustomBackButton(
      {super.key, required this.callback, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new, color: iconColor),
      onPressed: callback,
    );
  }
}
