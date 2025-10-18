import 'package:flutter/material.dart';
import 'package:clinics/features/chatbot/models/answer_model.dart';
import 'package:clinics/features/chatbot/models/question_and_answer_model.dart';
import 'package:clinics/features/chatbot/views/chatbot_screen.dart';
import 'package:clinics/features/chatbot/widgets/navigation_controls.dart';
import 'package:clinics/features/chatbot/widgets/question_page.dart';
import 'package:clinics/features/chatbot/widgets/question_progress_indicator.dart';

class QuestionView extends StatefulWidget {
  final String subcategoryName;
  final List<QuestionAndAnswerModel> questions;

  const QuestionView({
    super.key,
    required this.subcategoryName,
    required this.questions,
  });

  @override
  State<QuestionView> createState() => QuestionViewState();
}

class QuestionViewState extends State<QuestionView> {
  late final PageController _pageController;
  late final TextEditingController _additionalInfoController;
  int _currentPage = 0;
  final Map<String, Set<String>> _selectedAnswers = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _additionalInfoController = TextEditingController();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  void _onAnswerSelected(
    String questionId,
    AnswerModel answer,
    String questionType,
  ) {
    setState(() {
      final answerId = answer.id;
      _selectedAnswers.putIfAbsent(questionId, () => {});

      if (questionType == 'single-choice') {
        _selectedAnswers[questionId]!.clear();
        _selectedAnswers[questionId]!.add(answerId);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_currentPage < widget.questions.length) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        });
      } else {
        if (_selectedAnswers[questionId]!.contains(answerId)) {
          _selectedAnswers[questionId]!.remove(answerId);
        } else {
          _selectedAnswers[questionId]!.add(answerId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = widget.questions.length + 1;

    return Column(
      children: [
        QuestionProgressIndicator(
          currentPage: _currentPage,
          totalQuestions: totalPages,
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: totalPages,
            itemBuilder: (context, index) {
              if (index < widget.questions.length) {
                final question = widget.questions[index];
                return QuestionPage(
                  question: question,
                  selectedAnswerIds: _selectedAnswers[question.id] ?? {},
                  onAnswerSelected: (answer) => _onAnswerSelected(
                    question.id,
                    answer,
                    question.questionType,
                  ),
                );
              } else {
                return _AdditionalInfoPage(
                  controller: _additionalInfoController,
                );
              }
            },
          ),
        ),
        NavigationControls(
          currentPage: _currentPage,
          totalQuestions: totalPages,
          onNext: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          onPrevious: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          onSubmit: () {
            final List<String> selectedAnswerTextsEn = [];
            final List<String> selectedAnswerTextsMM = [];
            var index = 0;
            _selectedAnswers.forEach((questionId, answerIds) {
              final question = widget.questions.firstWhere(
                (q) => q.id == questionId,
              );
              if (question.answers.isNotEmpty) {
                selectedAnswerTextsEn.add(
                  "Question${index + 1} - ${question.question.en}\n",
                );
                selectedAnswerTextsMM.add(
                  "Question${index + 1} - ${question.question.mm}\n",
                );
                for (var i = 0; i < answerIds.length; i++) {
                  final answer = question.answers.firstWhere(
                    (a) => a.id == answerIds.elementAt(i),
                  );
                  selectedAnswerTextsEn.add(
                    "Answer${i + 1} - ${answer.text.en}.\n",
                  );
                  selectedAnswerTextsMM.add(
                    "Answer${i + 1} - ${answer.text.mm}.\n",
                  );
                }
              }
              index++;
            });

            String symptomsEn = selectedAnswerTextsEn.isNotEmpty
                ? '${widget.subcategoryName}\nQuestions And Answers:\n ${selectedAnswerTextsEn.join()}'
                : '';
            String symptomsMM = selectedAnswerTextsMM.isNotEmpty
                ? '${widget.subcategoryName}\nQuestions And Answers:\n ${selectedAnswerTextsMM.join()}'
                : '';

            final additionalInfo = _additionalInfoController.text.trim();
            String finalMessageEn = symptomsEn;
            String finalMessageMM = symptomsMM;

            if (additionalInfo.isNotEmpty) {
              if (finalMessageEn.isNotEmpty) {
                finalMessageEn += ' Additional details: $additionalInfo';
                finalMessageMM += ' Additional details: $additionalInfo';
              } else {
                finalMessageEn = additionalInfo;
                finalMessageMM = additionalInfo;
              }
            }

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatbotScreen(
                  initialMessageEn: finalMessageEn,
                  initialMessageMM: finalMessageMM,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AdditionalInfoPage extends StatelessWidget {
  final TextEditingController controller;

  const _AdditionalInfoPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Anything Else?',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Please describe any other symptoms or details you think might be relevant.',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controller,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'e.g., The pain is sharp and started this morning...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
