import 'dart:convert';
import 'package:flutter_quill/quill_delta.dart';

enum ChatAuthor { user, ai }

class ChatMessageModel {
  final String text; // For plain text, primarily user messages or AI fallback
  final String? richTextDeltaJson; // For AI rich text messages
  final ChatAuthor author;

  ChatMessageModel({
    required this.text,
    required this.author,
    this.richTextDeltaJson, // Make it optional
  });

  // Helper to get Delta if richTextDeltaJson is available
  Delta? get richTextDelta {
    if (richTextDeltaJson != null && richTextDeltaJson!.isNotEmpty) {
      try {
        return Delta.fromJson(jsonDecode(richTextDeltaJson!));
      } catch (e) {
        print("Error parsing richTextDeltaJson: $e");
        return null;
      }
    }
    return null;
  }
}
