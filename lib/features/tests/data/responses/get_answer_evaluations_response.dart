import '../models/answer_evaluation_model.dart';
import '../../domain/entities/answer_evaluation.dart';

class GetAnswerEvaluationsResponse {
  final List<AnswerEvaluation> answerEvaluations;

  const GetAnswerEvaluationsResponse({required this.answerEvaluations});

  GetAnswerEvaluationsResponse copyWith({List<AnswerEvaluation>? answerEvaluations}) {
    return GetAnswerEvaluationsResponse(
      answerEvaluations: answerEvaluations ?? this.answerEvaluations,
    );
  }

  factory GetAnswerEvaluationsResponse.fromJson(Map<String, dynamic> json) {
    final answerEvaluations =
        (json['answers_evaluations'] as List).map((evaluation) {
          return AnswerEvaluationModel.fromJson(evaluation as Map<String, dynamic>);
        }).toList();

    return GetAnswerEvaluationsResponse(answerEvaluations: answerEvaluations);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetAnswerEvaluationsResponse && other.answerEvaluations == answerEvaluations;
  }

  @override
  int get hashCode => answerEvaluations.hashCode;

  @override
  String toString() => 'GetAnswerEvaluationsResponse(answerEvaluations: $answerEvaluations)';
}
