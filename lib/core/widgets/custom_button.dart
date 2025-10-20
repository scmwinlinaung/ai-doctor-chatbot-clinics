import 'package:flutter/material.dart';
import 'package:clinics/core/config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool isLoading; // NEW: Added for loading state

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.isLoading = false, // Default to not loading
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,

        // Provide visual feedback when the button is disabled (during loading)
        disabledBackgroundColor: color.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      // If isLoading is true, onPressed becomes null, disabling the button
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          // If loading, show a styled CircularProgressIndicator
          ? SizedBox(
              height: 24.0,
              width: 24.0,
              child: CircularProgressIndicator(
                color: textColor,
                strokeWidth: 3.0,
              ),
            )
          // Otherwise, show the text
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
