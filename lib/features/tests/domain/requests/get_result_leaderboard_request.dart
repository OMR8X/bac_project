class GetResultLeaderboardRequest {
  final int resultId;

  const GetResultLeaderboardRequest({required this.resultId});

  Map<String, dynamic> toJsonBody() {
    return {'p_result_id': resultId};
  }

  GetResultLeaderboardRequest copyWith({int? resultId}) {
    return GetResultLeaderboardRequest(resultId: resultId ?? this.resultId);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetResultLeaderboardRequest && other.resultId == resultId;
  }

  @override
  int get hashCode => resultId.hashCode;

  @override
  String toString() => 'GetResultLeaderboardRequest(resultId: $resultId)';
}
