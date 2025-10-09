class GetResultRequest {
  final int resultId;

  const GetResultRequest({required this.resultId});

  Map<String, dynamic> toJsonBody() {
    return {'p_result_id': resultId};
  }

  GetResultRequest copyWith({int? resultId}) {
    return GetResultRequest(resultId: resultId ?? this.resultId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetResultRequest && other.resultId == resultId;
  }

  @override
  int get hashCode => resultId.hashCode;

  @override
  String toString() => 'GetResultRequest(resultId: $resultId)';
}
