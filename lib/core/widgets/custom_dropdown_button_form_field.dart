import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator? validator;

  const CustomDropdownButtonFormField(
      {super.key,
      required this.labelText,
      required this.icon,
      this.value,
      this.items,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      isExpanded: true,
      decoration: _buildDropdownDecoration(
        context: context,
        labelText: labelText,
        icon: icon,
      ),
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }

  InputDecoration _buildDropdownDecoration({
    required BuildContext context,
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.2),
      hintStyle: const TextStyle(color: Colors.white70),
      errorStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.redAccent,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: Colors.white38,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2.0,
        ),
      ),
    );
  }
}
