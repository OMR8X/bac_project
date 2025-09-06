part of 'fetch_custom_questions_bloc.dart';

abstract class FetchCustomQuestionsEvent extends Equatable {
  const FetchCustomQuestionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchCustomQuestionsByResult extends FetchCustomQuestionsEvent {
  final Result? result;

  const FetchCustomQuestionsByResult({this.result});

  @override
  List<Object?> get props => [result];
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
