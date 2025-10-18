// features/chatbot/cubits/questions_and_answer_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:clinics/core/api/dio_client.dart';
import 'package:clinics/core/config/api_route.dart';
import 'package:clinics/features/chatbot/models/question_and_answer_model.dart';

part 'questions_and_answers_state.dart';

class QuestionsAndAnswersCubit extends Cubit<QuestionsAndAnswersState> {
  QuestionsAndAnswersCubit() : super(const QuestionsAndAnswersState());

  Future<void> fetchQuestions({
    required String categoryId,
    required String subcategoryId,
  }) async {
    emit(
      state.copyWith(
        status: QuestionsAndAnswerStatus.loading,
        errorMessage: null,
      ),
    );
    try {
      final Response response = await DioClient.instance.get(
        ApiRoute.questions, // Assumes ApiRoute.questions = '/questions'
        queryParameters: {
          'categoryId': categoryId,
          'subcategoryId': subcategoryId,
        },
      );

      final dynamic data = response.data;
      if (data is! List) {
        throw Exception("Invalid data format from API: Expected a List.");
      }
      final List<QuestionAndAnswerModel> questions = (data)
          .map(
            (item) =>
                QuestionAndAnswerModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      emit(
        state.copyWith(
          status: QuestionsAndAnswerStatus.success,
          questions: questions,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: QuestionsAndAnswerStatus.failure,
          errorMessage: e.message ?? "An unknown network error occurred.",
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: QuestionsAndAnswerStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
