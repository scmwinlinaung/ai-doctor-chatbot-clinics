// lib/features/chatbot/widgets/custom_quill_builders.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

/// A custom embed builder for displaying a horizontal divider ('---') in Quill.
class CustomDividerBuilder extends EmbedBuilder {
  @override
  String get key =>
      'divider'; // This must match the embed type from your Delta.

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    // Return the widget you want to display for the divider.
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}

/// A fallback builder for any embed type that is not supported.
class unknownEmbedBuilder extends EmbedBuilder {
  @override
  // The key for the unknown builder is not used for matching,
  // but it's required by the abstract class.
  String get key => 'unknown';

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    final node = embedContext.node;
    final data = node.value.data;

    // Log the unknown type for debugging purposes.
    if (kDebugMode) {
      print('Unknown embed type encountered: $data');
    }

    // Return a user-friendly placeholder widget.
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        'Unsupported content: $data',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red.shade800),
      ),
    );
  }
}
