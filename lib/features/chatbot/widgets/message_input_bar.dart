import 'package:flutter/material.dart';

class MessageInputBar extends StatefulWidget {
  final ValueChanged<String> onSend;
  final bool isSendingEnabled;

  const MessageInputBar({
    super.key,
    required this.onSend,
    this.isSendingEnabled = true, // Default to enabled
  });

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  final _textController = TextEditingController();

  void _handleSend() {
    // Only send if the button is enabled and text is not empty
    if (!widget.isSendingEnabled) return;

    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _textController.clear();
      FocusScope.of(context).unfocus(); // Hide keyboard after sending
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.2),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  // Disable the text field as well when sending
                  enabled: widget.isSendingEnabled,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: theme.colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              const SizedBox(width: 8),
              // Use a CircleAvatar for a nicer button look
              CircleAvatar(
                backgroundColor: widget.isSendingEnabled
                    ? theme.primaryColor
                    : Colors.grey.shade400,
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  // Set onPressed to null to disable the button
                  onPressed: widget.isSendingEnabled ? _handleSend : null,
                ),
              ),
              const SizedBox(width: 4), // Small padding
            ],
          ),
        ),
      ),
    );
  }
}
