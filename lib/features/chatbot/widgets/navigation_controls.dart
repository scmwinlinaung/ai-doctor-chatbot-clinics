import 'package:flutter/material.dart';

class NavigationControls extends StatelessWidget {
  final int currentPage;
  final int totalQuestions;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const NavigationControls({
    super.key,
    required this.currentPage,
    required this.totalQuestions,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFirstPage = currentPage == 0;
    // Corrected logic: The last page index is totalQuestions - 1.
    final bool isLastPage = currentPage == totalQuestions - 1;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          AnimatedOpacity(
            opacity: isFirstPage ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: TextButton.icon(
              onPressed: isFirstPage ? null : onPrevious,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back"),
              style:
                  TextButton.styleFrom(foregroundColor: Colors.grey.shade600),
            ),
          ),
          // Next/Submit Button
          ElevatedButton(
            onPressed: isLastPage ? onSubmit : onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(
              isLastPage ? "Finish" : "Next",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
