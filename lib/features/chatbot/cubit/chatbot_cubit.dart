import 'dart:convert'; // For jsonEncode
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/features/chatbot/models/chat_message_model.dart';
import 'package:injectable/injectable.dart';

// Import for the markdown parser itself
import 'package:markdown/markdown.dart' as md;
// Import for the converter class you found
import 'package:markdown_quill/markdown_quill.dart';

part 'chatbot_cubit.freezed.dart';
part 'chatbot_state.dart';

@injectable
class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(const ChatbotState());

  void onStarted({String? initialMessage, String? language}) {
    if (initialMessage != null &&
        initialMessage.isNotEmpty &&
        language != null &&
        language.isNotEmpty) {
      sendMessage(initialMessage, language);
    }
  }

  Future<void> sendMessage(String text, String language) async {
    final userMessage = ChatMessageModel(text: text, author: ChatAuthor.user);
    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isAiTyping: true,
      ),
    );

    try {
      final response = await DioClient.instance.post(
        ApiRoute.conversation,
        data: {'query': text, 'language': language},
      );

      // --- Start of CORRECT Markdown Conversion Logic ---

      // 1. Get the raw markdown string from the API response.
      final String aiPlainMarkdownResponse = response.data['answer'];

      // 2. Instantiate the markdown Document parser from the `markdown` package.
      //    Using GitHub Flavored Markdown is a good default for features like tables.
      final md.Document document = md.Document(
        encodeHtml: false,
        extensionSet: md.ExtensionSet.gitHubWeb,
      );

      // 3. Instantiate the `MarkdownToDelta` converter CLASS, passing the parser to it.
      final MarkdownToDelta converter = MarkdownToDelta(
        markdownDocument: document,
      );

      // 4. Call the `convert` method on the instance to get the Quill Delta object.
      final Delta richTextDelta = converter.convert(aiPlainMarkdownResponse);

      // 5. Convert the resulting Delta object to a JSON string for storage.
      final String richTextDeltaJson = jsonEncode(richTextDelta.toJson());

      // 6. Create the ChatMessageModel with the rich text data.
      final aiMessage = ChatMessageModel(
        text: aiPlainMarkdownResponse, // Keep plain text as a fallback.
        author: ChatAuthor.ai,
        richTextDeltaJson:
            richTextDeltaJson, // This will be used for rendering.
      );

      // --- End of Markdown Conversion Logic ---

      emit(
        state.copyWith(
          messages: [...state.messages, aiMessage],
          isAiTyping: false,
        ),
      );
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data['detail'] ??
          e.message ??
          "An unknown network error occurred.";
      final aiMessage = ChatMessageModel(
        text: "Error: $errorMessage",
        author: ChatAuthor.ai,
      );
      emit(
        state.copyWith(
          messages: [...state.messages, aiMessage],
          isAiTyping: false,
        ),
      );
    } catch (error) {
      final aiMessage = ChatMessageModel(
        text: "Error: ${error.toString()}",
        author: ChatAuthor.ai,
      );
      emit(
        state.copyWith(
          messages: [...state.messages, aiMessage],
          isAiTyping: false,
        ),
      );
    }
  }
}
