class GetResultQuestionsDetailsRequest {
  final int resultId;

  const GetResultQuestionsDetailsRequest({required this.resultId});

  Map<String, dynamic> toJsonBody() {
    return {'p_result_id': resultId};
  }

  GetResultQuestionsDetailsRequest copyWith({int? resultId}) {
    return GetResultQuestionsDetailsRequest(resultId: resultId ?? this.resultId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetResultQuestionsDetailsRequest && other.resultId == resultId;
  }

  @override
  int get hashCode => resultId.hashCode;

  @override
  String toString() => 'GetResultQuestionsDetailsRequest(resultId: $resultId)';
}
