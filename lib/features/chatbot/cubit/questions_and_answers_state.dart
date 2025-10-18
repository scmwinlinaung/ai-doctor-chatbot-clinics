part of 'questions_and_answers_cubit.dart';

enum QuestionsAndAnswerStatus { initial, loading, success, failure }

class QuestionsAndAnswersState extends Equatable {
  final QuestionsAndAnswerStatus status;
  final List<QuestionAndAnswerModel> questions;
  final String? errorMessage;

  const QuestionsAndAnswersState({
    this.status = QuestionsAndAnswerStatus.initial,
    this.questions = const [],
    this.errorMessage,
  });

  QuestionsAndAnswersState copyWith({
    QuestionsAndAnswerStatus? status,
    List<QuestionAndAnswerModel>? questions,
    String? errorMessage,
  }) {
    return QuestionsAndAnswersState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, questions, errorMessage];
}
