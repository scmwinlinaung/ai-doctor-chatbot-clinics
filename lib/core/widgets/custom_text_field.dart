import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        // Error messages can be hard to see with a glass UI,
        // so let's give them a more visible style.
        errorStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.redAccent,
        ),
      ),
      // Style for the text the user types
      style: const TextStyle(color: Colors.white),
    );
  }
}
