import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:clinics/features/chatbot/models/answer_model.dart';
import 'package:clinics/features/chatbot/models/question_and_answer_model.dart';
import 'package:clinics/features/chatbot/widgets/answer_option.dart';
import 'package:clinics/features/chatbot/cubit/language_cubit.dart';

class QuestionPage extends StatelessWidget {
  final QuestionAndAnswerModel question;
  final Set<String> selectedAnswerIds;
  final ValueChanged<AnswerModel> onAnswerSelected;

  const QuestionPage({
    super.key,
    required this.question,
    required this.selectedAnswerIds,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, languageState) {
        final questionText =
            languageState.currentLanguage == 'mm' &&
                question.question.mm.isNotEmpty
            ? question.question.mm
            : question.question.en;

        final instructionText = languageState.currentLanguage == 'mm'
            ? (question.questionType == 'single-choice'
                  ? 'တစ်ခုကိုသာ ရွေးချယ်ပါ'
                  : 'သင့်လျော်သော အဖြေများကို ရွေးချယ်ပါ')
            : (question.questionType == 'single-choice'
                  ? 'Select one answer'
                  : 'Select all that apply');

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                instructionText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'You can skip the question',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              const SizedBox(height: 15),
              AnimationLimiter(
                child: Column(
                  children: List.generate(question.answers.length, (index) {
                    final answer = question.answers[index];
                    final answerText =
                        languageState.currentLanguage == 'mm' &&
                            answer.text.mm.isNotEmpty
                        ? answer.text.mm
                        : answer.text.en;
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: AnswerOption(
                            text: answerText,
                            isSelected: selectedAnswerIds.contains(answer.id),
                            onTap: () => onAnswerSelected(answer),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
