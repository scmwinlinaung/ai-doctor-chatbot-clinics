import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinics/core/widgets/custom_back_button.dart';
import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/core/widgets/loading_overlay.dart';
import 'package:clinics/features/chatbot/cubit/language_cubit.dart';
import 'package:clinics/features/chatbot/cubit/questions_and_answers_cubit.dart';
import 'package:clinics/features/chatbot/widgets/question_view.dart';

class QuestionScreen extends StatelessWidget {
  final String categoryId;
  final String subcategoryId;
  final String subcategoryName;

  const QuestionScreen({
    super.key,
    required this.categoryId,
    required this.subcategoryId,
    required this.subcategoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsAndAnswersCubit()
        ..fetchQuestions(categoryId: categoryId, subcategoryId: subcategoryId),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                subcategoryName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: CustomBackButton(
                callback: () => Navigator.of(context).pop(),
                iconColor: Theme.of(context).primaryColor,
              ),
            ),
            body: GradientBackground(
              child:
                  BlocBuilder<
                    QuestionsAndAnswersCubit,
                    QuestionsAndAnswersState
                  >(
                    builder: (context, state) {
                      switch (state.status) {
                        case QuestionsAndAnswerStatus.loading:
                          return const Center(child: LoadingWidget());
                        case QuestionsAndAnswerStatus.failure:
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Failed to load questions: $state',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () => context
                                      .read<QuestionsAndAnswersCubit>()
                                      .fetchQuestions(
                                        categoryId: categoryId,
                                        subcategoryId: subcategoryId,
                                      ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        case QuestionsAndAnswerStatus.success:
                          if (state.questions.isEmpty) {
                            return Center(
                              child: Text(
                                'No questions found.',
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            );
                          }
                          return QuestionView(
                            subcategoryName: subcategoryName,
                            questions: state.questions,
                          );
                        case QuestionsAndAnswerStatus.initial:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
