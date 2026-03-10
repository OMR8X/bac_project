import 'package:equatable/equatable.dart';

class ResultAnswer extends Equatable {
  final int id;
  final int resultId;
  final int questionId;
  final int? optionId;

  const ResultAnswer({
    required this.id,
    required this.resultId,
    required this.questionId,
    this.optionId,
  });

  @override
  List<Object?> get props => [id, resultId, questionId, optionId];
}
