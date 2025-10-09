import 'dart:ui';

import 'package:bac_project/core/resources/styles/border_radius_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/presentation/quizzing/widgets/multiple_choices_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/textual_options_builder_widget.dart';
import 'package:bac_project/presentation/quizzing/widgets/Orderable_options_builder_widget.dart';
import 'package:bac_project/presentation/tests/widgets/question_card_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/widgets/messages/snackbars/alert_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/informations_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/success_snackbar_widget.dart';
import '../../../core/widgets/messages/snackbars/error_snackbar_widget.dart';
import '../../../core/widgets/ui/icons/switch_theme_icon_widget.dart';

class DesigningView extends StatefulWidget {
  const DesigningView({super.key});

  @override
  State<DesigningView> createState() => _DesigningViewState();
}

class _DesigningViewState extends State<DesigningView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Designing'),
        actions: [
          SwitchThemeIconWidget(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: Paddings.customPadding(6, 6),
          child: TestSnackbars(),
        ),
      ),
    );
  }
}

class TestSnackbars extends StatelessWidget {
  const TestSnackbars({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showAlertSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Alert Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showInformationsSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Informations Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showSuccessSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Success Snackbar'),
        ),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showErrorSnackbar(context: context, title: 'Test', subtitle: 'Test');
          },
          child: Text('Show Error Snackbar'),
        ),
      ],
    );
  }
}

class TestOptionsDesign extends StatefulWidget {
  const TestOptionsDesign({super.key});

  @override
  State<TestOptionsDesign> createState() => _TestOptionsDesignState();
}

class _TestOptionsDesignState extends State<TestOptionsDesign> {
  late final Question multipleChoicesQuestion;
  late final Question textualQuestion;
  late final Question orderableQuestion;
  late final List<QuestionAnswer> questionsAnswers;
  @override
  void initState() {
    ///
    questionsAnswers = [
      // Multiple Choices Question
      QuestionAnswer(questionId: 1, optionId: 1, isCorrect: true),
      QuestionAnswer(questionId: 1, optionId: 2, isCorrect: false),

      // Orderable Question
      QuestionAnswer(questionId: 2, optionId: 1, answerText: 'Option 1', isCorrect: true),
      QuestionAnswer(questionId: 2, optionId: 2, answerText: 'Option 1', isCorrect: false),
      // Textual Question
      QuestionAnswer(questionId: 3, optionId: 1, answerPosition: 4, isCorrect: true),
      QuestionAnswer(questionId: 3, optionId: 2, answerPosition: 3, isCorrect: true),
      QuestionAnswer(questionId: 3, optionId: 3, answerPosition: 2, isCorrect: false),
      QuestionAnswer(questionId: 3, optionId: 4, answerPosition: 1, isCorrect: false),
    ];

    ///
    multipleChoicesQuestion = Question(
      id: 1,
      content: 'Multiple Choices Question',
      options: [
        Option(id: 1, questionId: 1, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 1, content: 'Option 2', isCorrect: false),
        Option(id: 3, questionId: 1, content: 'Option 3', isCorrect: false),
        Option(id: 4, questionId: 1, content: 'Option 4', isCorrect: false),
      ],
      lessonId: 1,
    );
    textualQuestion = Question(
      id: 2,
      content: 'Textual Question',
      options: [
        Option(id: 1, questionId: 2, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 2, content: 'Option 2', isCorrect: true),
        Option(id: 3, questionId: 2, content: 'Option 3', isCorrect: true),
        Option(id: 4, questionId: 2, content: 'Option 4', isCorrect: true),
      ],
      lessonId: 1,
    );
    orderableQuestion = Question(
      id: 3,
      content: 'Orderable Question',
      options: [
        Option(id: 1, questionId: 3, content: 'Option 1', isCorrect: true),
        Option(id: 2, questionId: 3, content: 'Option 2', isCorrect: true),
        Option(id: 3, questionId: 3, content: 'Option 3', isCorrect: true),
        Option(id: 4, questionId: 3, content: 'Option 4', isCorrect: true),
      ],
      lessonId: 1,
    );
    super.initState();
  }

  List<QuestionAnswer> _filterQuestionsAnswers(int questionId) {
    return questionsAnswers.where((answer) => answer.questionId == questionId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        MultipleChoicesQuestionBuilderWidget(
          question: multipleChoicesQuestion,
          questionsAnswers: _filterQuestionsAnswers(multipleChoicesQuestion.id),
          onSelectOption: (option) {
            ///
            questionsAnswers.removeWhere(
              (answer) => answer.questionId == multipleChoicesQuestion.id,
            );

            ///
            questionsAnswers.add(
              QuestionAnswer(questionId: multipleChoicesQuestion.id, optionId: option.id),
            );
            setState(() {});
          },
        ),
        TextualQuestionsBuilderWidget(
          // testMode: TestMode.testing,
          question: textualQuestion,
          questionsAnswers: _filterQuestionsAnswers(textualQuestion.id),
          onSubmitText: (option, value) {
            ///
            questionsAnswers.removeWhere((answer) {
              return answer.questionId == textualQuestion.id && answer.optionId == option.id;
            });

            ///
            questionsAnswers.add(
              QuestionAnswer(
                questionId: textualQuestion.id,
                answerText: value,
                optionId: option.id,
              ),
            );
            setState(() {});
          },
        ),
        OrderableQuestionBuilderWidget(
          testMode: TestMode.testing,
          question: orderableQuestion,
          questionsAnswers: _filterQuestionsAnswers(orderableQuestion.id),
          onSubmitOrder: (options) {
            ///
            questionsAnswers.removeWhere((answer) {
              return answer.questionId == orderableQuestion.id;
            });

            ///
            questionsAnswers.addAll(
              List.generate(
                options.length,
                (index) => QuestionAnswer(
                  questionId: orderableQuestion.id,
                  answerPosition: index,
                  optionId: options[index].id,
                ),
              ),
            );
            setState(() {});
          },
        ),
      ],
    );
  }
}
