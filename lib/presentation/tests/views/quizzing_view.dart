import 'package:bac_project/core/services/router/index.dart';
import 'package:bac_project/core/widgets/ui/loading_widget.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/features/tests/domain/requests/add_result_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
// spaces resources not needed here
import 'package:bac_project/presentation/tests/blocs/quizzing/quizzing_bloc.dart';
import 'package:bac_project/presentation/tests/views/quizzing_answer_view.dart';
import 'package:bac_project/presentation/tests/views/quizzing_result_view.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:go_router/go_router.dart';

class QuizzingView extends StatelessWidget {
  const QuizzingView({super.key, this.arguments});

  final QuizzingArguments? arguments;

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
                  lessonId:
                      arguments?.lessonIds?.length == 1 ? arguments!.lessonIds!.firstOrNull : null,
                ),
              ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: PaddingResources.screenSidesPadding,
            child: BlocConsumer<QuizzingBloc, QuizzingState>(
              listener: (context, state) {
                if (state is QuizzingResultUploaded) {
                  context.pushReplacement(
                    AppRoutes.exploreResult.path,
                    extra: ExploreResultViewArguments(resultId: state.result.id),
                  );
                }
              },
              builder: (context, state) {
                if (state is QuizzingLoading) return const Center(child: LoadingWidget());
                if (state is QuizzingUploadingResult) return const Center(child: LoadingWidget());
                if (state is QuizzingFailedUploadingResult) {
                  return ErrorStateBodyWidget(
                    title: 'Failed to Upload Result',
                    failure: state.failure,
                    onRetry: () {
                      context.read<QuizzingBloc>().add(const RetryUploadResult());
                    },
                    onCancel: () {
                      context.pop();
                    },
                  );
                }

                if (state is QuizzingAnswerQuestion) {
                  return QuizzingAnswerView(
                    state: state,
                    testMode: arguments?.testMode ?? TestMode.testing,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
