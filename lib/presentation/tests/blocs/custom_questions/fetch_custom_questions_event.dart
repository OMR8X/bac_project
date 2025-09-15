part of 'fetch_custom_questions_bloc.dart';

abstract class FetchCustomQuestionsEvent extends Equatable {
  const FetchCustomQuestionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCustomQuestionsByResult extends FetchCustomQuestionsEvent {
  final int resultId;

  const FetchCustomQuestionsByResult({required this.resultId});

  @override
  List<Object?> get props => [resultId];
}

class FetchCustomQuestionsByIds extends FetchCustomQuestionsEvent {
  final List<int> questionIds;

  const FetchCustomQuestionsByIds({required this.questionIds});

  @override
  List<Object> get props => [questionIds];
}

class FetchCustomQuestionsRetry extends FetchCustomQuestionsEvent {
  const FetchCustomQuestionsRetry();
}
