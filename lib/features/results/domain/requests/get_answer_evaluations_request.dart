class GetAnswerEvaluationsRequest {
  final List<int> answerIds;

  const GetAnswerEvaluationsRequest({required this.answerIds});

  Map<String, dynamic> toJsonBody() {
    return {'p_answers_ids': answerIds};
  }

  GetAnswerEvaluationsRequest copyWith({List<int>? answerIds}) {
    return GetAnswerEvaluationsRequest(answerIds: answerIds ?? this.answerIds);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetAnswerEvaluationsRequest && other.answerIds == answerIds;
  }

  @override
  int get hashCode => answerIds.hashCode;

  @override
  String toString() => 'GetAnswerEvaluationsRequest(answerIds: $answerIds)';
}
