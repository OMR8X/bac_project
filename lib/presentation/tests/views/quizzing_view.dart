import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
// spaces resources not needed here
import 'package:bac_project/presentation/tests/blocs/quizzing_bloc.dart';
import 'package:bac_project/presentation/tests/views/quizzing_answer_view.dart';
import 'package:bac_project/presentation/tests/views/quizzing_result_view.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

class QuizzingView extends StatelessWidget {
  const QuizzingView({super.key, this.arguments});

  final TestingArguments? arguments;

  @override
  Widget build(BuildContext context) {
    final questions = arguments?.questions ?? <dynamic>[];

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
        body: SafeArea(
          child: Padding(
            padding: PaddingResources.screenSidesPadding,
            child: BlocBuilder<QuizzingBloc, QuizzingState>(
              builder: (context, state) {
                if (state is QuizzingLoading) return const Center(child: LoadingWidget());
                if (state is QuizzingAnswerQuestion) {
                  return QuizzingAnswerView(
                    state: state,
                    testMode: arguments?.testMode ?? TestMode.testing,
                  );
                }
                if (state is QuizzingResult) return QuizzingResultView(state: state);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
