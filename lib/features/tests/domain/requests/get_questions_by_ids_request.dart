class GetQuestionsByIdsRequest {
  final List<int> questionIds;

  const GetQuestionsByIdsRequest({required this.questionIds});

  Map<String, dynamic> toJsonBody() {
    return {'p_questions_ids': questionIds};
  }

  GetQuestionsByIdsRequest copyWith({List<int>? questionIds}) {
    return GetQuestionsByIdsRequest(questionIds: questionIds ?? this.questionIds);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetQuestionsByIdsRequest && other.questionIds == questionIds;
  }

  @override
  int get hashCode => questionIds.hashCode;

  @override
  String toString() => 'GetQuestionsByIdsRequest(questionIds: $questionIds)';
}
