import 'package:flutter/material.dart';
import 'package:clinics/features/chatbot/models/chat_message_model.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:clinics/features/chatbot/widgets/custom_quill_editor.dart'; // Import for Quill

class MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final Animation<double> animation;

  const MessageBubble({
    super.key,
    required this.message,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUserMessage = message.author == ChatAuthor.user;

    final bubbleColor = isUserMessage
        ? theme.primaryColor
        : theme.colorScheme.surface;

    final textColor = isUserMessage
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;

    Widget messageContentWidget;
    if (message.author == ChatAuthor.ai && message.richTextDelta != null) {
      messageContentWidget = QuillEditor.basic(
        controller: QuillController(
          document: Document.fromDelta(message.richTextDelta!),
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true, // Make it read-only
        ),
        config: QuillEditorConfig(
          embedBuilders: [CustomDividerBuilder()],
          unknownEmbedBuilder: unknownEmbedBuilder(),
        ),
      );
    } else {
      // For user messages or AI messages without rich text, use a regular Text widget
      messageContentWidget = Text(
        message.text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: textColor,
          height: 1.4,
        ),
      );
    }

    final bubble = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
          bottomLeft: isUserMessage
              ? const Radius.circular(20)
              : const Radius.circular(0),
          bottomRight: isUserMessage
              ? const Radius.circular(0)
              : const Radius.circular(20),
        ),
      ),
      child: messageContentWidget, // Use the determined content widget here
    );

    final messageRow = Row(
      mainAxisAlignment: isUserMessage
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUserMessage) ...[
          CircleAvatar(
            backgroundColor: theme.colorScheme.surface,
            child: Icon(
              Icons.support_agent,
              size: 20,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(width: 8),
        ],
        bubble,
      ],
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: messageRow,
        ),
      ),
    );
  }
}
