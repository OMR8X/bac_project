import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/widgets/ui/states/error_state_body_widget.dart';
import 'package:bac_project/core/widgets/ui/states/loading_state_body_widget.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/router/app_arguments.dart';
import 'package:go_router/go_router.dart';
import '../blocs/custom_questions/fetch_custom_questions_bloc.dart';

class FetchCustomQuestionsView extends StatelessWidget {
  const FetchCustomQuestionsView({super.key, this.arguments});

  final FetchCustomQuestionsArguments? arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final bloc = sl<FetchCustomQuestionsBloc>();
          if (arguments?.resultId != null) {
            bloc.add(FetchCustomQuestionsByResult(resultId: arguments!.resultId!));
          } else if (arguments?.questionIds != null) {
            bloc.add(FetchCustomQuestionsByIds(questionIds: arguments!.questionIds!));
          }
          return bloc;
        },
        child: BlocConsumer<FetchCustomQuestionsBloc, FetchCustomQuestionsState>(
          listener: (context, state) {
            if (state is FetchCustomQuestionsSuccess) {
              context.pushReplacement(
                AppRoutes.quizzing.path,
                extra: QuizzingArguments(questions: state.questions, lessonIds: state.lessonsIds),
              );
            }
          },
          builder: (context, state) {
            if (state is FetchCustomQuestionsFailed) {
              return _FetchCustomQuestionsErrorView(state: state);
            }
            return const _FetchCustomQuestionsLoadingView();
          },
        ),
      ),
    );
  }
}

// Loading State View Template
class _FetchCustomQuestionsLoadingView extends StatelessWidget {
  const _FetchCustomQuestionsLoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const LoadingStateBodyWidget());
  }
}

// Error State View Template
class _FetchCustomQuestionsErrorView extends StatelessWidget {
  const _FetchCustomQuestionsErrorView({required this.state});

  final FetchCustomQuestionsFailed state;

  @override
  Widget build(BuildContext context) {
    return ErrorStateBodyWidget(
      title: 'Failed to Load Questions',
      failure: UnknownFailure(message: state.message),
      onRetry: () {
        context.read<FetchCustomQuestionsBloc>().add(const FetchCustomQuestionsRetry());
      },
      onCancel: () {
        Navigator.of(context).pop();
      },
    );
  }
}
