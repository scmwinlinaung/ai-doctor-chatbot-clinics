// You can add this class at the bottom of your chatbot_screen.dart file

import 'package:flutter/material.dart';

class AnimatedTypingIndicator extends StatefulWidget {
  const AnimatedTypingIndicator({super.key});

  @override
  State<AnimatedTypingIndicator> createState() =>
      _AnimatedTypingIndicatorState();
}

class _AnimatedTypingIndicatorState extends State<AnimatedTypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(); // The controller will loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                // Create a staggered animation for each dot
                final dotAnimationValue = _controller.value * 3 - index;
                final clampedValue = dotAnimationValue.clamp(0.0, 1.0);

                // Use a curve to create a smooth "jump"
                final bounce =
                    -Curves.easeOut.transform(clampedValue.abs()) * 6;

                return Transform.translate(
                  offset: Offset(0, bounce),
                  child: Text(
                    '.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
