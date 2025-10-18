part of 'chatbot_cubit.dart';

@freezed
class ChatbotState with _$ChatbotState {
  const factory ChatbotState({
    @Default([]) List<ChatMessageModel> messages,
    @Default(false) bool isAiTyping,
  }) = _ChatbotState;
}
