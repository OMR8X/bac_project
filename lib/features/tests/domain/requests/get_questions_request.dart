class GetQuestionsRequest {
  final List<int> lessonsIds;

  const GetQuestionsRequest({required this.lessonsIds});

  GetQuestionsRequest copyWith({List<int>? lessonsIds}) {
    return GetQuestionsRequest(lessonsIds: lessonsIds ?? this.lessonsIds);
  }

  Map<String, dynamic> toJsonBody() {
    return {'p_lessons_ids': lessonsIds};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GetQuestionsRequest && other.lessonsIds == lessonsIds;
  }

  @override
  int get hashCode => lessonsIds.hashCode;

  @override
  String toString() => 'GetQuestionsRequest(lessonsIds: $lessonsIds)';
}
