import 'package:flutter/material.dart';

class QuestionProgressIndicator extends StatelessWidget {
  final int currentPage;
  final int totalQuestions;

  const QuestionProgressIndicator(
      {required this.currentPage, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              'Question ${currentPage + 1}',
              key: ValueKey<int>(currentPage), // Key for smooth animation
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            ' of $totalQuestions',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentPage + 1) / totalQuestions,
                minHeight: 8,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
