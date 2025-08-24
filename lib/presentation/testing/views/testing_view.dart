import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';

import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/widgets/ui/fields/bottom_buttons_widget.dart';
import 'package:bac_project/presentation/tests/widget/question_card_widget.dart';
import 'package:bac_project/presentation/tests/widget/option_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/presentation/tests/blocs/quizzing_bloc.dart';

class TestingView extends StatelessWidget {
  const TestingView({super.key, this.arguments});

  final TestingArguments? arguments;

  @override
  Widget build(BuildContext context) {
    final questions = arguments?.questions ?? _sampleQuestions();
    final testMode = arguments?.testMode ?? TestMode.testing;

    return BlocProvider<QuizzingBloc>(
      create:
          (_) =>
              QuizzingBloc()..add(
                InitializeQuiz(
                  questions: questions.cast(),
                  timeLimit: arguments?.timeLimit ?? 30,
                  lessonId: arguments?.lessonIds?.length == 1 ? arguments!.lessonIds!.first : null,
                ),
              ),
      child: Scaffold(
        appBar: AppBar(
          // Using existing localization keys: reuse testProperties title for now
          title: Text("sl<LocalizationManager>().get(LocalizationKeys.testProperties.title)"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: PaddingResources.screenSidesPadding,
          child: Column(
            children: [
              const SizedBox(height: SpacesResources.s4),
              Expanded(
                child: ListView.separated(
                  itemCount: questions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: SpacesResources.s3),
                  itemBuilder: (context, index) {
                    final question = questions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QuestionCardWidget(question: question),
                        const SizedBox(height: SpacesResources.s2),
                        ...question.options.map((option) {
                          return OptionCardWidget(
                            option: option,
                            isSelected: false,
                            didAnswer: false,
                            testMode: testMode,
                            onTap: (_) {},
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
              BottomButtonWidget(onPressed: () {}, text: context.l10n.buttonsNext),
              const SizedBox(height: SpacesResources.s2),
            ],
          ),
        ),
      ),
    );
  }

  List<Question> _sampleQuestions() {
    return [
      Question(
        id: 1,
        lessonId: 1,
        text: 'Sample question 1: What is 2 + 2?',
        options: [
          const Option(id: 1, questionId: 1, text: '3', isCorrect: false),
          const Option(id: 2, questionId: 1, text: '4', isCorrect: true),
          const Option(id: 3, questionId: 1, text: '5', isCorrect: false),
          const Option(id: 4, questionId: 1, text: '6', isCorrect: false),
        ],
      ),
      Question(
        id: 2,
        lessonId: 1,
        text: 'Sample question 2: Which is a prime number?',
        options: [
          const Option(id: 5, questionId: 2, text: '4', isCorrect: false),
          const Option(id: 6, questionId: 2, text: '6', isCorrect: false),
          const Option(id: 7, questionId: 2, text: '7', isCorrect: true),
          const Option(id: 8, questionId: 2, text: '8', isCorrect: false),
        ],
      ),
    ];
  }
}
