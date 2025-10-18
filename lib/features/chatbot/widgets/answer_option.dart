import 'package:flutter/material.dart';

class AnswerOption extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<AnswerOption> createState() => AnswerOptionState();
}

class AnswerOptionState extends State<AnswerOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().then((_) => widget.onTap());
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: widget.isSelected ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: widget.isSelected
                  ? Colors.blue.shade600
                  : Colors.grey.shade200,
              width: 2,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 10,
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: widget.isSelected
                        ? Colors.blue.shade800
                        : Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AnimatedOpacity(
                opacity: widget.isSelected ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
